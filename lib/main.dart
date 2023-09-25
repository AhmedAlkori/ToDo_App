import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/layout/home_layot.dart';
import 'package:todo_app/todo_cubit/block_Observer/MyObserver.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());

}
//Main Point
class MyApp extends StatelessWidget{
  @override

  Widget build(BuildContext context)
  {
    Color my=Colors.lightGreen;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
         theme: ThemeData(
           fontFamily: 'Janna',
          primarySwatch:Colors.teal,
           scaffoldBackgroundColor: HexColor('001C30'),
           appBarTheme: AppBarTheme(
             titleSpacing: 20.0,
             elevation: 0.0,
             color: HexColor('001C30'),
             iconTheme: IconThemeData(
               color: HexColor('DAFFFB'),
             ),
             titleTextStyle: TextStyle(
               color: Colors.white,
               fontFamily: 'Janna',
               fontWeight: FontWeight.bold,
               fontSize: 18.0,
             ),
             systemOverlayStyle: SystemUiOverlayStyle(
               statusBarIconBrightness: Brightness.light,
               statusBarColor: HexColor('001C30'),

             ),
           ),

           textTheme: TextTheme(
             bodySmall:  TextStyle(
               color:  Colors.grey,
               fontSize: 14.0,
               fontFamily: 'Janna',
             ),
             bodyMedium: TextStyle(
               color:  HexColor('333739'),
             ),
           ),
           bottomNavigationBarTheme: BottomNavigationBarThemeData(
             backgroundColor: HexColor('176B87'),
             selectedItemColor: Colors.white,
             selectedIconTheme: IconThemeData(
               color: Colors.white
             ),
             selectedLabelStyle: TextStyle(
               color: Colors.white,
               fontSize: 16

             ),
             unselectedIconTheme:  IconThemeData(
                 color: HexColor('191717')
             ),
             unselectedLabelStyle:TextStyle(
                 color: Colors.white,
                 fontSize: 14

             ),
           ),
           floatingActionButtonTheme: FloatingActionButtonThemeData(
             backgroundColor: HexColor('176B87')
           ),


         ),
         home: HomeLayout(),
      );
  }

}
