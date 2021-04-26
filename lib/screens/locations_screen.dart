import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//providers
import '../providers/locations.dart';

//widgets
import '../widgets/location_widget.dart';

class LocationsScreen extends StatelessWidget {
  static const routeName = '/locations';

  Future<void> _fetchLocations(BuildContext context) async {
    await Provider.of<Locations>(context, listen: false).fetchAndSetLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Tap to choose'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _fetchLocations(context),
        builder: (ctx, datasnapshot) {
          if (datasnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (datasnapshot.error != null) {
              return Center(
                child: Text('An error has occourred!\n ' +
                    datasnapshot.error.toString()),
              );
            } else {
              return Consumer<Locations>(
                builder: (ctx, locationData, child) => ListView.builder(
                  itemCount: locationData.locations.length,
                  itemBuilder: (ctx, i) =>
                      LocationWidget(locationData.locations[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
