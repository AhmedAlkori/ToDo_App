import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/layout/home_layot.dart';
import 'package:todo_app/todo_cubit/block_Observer/MyObserver.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());

}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
         theme: ThemeData(
           primarySwatch:Colors.lightGreen ,
           fontFamily: "Janna",
           scaffoldBackgroundColor: Colors.white,
           appBarTheme: AppBarTheme(
             titleTextStyle: TextStyle(
               color: Colors.white,
               fontFamily: "Janna",
               fontWeight: FontWeight.bold,
               fontSize: 16,
             ),

           ),

         ),
         home: HomeLayout(),
      );
  }

}
