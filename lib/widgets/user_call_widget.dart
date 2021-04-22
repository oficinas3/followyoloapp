import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/clients.dart';
import '../providers/user.dart';
import '../providers/usercalls.dart';

class UserCallWidget extends StatefulWidget {
  final UserCall usercall;

  UserCallWidget(this.usercall);

  @override
  _UserCallWidgetState createState() => _UserCallWidgetState();
}

class _UserCallWidgetState extends State<UserCallWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.usercall.id),
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
      confirmDismiss: (direction) async {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Confirmation'),
                  content: Text('End ${widget.usercall.userName}\'s Calling?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ));
      },
      onDismissed: (direction) async {
        int statuscode = await Provider.of<User>(context, listen: false)
            .dismissUserCall(widget.usercall.id);
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
              trailing: Icon(Icons.tune),
              enabled: true,
              isThreeLine: true,
              title: Text(widget.usercall.userName),
              subtitle: Text(
                  'email: ${widget.usercall.userEmail} \n Reason: ${widget.usercall.reason}'),
            )
          ],
        ),
      ),
    );
  }
}
