import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locations.dart';
import '../providers/robot.dart';

class LocationWidget extends StatefulWidget {
  final Location location;

  LocationWidget(this.location);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  void _submit(String location) async {
    int statuscode;
    String errormessage = '';
    try {
      statuscode =
          await Provider.of<Robot>(context, listen: false).goto(location);
    } catch (error) {
      print(error);
      errormessage = error;
      throw error;
    }

    if (statuscode < 400) {
      _showSuccessDialog();
    } else if (statuscode == 400) {
      errormessage += ' Acess Denied';
      _showErrorDialog(errormessage);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Success!'),
        content: Text(
          'Robot successfully sent to ' + widget.location.name + ' location',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _confirmationDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Please confirm'),
        content: Text(
          'Do you want do send the robot to ' + widget.location.name + ' ?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _submit(widget.location.name);
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String errormessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occourred!'),
        content: Text(
          'error: ' + errormessage + '\n Try again later',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

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
            onTap: () {
              _confirmationDialog();
            },
            isThreeLine: false,
            title: Text(widget.location.name),
            subtitle: Text('X: ' +
                widget.location.x.toString() +
                ', Y: ' +
                widget.location.y.toString()),
          )
        ],
      ),
    );
  }
}
