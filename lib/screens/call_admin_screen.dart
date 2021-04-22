import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

class CallAdminScreen extends StatefulWidget {
  static const routeName = '/calladmin';

  @override
  _CallAdminScreenState createState() => _CallAdminScreenState();
}

class _CallAdminScreenState extends State<CallAdminScreen> {
  String reason;
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
      print('try da pagina call admin');
      statuscode =
          await Provider.of<User>(context, listen: false).callAdmin(reason);
    } catch (error) {
      print(error);
      errormessage = error;
      throw error;
    }

    if (statuscode == 200) {
      print('o call admin funcionou');
      setState(() {
        _isLoading = false;
      });
      _showConfirmDialog();
    } else {
      print('error');
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(statuscode);
    }
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmed!'),
        content: Text('Problem reported to a admin'),
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

  void _showErrorDialog(int statuscode) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error Occourred!'),
        content: Text(
            'It was not possible to send your message, try again later, status code: $statuscode'),
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
        title: Text('Call Admin'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Reason',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey[200], width: 5.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey[100], width: 2.0)),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please put some text";
                        }
                        return null;
                      },
                      maxLines: 3,
                      onSaved: (value) {
                        print('salvou');
                        reason = value;
                      },
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueGrey[400])),
                            onPressed: _submit,
                            child: Text('Submit'))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
