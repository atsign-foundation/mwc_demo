import 'package:flutter/material.dart';

void iotAtsignDialog(context, String iotAtsign,
    VoidCallback? Function(String atSign) newAtsign) {
  TextEditingController _textFieldController = TextEditingController();
  String iotAtsignNew = '';
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text(
              'Enter IoT @sign',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: TextField(
              onChanged: (value) {
                iotAtsignNew = value;
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: iotAtsign),
            ),
            actions: <Widget>[
              TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    newAtsign(iotAtsign);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    newAtsign(iotAtsignNew);
                  },
                  child: const Text('Enter'))
            ],
          ));
}
