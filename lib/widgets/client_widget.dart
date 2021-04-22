import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/clients.dart';
import '../providers/user.dart';

class ClientWidget extends StatefulWidget {
  final Client client;

  ClientWidget(this.client);

  @override
  _ClientWidgetState createState() => _ClientWidgetState();
}

class _ClientWidgetState extends State<ClientWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.client.robotId),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Confirmation'),
                  content: Text('End ${widget.client.name}\'s Rent'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text('Ok'),
                    ),
                  ],
                ));
      },
      onDismissed: (direction) async {
        int statuscode = await Provider.of<User>(context, listen: false)
            .endRent(widget.client.robotId, 10);
        print('status code do dismiss $statuscode');
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
                backgroundColor: Colors.blueGrey[300],
                foregroundColor: Colors.white,
              ),
              trailing: Icon(Icons.tune_sharp),
              enabled: true,
              isThreeLine: true,
              title: Text(widget.client.name),
              subtitle: Text(
                  'email: ${widget.client.email} \nrobotid: ${widget.client.robotId}'),
              onLongPress: () {
                print('teste');
              },
            )
          ],
        ),
      ),
    );
  }
}
