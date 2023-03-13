import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TransfertDialog {
  User? user;
  TransfertDialog({this.user});

  // pour visualiser la boite de dialogue
  void showTransfertDialog(BuildContext context) async {
    final _keyForm = GlobalKey<FormState>();
    String _carName = '';
    String _formError = 'Veillez fournir le nom de la voiture svp!';

    // Initial Selected Value
    String dropdownvalue = 'Item 1';

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final mobilHeight = MediaQuery.of(context).size.height * 0.25;
          final webHeight = MediaQuery.of(context).size.height * 0.5;
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                        key: _keyForm,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                icon: const Icon(Icons.person),
                                hintText: 'Enter your name',
                                labelText: 'Name',
                              ),
                            ),
                            TextFormField(
                              maxLength: 20,
                              onChanged: (value) => _carName = value,
                              validator: (value) =>
                                  _carName == '' ? _formError : null,
                              decoration: InputDecoration(
                                labelText: 'Nom de la voiture',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:50),
                              child: Container(
                                height: 50,
                                width: 250,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 1,
                                  ),
                                ),
                                child: DropdownButton(
                                  value: dropdownvalue,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black38),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black12,
                                  ),
                                  onChanged: (String? value) {
                                    dropdownvalue = value!;
                                  },
                                  items: items.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('ANNULER'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('PUBLIER'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  void onSubmit(context, keyForm, file, fileWeb, carName, user) async {}
}
