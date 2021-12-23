import 'package:bytebank2/models/contact.dart';
import 'package:bytebank2/models/response.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY,'
      '$_name TEXT,'
      '$_accountNumber INTEGER'
      ')';
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<Response> save(Contact contact) async {
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = toMap(contact);
    return await db.insert(_tableName, contactMap).then((id) {
      if (id > 0) {
        return Response.fromJson({
          "valido": true,
          "msg": "Contato cadastrado com sucesso!",
        });
      } else {
        return Response.fromJson({
          "valido": false,
          "msg": "Contato não foi cadastrado!",
        });
      }
    });
  }

  Future<Response> update(Contact contact) async {
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = toMap(contact);
    await db.update(
      _tableName,
      contactMap,
      where: '$_id = ?',
      whereArgs: [contact.id],
    );

    return Response.fromJson({
      "valido": true,
      "msg": "Contato alterado com sucesso!",
    });
  }

  Future<Response> delete(Contact contact) async {
    final Database db = await createDatabase();
    await db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [contact.id],
    );

    return Response.fromJson({
      "valido": true,
      "msg": "Contato deletado com sucesso!",
    });
  }

  Map<String, dynamic> toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    final List<Contact> contacts = [];

    toList(result, contacts);
    return contacts;
  }

  void toList(List<Map<String, dynamic>> result, List<Contact> contacts) {
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        id: row[_id],
        name: row[_name],
        accountNumber: row[_accountNumber],
      );
      contacts.add(contact);
    }
  }
}
