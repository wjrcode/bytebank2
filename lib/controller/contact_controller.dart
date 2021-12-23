import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactController {
  final BuildContext context;
  final ContactDao dao;

  var controllerName = new TextEditingController();
  var controllerAccountNumber = new TextEditingController();

  ContactController(this.dao, this.context);

  final formKey = GlobalKey<FormState>();

  Contact model = Contact();
  contactName(String? value) => model.name = value;
  contactId(int? value) => model.id = value;
  contactAccountNumber(String? value) =>
      model.accountNumber = int?.tryParse(value!);

  Future<bool> save() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    formKey.currentState!.save();

    try {
      if (model.id == null) {
        return await dao.save(model).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.msg),
            backgroundColor: value.valido ? Colors.green : Colors.red,
          ));
          return value.valido;
        });
      } else {
        return await dao.update(model).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.msg),
            backgroundColor: value.valido ? Colors.green : Colors.red,
          ));
          return value.valido;
        });
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete() async {
    try {
      return await dao.delete(model).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value.msg),
          backgroundColor: value.valido ? Colors.green : Colors.red,
        ));
        return value.valido;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }
}
