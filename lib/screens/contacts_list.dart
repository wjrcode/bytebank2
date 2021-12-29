import 'package:bytebank2/components/card_item.dart';
import 'package:bytebank2/components/progress.dart';
import 'package:bytebank2/controller/contact_controller.dart';
import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:bytebank2/screens/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contact_form.dart';

class ContactsList extends StatefulWidget {
  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();
  @override
  late ContactController controller;

  void initState() {
    super.initState();
    controller = ContactController(ContactDao(), context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Transferir'),
      ),
      body: FutureBuilder<List<Contact>>(
          initialData: [],
          future: _dao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact?> contacts = snapshot.data as List<Contact?>;

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact? contact = contacts[index];
                    return cartItem(
                      title: contacts[index]!.name.toString(),
                      subtitle: contacts[index]!.accountNumber.toString(),
                      id: contacts[index]!.id,
                      edit: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContactForm(contact: contacts[index]),
                              ),
                            )
                            .then((value) => setState(() {}));
                        ;
                      },
                      delete: () async {
                        controller.contactId(contacts[index]!.id);
                        await controller.delete();

                        setState(() {});
                      },
                      action: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TransactionForm(contact),
                          ),
                        );
                      },
                    );
                  },
                  itemCount: contacts.length,
                );
                break;
            }

            return Text('Unknown error');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ContactForm()))
            .then((value) => setState(() {})),
        child: Icon(Icons.add),
      ),
    );
  }
}
