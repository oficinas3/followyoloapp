import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/rentrobot.dart';
import 'package:provider/provider.dart';

import '../main.dart';

import '../providers/rent.dart';
import '../providers/user.dart';

class RentScreen extends StatefulWidget {
  static const routeName = '/rent';

  @override
  _RentScreenState createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  //bool _isStart = true;
  //bool _firstTime = true;
  int i = 0;

  //final _stopWatch = new Stopwatch();
  //String _stopwatchText;
  Timer _timer;

  @override
  void initState() {
    var rentInfo = Provider.of<Rent>(context, listen: false);
    rentInfo.timer(0);
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      rentInfo.updateRentTime();
    });
    showNofitication('robot1');
    //_stopWatch.start();

    super.initState();
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
    String qrcode = Provider.of<RentedRobot>(context, listen: false).qrcode;
    int rentminutes = totalMinutes(
        Provider.of<Rent>(context, listen: false).getRentTimeSeconds());
    rentminutes++;

    try {
      statuscode = await Provider.of<User>(context, listen: false)
          .endRent(qrcode, rentminutes);
    } catch (error) {
      print(error);
      errorMessage = error;
      throw error;
    }

    if (statuscode == 200) {
      _timer.cancel();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build from scratch!');
    //var rentInfo = Provider.of<Rent>(context);
    /* setState(() {
      _stopwatchText = formatTime(_stopWatch.elapsedMilliseconds);
    }); */

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
            icon: Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Consumer<Rent>(builder: (context, data, child) {
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
                        Text('Online'),
                        Text(
                          'Robot Id',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(Provider.of<RentedRobot>(context, listen: false)
                            .qrcode),
                      ]),
                    ),
                  ),
                ),
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
                              onPressed: () {}, child: Text('Call Admin')),
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
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
