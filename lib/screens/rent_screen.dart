import 'dart:async';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../main.dart';

import '../providers/rent.dart';
import '../providers/robot.dart';
import '../providers/user.dart';

import './call_admin_screen.dart';

class RentScreen extends StatefulWidget {
  static const routeName = '/rent';

  @override
  _RentScreenState createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  bool isLost = false;

  //bool _isStart = true;
  //bool _firstTime = true;
  int i = 0;

  //final _stopWatch = new Stopwatch();
  //String _stopwatchText;
  Timer _timer;
  Timer _getfromserver;

  @override
  void initState() {
    var rentInfo = Provider.of<Rent>(context, listen: false);
    var robot = Provider.of<Robot>(context, listen: false);
    rentInfo.timer(0);
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      rentInfo.updateRentTime();
    });
    _getfromserver = new Timer.periodic(new Duration(seconds: 5), (timer) {
      robot.robotData().then((_) {
        if (robot.isLost()) {
          if (isLost == false) {
            //showNofitication('trocou');
            robotLostNotification();
          }
        }
        isLost = robot.isLost();
      });
    });
    //robotLostNotification();
    showNofitication('robot1');
    //_stopWatch.start();

    super.initState();
  }

  void _showForceCancelDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Force quit'),
        content: Text(
            'Are you sure you want force quit the rent? You will need to contact the admin to end the rent'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
          TextButton(
            onPressed: () {
              _getfromserver.cancel();
              _timer.cancel();
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              //Navigator.of(context)
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('End rent'),
        content: Text('Are you sure you want to end the rent?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _submit();
              //Navigator.of(context)
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    int statuscode = 0;
    String errorMessage = '';
    int robotid = Provider.of<Robot>(context, listen: false).robotId;
    //String qrcode = Provider.of<Robot>(context, listen: false).qrcode;
    int rentminutes = totalMinutes(
        Provider.of<Rent>(context, listen: false).getRentTimeSeconds());
    rentminutes++;

    try {
      statuscode = await Provider.of<User>(context, listen: false)
          .endRent(robotid, rentminutes);
    } catch (error) {
      errorMessage = error;
      print(errorMessage);
      throw error;
    }

    if (statuscode == 200) {
      _timer.cancel();
      _getfromserver.cancel();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build from scratch!');

    return WillPopScope(
      onWillPop: () async {
        _showConfirmDialog();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text('Rent'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.cancel_outlined),
            onPressed: () {
              _showForceCancelDialog();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Consumer<Rent>(builder: (context, data, child) {
                  //print(formatTime(data.getRentTimeSeconds()));

                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Rent Time',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(formatTime(data.getRentTimeSeconds()),
                              style: TextStyle(fontSize: 65)),
                          Text('Rent Cost'),
                          Text('U\$ ' +
                              ((((data.getRentTimeSeconds() / (30 * 60)))
                                          .ceil()) *
                                      10)
                                  .toString()),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Consumer<Robot>(builder: (context, data, child) {
                  return Container(
                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                              width: double.infinity,
                              child: Column(children: [
                                Text(
                                  'Robot Status',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(data.isLost() ? 'Lost' : 'Online'),
                                Text(
                                  'Robot Id',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(data.qrcode),
                              ]),
                            ),
                          ),
                        ),
                        if (data.isLost())
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'Select a point to send the robot',
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Colors.blueGrey[400])),
                                        onPressed: () {},
                                        child: Text('Portaria')),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Colors.blueGrey[400])),
                                        onPressed: () {},
                                        child: Text('Açogue'))
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Options',
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blueGrey[400])),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CallAdminScreen(),
                                  ),
                                );
                              },
                              child: Text('Call Admin')),
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blueGrey[400])),
                              onPressed: () {
                                _showConfirmDialog();
                                //Navigator.of(context).pop();
                              },
                              child: Text('End Rent')),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String totalCost(int time) {
  //double minutes = (time / 60);
  var temp = (time / 60) * 0.05; //5 centavos por minuto
  return temp.toString();
}

int totalMinutes(int time) {
  var milliseconds = time * 1000;
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600);
  var minutes = ((secs % 3600) ~/ 60);
  var seconds = (secs % 60);

  return minutes;
}

String formatTime(int time) {
  var milliseconds = time * 1000;
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

//https://github.com/rafaelitajahy/flutter-examples/blob/master/cronometro/lib/home.dart
//https://itnext.io/create-a-stopwatch-app-with-flutter-f0dc6a176b8a
//
//
//
//
//https://stackoverflow.com/questions/14946012/how-do-i-run-a-reoccurring-function-in-dart
//
