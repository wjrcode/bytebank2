import 'package:bytebank2/controller/contact_controller.dart';
import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final Contact? contact;

  const ContactForm({Key? key, this.contact}) : super(key: key);
  @override
  State<ContactForm> createState() => _ContactFormState(contact: contact);
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();

  final Contact? contact;

  _ContactFormState({this.contact});

  @override
  late ContactController controller;

  void initState() {
    super.initState();
    controller = ContactController(ContactDao(), context);
  }

  Widget build(BuildContext context) {
    if (contact != null) {
      controller.contactId(contact!.id);
      controller.controllerAccountNumber.text =
          contact!.accountNumber.toString();
      controller.controllerName.text = contact!.name.toString();
      _nameController.text = contact!.name.toString();
      _accountNumberController.text = contact!.accountNumber.toString();
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: null,
          iconTheme: IconThemeData(
            color: Colors.green[900],
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Text(
                          'Novo Contato',
                          style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    _buildTextFieldName(controller),
                    _buildTextFieldAccountNumber(controller),
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
                              'SALVAR',
                              style: TextStyle(
                                  color: Colors.green[900],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              await controller.save().then((saved) {
                                if (saved) {
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
          ),
        ));
  }
}

Widget _buildTextFieldName(ContactController controller) {
  return Padding(
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
            key: Key("keyTextFieldName"),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Nome',
            ),
            onSaved: controller.contactName,
            controller: controller.controllerName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe um Nome';
              }
              return null;
            },
          ),
        ),
      ),
    ),
  );
}

Widget _buildTextFieldAccountNumber(ContactController controller) {
  return Padding(
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
            key: Key("keyTextFieldName"),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Número da conta',
            ),
            onSaved: controller.contactAccountNumber,
            controller: controller.controllerAccountNumber,
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
  );
}
