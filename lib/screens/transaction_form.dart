import 'package:bytebank2/http/webclient.dart';
import 'package:bytebank2/http/webclients/transaction_webclient.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:bytebank2/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact? contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: null,
        iconTheme: IconThemeData(
          color: Colors.green[900],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 16),
                  child: Text(
                    'Transferência',
                    style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      widget.contact!.name.toString(),
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade100,
                            offset: Offset(3, 3),
                            blurRadius: 3,
                            spreadRadius: -3),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _valueController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Valor',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe um Account Number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 15.0,
                            spreadRadius: 1),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-5.0, -5.0),
                            blurRadius: 15.0,
                            spreadRadius: 1),
                      ]),
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      key: Key("keySalvarButton"),
                      child: Text(
                        'TRANSFERIR',
                        style: TextStyle(
                            color: Colors.green[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        final double? value =
                            double.tryParse(_valueController.text);
                        final transactionCreated =
                            Transaction(value!, widget.contact!);
                        _webClient.save(transactionCreated).then((transaction) {
                          if (transaction != null) {
                            Navigator.pop(context);
                          }
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
