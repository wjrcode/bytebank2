import 'package:bytebank2/controller/contact_controller.dart';
import 'package:bytebank2/database/app_database.dart';
import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contact.dart';
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
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
          initialData: [],
          future: _dao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Loading'),
                      ),
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact?> contacts = snapshot.data as List<Contact?>;

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
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
                        child: ListBody(
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      contacts[index]!.name.toString(),
                                      style: TextStyle(
                                        color: Colors.green[900],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    subtitle: Text(
                                      contacts[index]!.accountNumber.toString(),
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ContactForm(
                                              contact: contacts[index]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        controller
                                            .contactId(contacts[index]!.id);
                                        await controller.delete();

                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.close,
                                            color: Colors.green[900], size: 24),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                    //final Contact? contact = contacts[index];
                    //return _ContactItem(contact);
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

class _ContactItem extends StatefulWidget {
  final Contact? contact;

  _ContactItem(this.contact);

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  @override
  late ContactController controller;

  void initState() {
    super.initState();
    controller = ContactController(ContactDao(), context);
  }

  Widget build(BuildContext context) {
    return Padding(
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
        child: ListBody(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      widget.contact!.name.toString(),
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    subtitle: Text(
                      widget.contact!.accountNumber.toString(),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ContactForm(contact: widget.contact),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        controller.contactId(widget.contact!.id);

                        setState(() async {
                          await controller.delete();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.close,
                            color: Colors.green[900], size: 24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
