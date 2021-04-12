import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//providers
import '../providers/robots.dart';

//widgets
import '../widgets/robot_widget.dart';

class RobotScreen extends StatelessWidget {
  static const routeName = '/robots';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Robots'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<Robots>(context, listen: false).fetchAndSetRobots(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              print(dataSnapshot.error.toString());
              return Center(
                child: Text('An error occourred!'),
              );
            } else {
              return Consumer<Robots>(
                builder: (ctx, robotsData, child) => ListView.builder(
                  itemCount: robotsData.robots.length,
                  itemBuilder: (ctx, i) => RobotWidget(robotsData.robots[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
