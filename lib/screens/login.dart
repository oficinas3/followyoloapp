//porque eu usei um monte de widget do material design
import 'package:flutter/material.dart';

//ctrl + . : menu de refatoracao

class LoginScreen extends StatefulWidget {
  @override
  //_LoginScreenState createState() => _LoginScreenState();
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  //estado de que tipo?
  bool stayLoggedIn = false;

  void isLoggedIn() {
    setState(() {
      stayLoggedIn = !stayLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        //ele torna a tela uma deslizavel, vertical eh o padrao
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/banner1.png',
                  width: 300,
                  height: 300,
                ),
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                ),
                Card(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Password'),
                    obscureText: true,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: stayLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            stayLoggedIn = !stayLoggedIn;
                          });
                        }),
                    Text('Stay Logged In')
                  ],
                ),
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text('Create Account'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
