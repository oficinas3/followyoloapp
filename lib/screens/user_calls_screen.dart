import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//providers
import '../providers/usercalls.dart';

//widgets
import '../widgets/user_call_widget.dart';

class UserCallsScreen extends StatelessWidget {
  static const routeName = '/usercalls';

  Future<void> _refreshPage(BuildContext context) async {
    await Provider.of<UserCalls>(context, listen: false).fetchAndSetUserCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('User Calls'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _refreshPage(context),
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
              return RefreshIndicator(
                onRefresh: () => _refreshPage(context),
                child: Consumer<UserCalls>(
                  builder: (ctx, userCallsData, child) {
                    if (userCallsData.userCalls.length == 0) {
                      return Center(
                        child: Text(
                          'No User Call',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: userCallsData.userCalls.length,
                        itemBuilder: (ctx, i) =>
                            UserCallWidget(userCallsData.userCalls[i]),
                      );
                    }
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
