import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

//screens
import '../screens/rent_screen.dart';

//providers
import 'trash/rentrobot.dart';
import '../providers/user.dart';

class QRCodeReaderScreen extends StatefulWidget {
  static const routeNate = '/qrcodereader';

  @override
  _QRCodeReaderScreenState createState() => _QRCodeReaderScreenState();
}

class _QRCodeReaderScreenState extends State<QRCodeReaderScreen> {
  String qrCode = '';
  bool _didScan = false;
  String errorMessage = '';

  Future<void> _submit(String qrcode) async {
    int statuscode;

    try {
      statuscode =
          await Provider.of<User>(context, listen: false).startRent(qrcode);
    } catch (error) {
      print(error);
      errorMessage = error;
      throw error;
    }

    if (statuscode == 200) {
      Provider.of<RentedRobot>(context, listen: false).setQRCode(qrcode);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RentScreen(),
        ),
      );
    } else if (statuscode == 400) {
      _showErrorDialog(statuscode, errorMessage);
    }
  }

  void _confirmationDialog(String qrcode) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Please confirm'),
        content: Text(
          'Do you want do rent the robot with qrcode ' + qrcode + ' ?',
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
              _submit(qrcode);
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(int statuscodeError, String errormessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occourred!'),
        content: Text(
          'Status code: $statuscodeError \n' + errorMessage,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Rent'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '1. Scan QR Code',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'To Start the Rent, put the QRcode from the choosen robot on front of the camera',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _didScan
                            ? Text('$qrCode',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ))
                            : Image.asset(
                                'assets/images/qrcodereader.png',
                                width: 300,
                                height: 200,
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                colorBlendMode: BlendMode.modulate,
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              child: Text(qrCode != ''
                                  ? 'Scan Again'
                                  : 'Start QR Scan'),
                              onPressed: () {
                                scanQRCode();
                                return;
                              },
                            ),
                            if (qrCode != '-1' && qrCode != '')
                              ElevatedButton(
                                child: Text('Confirm'),
                                onPressed: () {
                                  //manda form
                                  //popup
                                  //troca de tela
                                  /* if (qrCode != '-1') {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => RentScreen(),
                                      ),
                                    );
                                  } */
                                  //_submit(qrCode);
                                  _confirmationDialog(qrCode);
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
        _didScan = true;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
