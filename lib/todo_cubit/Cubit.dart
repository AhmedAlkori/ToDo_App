import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/moduls/Done_Task.dart';
import 'package:todo_app/moduls/New_Task.dart';
import 'package:todo_app/todo_cubit/State.dart';

import '../moduls/Archive_Task.dart';

class todoCubit extends Cubit<todoState>
{
  todoCubit() : super(todoInitialState());

    static todoCubit get(context)=>BlocProvider.of(context);

    List<String> titles=[
      'New Task',
      'Done Task',
      'Archive Task',
    ];
  List<Color> colors=[
    Colors.lightGreen,
    Colors.lightBlue,
    Colors.grey,
  ];

    List<Widget> screens=[
      NewScreen(),
      DoneScreen(),
      ArchiveScreen(),
    ];

    int currentIndex=0;
    bool isBottomShow=false;
   late Database database;
   List<Map> allTask=[];
   List<Map> newTask=[];
   List<Map> doneTask=[];
  List<Map> archiveTask=[];

    void changeBottomState({
  required bool res,
})
    {
      isBottomShow=res;
      emit(todoChangeBottomState());
    }

    void changeBottomIndex({
  required int index,
})
    {
      currentIndex=index;
      emit(todoChangeBottomIndex());
    }

    Future createDB()  async
    {
         await openDatabase(
            'todo.db',
           version: 1,
           onCreate: (database,version)
           {
             print('DataBase Created');
             database.execute(
                 'CREATE TABLE Task (Id INTEGER Primary Key, Title Text, Time Text, Date Text, Statue Text)'
             ).then((value) {
               print('Table Created');
             }).catchError((error){
               print('error when create db');
             });
           },
           onOpen: (database)
             {
             getData(database);
               print('Database Opened');
             }
         ).then((value) {
           database=value;
           emit(todoCreateDBstate());
         });
    }

    Future AddData({
  required String title,
      required String time,
      required String date,
}) async
    {
   await  database.transaction((txn) async{
       await txn.rawInsert(
           'INSERT INTO Task (Title,Time,Date,Statue) VALUES ("$title","$time","$date","NEW")'
       ).then((value) {
         print('$value Inserted succefully');
         emit(todoInsertDataState());
          getData(database);
       }).catchError((error){
         print('error when insert data');
       });
     });
    }

    Future getData(database) async
    {
      newTask.clear();
      doneTask.clear();
      archiveTask.clear();
      await  database.rawQuery('SELECT * from Task').then((value) {
          allTask=value;
          allTask.forEach((element)
          {
            if(element['Statue'] == 'NEW')
              {
                newTask.add(element);
              }
            else if(element['Statue']=='DONE')
              {
               doneTask.add(element);
              }
            else
              {
                archiveTask.add(element);
              }
          });
          emit(todoGetDataState());
        });

    }


    void updateTask({
      required int id,
  required String statue,

})
    {
     database.rawUpdate(
         'Update Task set Statue = ? where Id = ? ',
       ['$statue',id],
     ).then((value) {
       print('$value updated succefully');
       emit(todoUpdateDataState());
       getData(database);
     }).catchError((error){
          print('error when update data');
     });
    }

    void deleteTask({
  required int id,
})
    {
     database.rawDelete(
         'DELETE FROM Task where Id= ?',
       [id],
     ).then((value) {
       print('$value deletet succefullty');
       emit(todoDeleteDataState());
       getData(database);
     }).catchError((error){
       print('error when delete');
     });
    }

}