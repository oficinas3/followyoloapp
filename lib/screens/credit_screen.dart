import 'package:flutter/material.dart';

class CreditScreen extends StatelessWidget {
  static const routeName = '/credit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        //leading: IconButton(
        //  icon: Icon(Icons.menu),
        //  onPressed: () {},
        //),
        title: Text('Put Credit'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: 'Card Number'),
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: 'Name'),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(hintText: 'Input Credit'),
                          ),
                          ElevatedButton(onPressed: () {}, child: Text('Pay'))
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
