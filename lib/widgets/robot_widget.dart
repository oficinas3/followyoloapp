import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/robots.dart';

class RobotWidget extends StatefulWidget {
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
            leading: CircleAvatar(
              child: Icon(Icons.shopping_cart),
              backgroundColor: Colors.blueGrey[300],
              foregroundColor: Colors.white,
            ),
            isThreeLine: true,
            title: Text(widget.robot.qrcode),
            subtitle: Text(
                'ID: ${widget.robot.robotId} \nStatus: ${widget.robot.state}'),
          ),
        ],
      ),
    );
  }
}
