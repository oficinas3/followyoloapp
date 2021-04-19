import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//providers
import '../providers/clients.dart';

//widgets
import '../widgets/client_widget.dart';

class ActiveUsersScreen extends StatelessWidget {
  static const routeName = '/active_users';

  Future<void> _refreshClients(BuildContext context) async {
    await Provider.of<Clients>(context, listen: false)
        .fetchAndSetActiveClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Active Users'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _refreshClients(context),
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
                onRefresh: () => _refreshClients(context),
                child: Consumer<Clients>(builder: (ctx, clientsData, child) {
                  if (clientsData.clients.length == 0) {
                    return Center(
                      child: Text(
                        'No active users',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: clientsData.clients.length,
                      itemBuilder: (ctx, i) =>
                          ClientWidget(clientsData.clients[i]),
                    );
                  }
                }),
              );
            }
          }
        },
      ),
    );
  }
}
