import 'package:aylf/services/db_service.dart';
import 'package:aylf/services/models/Notification.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Notif> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if(noteList == null){
      noteList = List<Notif>();
      updateListView();
    }
    return Container();
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){

      Future<List<Notif>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList){
        setState((){
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });

    });
  }

}
