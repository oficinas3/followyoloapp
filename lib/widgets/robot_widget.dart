import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/robots.dart';

class RobotWidget extends StatefulWidget {
  //final rbt.RobotItem robot;
  final Robot robot;

  RobotWidget(this.robot);

  @override
  _RobotWidgetState createState() => _RobotWidgetState();
}

class _RobotWidgetState extends State<RobotWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('robot_id: ${widget.robot.robotId}'),
            subtitle: Text(widget.robot.state),
          ),
        ],
      ),
    );
  }
}
