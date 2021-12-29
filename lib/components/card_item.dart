import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cartItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final int? id;
  final Function? action;
  final Function? edit;
  final Function? delete;

  cartItem({
    this.title,
    this.subtitle,
    this.id,
    this.action,
    @required this.edit,
    @required this.delete,
  });

  @override
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
                      title!,
                      style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    subtitle: Text(
                      subtitle!,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onTap: () {
                      edit!();
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    if (action != null)
                      GestureDetector(
                        onTap: () async {
                          await action!();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.payments_outlined,
                              color: Colors.green[900], size: 24),
                        ),
                      ),
                    GestureDetector(
                      onTap: () async {
                        await delete!();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.close,
                            color: Colors.green[900], size: 24),
                      ),
                    )
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
