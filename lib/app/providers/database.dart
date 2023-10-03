// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';
//
// import 'package:get/get.dart';
// // import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../models/basic/chat.dart';
// import '../models/basic/notification_app.dart';
//
// enum DatabaseTabel {
//   message,
// }
//
// Message? notificatin;
// Chat? chat;
//
// class TypeCoumn {
//   static const String integer = "INTEGER";
//   static const String real = "REAL";
//   static const String text = "TEXT";
// }
//
// class NotificationTable {
//   static String nameTable = 'notification';
//   static MetaColumn id = MetaColumn(name: 'id', type: TypeCoumn.integer);
//   static MetaColumn titleTemplet =
//       MetaColumn(name: 'titleTemplet', type: TypeCoumn.text);
//   static MetaColumn titleNotification =
//       MetaColumn(name: 'titleNotification', type: TypeCoumn.text);
//   static MetaColumn body = MetaColumn(name: 'body', type: TypeCoumn.text);
//   static MetaColumn summury = MetaColumn(name: 'summury', type: TypeCoumn.text);
// }
//
// class ChatTable {
//   static String nameTable = 'chat';
//
//   static MetaColumn id = MetaColumn(name: 'id', type: TypeCoumn.integer);
//   static MetaColumn containt =
//       MetaColumn(name: 'containt', type: TypeCoumn.text);
//   static MetaColumn idChat =
//       MetaColumn(name: 'idChat', type: TypeCoumn.integer);
//   static MetaColumn idEmp = MetaColumn(name: 'idEmp', type: TypeCoumn.integer);
//   static MetaColumn isRecive =
//       MetaColumn(name: 'isRecive', type: TypeCoumn.integer);
// }
//
// class MetaColumn {
//   String name;
//   String type;
//   MetaColumn({
//     required this.name,
//     required this.type,
//   });
// }
//
// class DatabaseServices {
//   static Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//
//     _database = await initDatabase();
//     return _database!;
//   }
//
//   Future<Database> initDatabase() async {
//     String path = await getDatabasesPath();
//     String dbPath = path + 'database.db'.toString();
//
//     return await openDatabase(
//       dbPath,
//       version: 1,
//       onCreate: _createDatabase,
//       onOpen: _onOpen,
//     );
//   }
//
//   Future<void> _createDatabase(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE  ${ChatTable.nameTable}  (
//          ${ChatTable.id.name} ${ChatTable.id.type} PRIMARY KEY  AUTOINCREMENT,
//         ${ChatTable.idChat.name} ${ChatTable.idChat.type} NOT Null ,
//            ${ChatTable.idEmp.name} ${ChatTable.idEmp.type} ,
//              ${ChatTable.containt.name} ${ChatTable.containt.type} ,
//              ${ChatTable.isRecive.name} ${ChatTable.isRecive.type}  CHECK(${ChatTable.isRecive.name}=1 or ${ChatTable.isRecive.name}=0)
//       )
//     ''');
//
//     await db.execute('''
//       CREATE TABLE  ${NotificationTable.nameTable} (
//           ${NotificationTable.id.name} ${NotificationTable.id.type} INTEGER PRIMARY KEY,
//        ${NotificationTable.titleTemplet.name} ${NotificationTable.titleTemplet.type},
//          ${NotificationTable.titleNotification.name} ${NotificationTable.titleNotification.type}  NOT Null,
//          ${NotificationTable.body.name} ${NotificationTable.body.type}  NOT Null,
//          ${NotificationTable.summury.name} ${NotificationTable.summury.type}
//       )
//     ''');
//
//     // Add more create table statements for other tables as needed
//   }
//
//   Future<int> insertData(String nameTable, Map<String, dynamic> data) async {
//     Database db = await database;
//     return await db.insert(nameTable, data);
//   }
//
//   Future<List<NotificationApp>> getAllDataNotification() async {
//     Database db = await database;
//     try {
//       var data = await db.query(NotificationTable.nameTable);
//       List<NotificationApp> notificatin =
//           data.map((e) => NotificationApp.fromMap(e)).toList();
//       return notificatin;
//     } catch (e) {
//       // print(e);
//       return [];
//     }
//   }
//
//   Future<List<Chat>> getAllDataChat() async {
//     Database db = await database;
//     try {
//       var data = await db.query(ChatTable.nameTable);
//       List<Chat> chat = data.map((e) => Chat.fromMapData(e)).toList();
//       return chat;
//     } catch (e) {
//       // print(e);
//       return [];
//     }
//   }
//
//   FutureOr<void> _onOpen(Database db) {
//     Get.log('open connection Database');
//   }
// }
