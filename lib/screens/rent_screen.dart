import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';

class RentScreen extends StatefulWidget {
  static const routeName = '/rent';

  @override
  _RentScreenState createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  bool _isStart = true;
  bool _firstTime = true;

  final _stopWatch = new Stopwatch();
  String _stopwatchText;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {});
    });
    showNofitication('robot1');
    _stopWatch.start();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _stopwatchText = formatTime(_stopWatch.elapsedMilliseconds);
    });

    return Scaffold(
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
              Text(
                'Rent Time',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                _stopwatchText,
                style: TextStyle(fontSize: 72),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child:
                    ElevatedButton(onPressed: () {}, child: Text('Call Admin')),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _timer.cancel();
                      Navigator.of(context).pop();
                    },
                    child: Text('End Rent')),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String formatTime(int milliseconds) {
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