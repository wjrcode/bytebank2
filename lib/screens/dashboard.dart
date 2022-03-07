import 'package:bytebank2/screens/contacts_list.dart';
import 'package:bytebank2/screens/transactions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashborad extends StatelessWidget {
  const Dashborad({
    Key? key,
  }) : super(key: key);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                _FeatureItem(
                  name: 'Transferir',
                  icon: Icons.monetization_on,
                  onClick: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ContactsList(),
                    ),
                  ),
                ),
                _FeatureItem(
                  name: 'Histórico',
                  icon: Icons.watch_later,
                  onClick: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TransactionsList(),
                    ),
                  ),
                ),
                _FeatureItem(
                  name: 'Histórico',
                  icon: Icons.watch_later,
                  onClick: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ContactsList(),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

_showContacts(context) {}

class _FeatureItem extends StatelessWidget {
  final String? name;
  final IconData? icon;
  final Function? onClick;

  const _FeatureItem({
    Key? key,
    this.name,
    this.icon,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 8.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: InkWell(
          onTap: () {
            onClick!();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5.0, 5.0),
                    blurRadius: 15.0,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5.0, -5.0),
                    blurRadius: 15.0,
                    spreadRadius: 1,
                  ),
                ]),
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: Colors.green[900], size: 24),
                  Text(
                    name!,
                    style: TextStyle(color: Colors.green[900], fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
