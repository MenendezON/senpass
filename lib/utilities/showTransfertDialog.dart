import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:senpass/models/ticketModel.dart';
import 'package:senpass/services/dbServices.dart';
import 'package:senpass/utilities/shared-ui/showSnackBar.dart';

class TransfertDialog {
  User? user;
  int? numberTicket;
  TransfertDialog({this.user, this.numberTicket});

  // pour visualiser la boite de dialogue
  void showTransfertDialog(BuildContext context) async {
    final _keyForm = GlobalKey<FormState>();
    int _ticketNumber = 0;
    String _user1 = '';
    String _user2 = '';
    String _formError = 'Veillez fournir le nom de la voiture svp!';

    // List of items in our dropdown menu
    List<String> u1 = [user!.uid as String]; //?
    var u2 = ['gUXzCQalaFPcrN1lMh2XGcWXgGI2']; //menendezon@gmail.com

    // Initial Selected Value
    String u1Value = u1.first;
    String u2Value = u2.first;

    showDialog(
        context: context,
        builder: (BuildContext context) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                                child: Text(
                              'PARTAGER MES TICKETS',
                              style:
                                  TextStyle(letterSpacing: 1.5, fontSize: 16),
                            )),
                            const Gap(25),
                            DropdownButton(
                              value: u1Value,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black38, fontSize: 15),
                              underline: Container(
                                height: 0,
                                color: Colors.black12,
                              ),
                              onChanged: (String? value) {
                                u1Value = value!;
                              },
                              items: u1.map<DropdownMenuItem<String>>(
                                  (String value1) {
                                return DropdownMenuItem<String>(
                                  value: value1,
                                  child: Text(value1),
                                );
                              }).toList(),
                            ),
                            const Gap(10),
                            DropdownButton(
                              value: u2Value,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black38, fontSize: 15),
                              underline: Container(
                                height: 0,
                                color: Colors.black12,
                              ),
                              onChanged: (String? value) {
                                u2Value = value!;
                              },
                              items: u2.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            const Gap(10),
                            TextField(
                              style: TextStyle(fontSize: 15),
                              decoration: const InputDecoration(
                                  labelText: "Enter your number"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                            const Gap(15),
                          ],
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('ANNULER'),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {}, //=> onSubmit(context, _keyForm, _user1, _user2, _ticketNumber),
                            child: const Text('PARTAGER'),
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

  void onSubmit(context, _keyForm, _user1, _user2, _ticketNumber, _numberTicket) async {
    if (_keyForm.currentState!.validate()) {
      Navigator.of(context).pop();
      showNotification(context, "Chargement...");
      try {
        if(_numberTicket > _ticketNumber){
          showNotification(context, "Vous avez pas assez de ticket à partager");
        }else{
          //if()
        }
        DatabaseTicketService db = DatabaseTicketService();
        //db.addTicket();
      } catch (error) {
        showNotification(context, "Erreur $error");
      }
    }
  }
}
