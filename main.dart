import 'package:flutter/material.dart';
// I called my project 'flutter_database_operations'. You can update for yours.
import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text('query all', style: TextStyle(fontSize: 20),),
            onPressed: () {_queryall();},
          ),
          ElevatedButton(
            child: Text('query row', style: TextStyle(fontSize: 20),),
            onPressed: () {_queryrow();},
          ),
          ElevatedButton(
            child: Text('query cell', style: TextStyle(fontSize: 20),),
            onPressed: () {_querycell();},
          ),
        ],
      ),

    );
  }

  _queryall() async {

    // get a reference to the database
    Database db = await DatabaseHelper.instance.database;

    // get all rows
    List<Map> result = await db.query(DatabaseHelper.table);

    // get each row in the result list and print it
    result.forEach((row) => print(row));
  }

  _queryrow() async {

    // get a reference to the database
    Database db = await DatabaseHelper.instance.database;

    // get single row
    List<Map> result = await db.query(DatabaseHelper.table,
        columns: [DatabaseHelper.columnId, DatabaseHelper.columnName, DatabaseHelper.columnAge],
        where: '${DatabaseHelper.columnId} = ?',
        whereArgs: [1]);

    // get each row in the result list and print it
    result.forEach((row) => print(row));
  }

  _querycell() async {

    // get a reference to the database
    Database db = await DatabaseHelper.instance.database;

    // raw query
    List<Map> result = await db.rawQuery('SELECT age FROM my_table WHERE name=?', ['Mary']);

    // get each row in the result list and print it
    result.forEach((row) => print(row));
  }
}