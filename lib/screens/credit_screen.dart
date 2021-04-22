import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

class CreditScreen extends StatefulWidget {
  static const routeName = '/credit';

  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  double credit;
  var _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit() async {
    int statuscode;
    String errormessage;

    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      print('tentando colocar $credit');
      statuscode =
          await Provider.of<User>(context, listen: false).addBalance(credit);
    } catch (error) {
      print(error);
      errormessage = error;
      throw error;
    }

    if (statuscode == 200) {
      print('o deposito deu certo');
      setState(() {
        _isLoading = false;
      });
      _showConfirmDialog();
    } else {
      print('error');
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(errormessage, statuscode);
    }
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmed!'),
        content: Text('Sucessfully added U\$ $credit to your balance!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }

  void _showErrorDialog(String error, int statuscode) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error Occourred!'),
        content: Text(
            'It was not possible to put more credit, try again later, status code: $statuscode, error: ' +
                error),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Okay'),
          )
        ],
      ),
    );
  }

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
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Card Number',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey[200], width: 5.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey[100], width: 2.0)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Name',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey[200], width: 5.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey[100], width: 2.0)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Input Credit',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[200], width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey[100], width: 2.0),
                                ),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please put some number";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                credit = double.parse(value);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blueGrey[400])),
                                    onPressed: _submit,
                                    child: Text('Pay'),
                                  ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
