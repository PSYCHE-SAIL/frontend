import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:psychesail/components/text.dart';
import 'package:psychesail/model/emoji.dart';
import 'package:random_avatar/random_avatar.dart';

class User {
  final String name;
  final String email;
  User(this.name, this.email);
}

class UserProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  final List<bool> isSelected = [true, false];
  final List<bool> isSelectedWeekly = [true, false];
  final List<Map<String, Timestamp>> stressHistory = [];
  Emoji stressEmoji = Emoji();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>?;
    // Access individual parameters
    var currentUserId = args?['currentuser'] ?? "";
    var data = args?['historycollection'] ?? "";
    double sizeHeight = MediaQuery
        .of(context)
        .size
        .height;
    double sizeWidth = MediaQuery
        .of(context)
        .size
        .width;
    DocumentReference userdoc = _firestore.collection('customers').doc(currentUserId);



    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("History"),
          actions: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeWidth / 20),
                child: RandomAvatar(currentUserId,
                    trBackground: false, height: 50, width: 50))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: sizeWidth * sizeHeight * 0.00005),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: ToggleButtons(
                    constraints: BoxConstraints(minWidth: sizeWidth * 0.4),
                    color: Colors.white,
                    selectedColor: Color.fromRGBO(35, 154, 139, 75),
                    fillColor: Colors.green.shade900.withOpacity(0.3),
                    borderColor: Colors.transparent,
                    selectedBorderColor: Colors.black,
                    borderWidth: 3,
                    borderRadius: BorderRadius.circular(20.0),
                    onPressed: (int index) {
                      setState(() {
                        isSelected[index] = true;
                        isSelected[(index - 1).abs()] = false;
                      });
                    },
                    isSelected: isSelected,
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.all(sizeWidth * sizeHeight * 0.00002),
                        child: Text("History"),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.all(sizeWidth * sizeHeight * 0.00002),
                        child: Text("Progress"),
                      ),
                    ]),
              ),
              SizedBox(height: sizeHeight * 0.03),
              Container(
                height: sizeHeight * 0.7588,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: sizeWidth * 0.02),
                    child: buildBody(sizeWidth, sizeHeight, data)),
              ),
            ],
          ),
        ));
  }

  buildBody(sizeWidth, sizeHeight, data) {
    if (isSelected[0])
      return ListView.separated(
        reverse: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return historyContainer(sizeWidth, sizeHeight, false, data[index][0],
              data[index][1], stressEmoji.stressEmoji((index + 1).toString()));
        },
        separatorBuilder: ((context, index) =>
            SizedBox(
              height: min(sizeHeight * 0.05, 30),
            )),
      );
    else
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(0.8),
          child: Column( children: [Padding(
            padding: const EdgeInsets.only(top : 10.0, bottom: 30.0),
            child: ToggleButtons(
            constraints: BoxConstraints(minWidth: sizeWidth * 0.45),
              color: Colors.black,
              selectedColor: Color.fromRGBO(35, 154, 139, 100),
              fillColor: Colors.green.shade900.withOpacity(0.3),
              borderColor: Colors.black45,
              selectedBorderColor: Colors.black45,
              borderWidth: 2,
              borderRadius: BorderRadius.circular(20.0),
              onPressed: (int index) {
                setState(() {
                  isSelectedWeekly[index] = true;
                  isSelectedWeekly[(index - 1).abs()] = false;
                });
              },
              isSelected: isSelectedWeekly,
              children: [
                Padding(
                  padding:
                  EdgeInsets.all(sizeWidth * sizeHeight * 0.00004),
                  child: Text("Weekly"),
                ),
                Padding(
                  padding:
                  EdgeInsets.all(sizeWidth * sizeHeight * 0.00004),
                  child: Text("Monthly"),
                ),
              ]),
          )
            ,_buildUI(sizeHeight, sizeWidth, isSelectedWeekly)],),
        ),
      );
  }

  Widget _buildUI(sizeHeight, sizeWidth, isSelectedWeekly) {
    // return isSelectedWeekly[0]?_stressScoreGraph(sizeHeight,sizeWidth,true):_stressScoreGraph(sizeHeight,sizeWidth,false);
    var check = isSelectedWeekly[0]?true:false;
    return Center(
      child: SizedBox(
        width: sizeWidth,
        height: sizeHeight/2,
        child: Container(
          // foregroundDecoration: BorderRadius.circular(2.0),
          // color: Color.fromRGBO(10, 149, 120, 90),
          color: Colors.black,
          // height: sizeHeight /3, // Specify the height of the chart
          padding: EdgeInsets.symmetric(horizontal: sizeHeight/50, vertical: sizeWidth/25), // Add some padding
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true,
                drawHorizontalLine:(check)? true:false,
                drawVerticalLine: (check)?false:true,
                // horizontalInterval:(check)? 1 :0,
                // verticalInterval: (check)?0:1,
              ),
              // Hide the grid lines
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      if(value.toInt() == 0.0) {
                        return SizedBox.shrink();
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: sizeHeight/200),
                        child: Text(
                          '${value.toInt()}',
                          style: TextStyle(
                            fontFamily: "ABeeZee",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                    reservedSize: 3,
                    interval: 1,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      String title;
                      if (check) {
                        switch (value.toInt()) {
                          case 1:
                            title = 'Mon';
                            break;
                          case 2:
                            title = 'Tue';
                            break;
                          case 3:
                            title = 'Wed';
                            break;
                          case 4:
                            title = 'Thu';
                            break;
                          case 5:
                            title = 'Fri';
                            break;
                          case 6:
                            title = 'Sat';
                            break;
                          case 7:
                            title = 'Sun';
                            break;
                          default:
                            title = '';
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(title, style: TextStyle(
                              color: Colors.white, fontFamily: "ABeeZee"),),
                        );
                      }
                      else {
                        switch (value.toInt()) {
                          case 1:
                            title = 'Jan';
                            break;
                          case 2:
                            title = 'Feb';
                            break;
                          case 3:
                            title = 'Mar';
                            break;
                          case 4:
                            title = 'Apr';
                            break;
                          case 5:
                            title = 'May';
                            break;
                          case 6:
                            title = 'Jun';
                            break;
                          case 7:
                            title = 'Jul';
                            break;
                          case 8:
                            title = 'Aug';
                            break;
                          case 9:
                            title = 'Sep';
                            break;
                          case 10:
                            title = 'Oct';
                            break;
                          case 11:
                            title = 'Nov';
                            break;
                          case 12:
                            title = 'Dec';
                            break;
                          default:
                            title = '';
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(title, style: TextStyle(
                              color: Colors.white, fontFamily: "ABeeZee", fontSize: 10),),
                        );
                      }
                    },
                    reservedSize: 30,
                    interval: 1,// Adjust the size reserved for the bottom titles if necessary
                  ),
                ),
              ),
              borderData: FlBorderData(border: Border(top: BorderSide.none,
                right: BorderSide.none,
                left: BorderSide.none,
                // left: BorderSide(color: Colors.black45, width: 2.0),
                bottom: BorderSide(color: Colors.white60, width: 3.0),)),

              minX: 0,
              // Minimum value on the x-axis
              maxX: (check)?7:12,
              // Maximum value on the x-axis
              minY: 0,
              // Minimum value on the y-axis
              maxY: 5,
              // Maximum value on the y-axis (for stress level)
              lineBarsData: [
                LineChartBarData(
                  spots: check ? [
                    FlSpot(1, 3), // Data point for Monday
                    FlSpot(2, 4), // Data point for Tuesday
                    FlSpot(3, 1), // Data point for Wednesday
                    FlSpot(4, 2), // Data point for Thursday
                    FlSpot(5, 5), // Data point for Friday
                    FlSpot(6, 3), // Data point for Saturday
                    FlSpot(7 ,1), // Data point for Sunday
                  ]: [
                    FlSpot(1, 3), // Data point for  January
                    FlSpot(2, 4), // Data point for  February
                    FlSpot(3, 2), // Data point for  March
                    FlSpot(4, 2), // Data point for  April
                    FlSpot(5, 1), // Data point for  May
                    FlSpot(6, 2), // Data point for  June
                    FlSpot(7 ,3), // Data point for  July
                    FlSpot(8, 5), // Data point for  August
                    FlSpot(9, 3), // Data point for  September
                    FlSpot(10, 1), // Data point for October
                    FlSpot(11, 3), // Data point for November
                    FlSpot(12, 2), // Data point for December
                  ],
                  isCurved: true,
                  color: Color.fromRGBO(10, 149, 120, 90),
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 7.5,
                        color: _getDotColor(spot.y),
                        strokeWidth: 6,
                        strokeColor: Colors.transparent,
                      );
                    },),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Color.fromRGBO(20, 139, 120, 100),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Color _getDotColor(double yValue) {
    if (yValue == 1) {
      return Colors.green.shade800; // Low values
    } else if (yValue == 2) {
      return Colors.green.shade400; // Medium values
    }
    else if (yValue == 3) {
      return Colors.orange.shade300;
    }
    else if (yValue == 4) {
      return Colors.orange.shade800;
    } else {
      return Colors.red; // High values
    }
  }
}
