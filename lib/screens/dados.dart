import 'package:flutter/material.dart';

class ClientDataFromForm extends StatelessWidget {
  String name;
  String email;
  String phone;
  String address;
  String cpf;
  String password;
  String confirmpassword;

  ClientDataFromForm(
      this.name, this.email, this.phone, this.address, this.cpf, this.password);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name),
        Text(email),
        Text(phone),
        Text(address),
        Text(cpf),
        Text(password),
        Text(confirmpassword),
      ],
    );
  }
}
