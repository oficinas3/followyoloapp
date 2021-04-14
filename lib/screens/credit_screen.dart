import 'package:flutter/material.dart';
import 'package:flutter_app/providers/user.dart';
import 'package:provider/provider.dart';

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
      throw error;
    }

    if (statuscode == 200) {
      print('o deposito deu certo');
      _showConfirmDialog();
      setState(() {
        _isLoading = false;
      });
    } else {
      print('error');
      _showErrorDialog();
      setState(() {
        _isLoading = false;
      });
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

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error Occourred!'),
        content:
            Text('It was not possible to put more credit, try again later'),
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
                Form(
                  key: _formKey,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(hintText: 'Input Credit'),
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
                            _isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
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
