import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/moduls/New_Task.dart';
import 'package:todo_app/todo_cubit/Cubit.dart';
import 'package:todo_app/todo_cubit/State.dart';

import '../Share/components.dart';

class HomeLayout extends StatelessWidget {

  var keyScaff=GlobalKey<ScaffoldState>();
  var keyForm=GlobalKey<FormState>();
  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)=> todoCubit()..createDB(),
      child: BlocConsumer<todoCubit,todoState>(
        listener: (context,state){},
        builder: (context,state)
        {
          todoCubit cubit=todoCubit.get(context);
         return   Scaffold(
           key: keyScaff,
           appBar: AppBar(
             title: Text(
               '${cubit.titles[cubit.currentIndex]}'
             ),
           ),
           body: cubit.screens[cubit.currentIndex],
           floatingActionButton: FloatingActionButton(
             onPressed: ()
             {


                  if(cubit.isBottomShow)
                    {
                     if(keyForm.currentState!.validate())
                       {
                         cubit.AddData(
                             title: titleController.text,
                             time: timeController.text,
                             date: dateController.text);
                         cubit.changeBottomState(res: false);
                         Navigator.pop(context);
                       }
                     else
                       {

                       }

                    }
                  else
                    {
                      keyScaff.currentState?.showBottomSheet(
                              (context) => SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: keyForm,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children:
                                  [
                                    defaultText(
                                      label: 'Task Title',
                                      controller: titleController,
                                      prefix: Icons.title,
                                      type: TextInputType.text,
                                      validate: (value)
                                      {
                                        if (value!.isEmpty)
                                        {
                                          return 'Title must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultText(
                                      label: 'Task Time',
                                      controller: timeController,
                                      prefix: Icons.watch_later_outlined,
                                      type: TextInputType.datetime,
                                      validate: (value)
                                      {
                                        if (value!.isEmpty)
                                        {
                                          return 'Time must not be empty';
                                        }
                                        return null;
                                      },
                                      onClick: ()
                                      {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          print(value!.format(context).toString());
                                          timeController.text=value!.format(context).toString();
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultText(
                                      label: 'Task Date',
                                      controller: dateController,
                                      prefix: Icons.calendar_today_rounded,
                                      type: TextInputType.datetime,
                                      validate: (value)
                                      {
                                        if (value!.isEmpty)
                                        {
                                          return 'Date must not be empty';
                                        }
                                        return null;
                                      },
                                      onClick: ()
                                      {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:DateTime.parse('2022-09-06'),
                                        ).then((value) {
                                          print(DateFormat.yMMMd().format(value!).toString());
                                          dateController.text=DateFormat.yMMMd().format(value!).toString();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )).closed.then((value)
                      {
                            cubit.changeBottomState(res: false);
                      });

                      cubit.changeBottomState(res:true);
                    }

             },
             child: Icon(
               cubit.isBottomShow ? Icons.add : Icons.edit,
             ),
           ),

           bottomNavigationBar: BottomNavigationBar(
             currentIndex: cubit.currentIndex,
             onTap: (index)
             {
               cubit.changeBottomIndex(index: index);
             },
             items:
             [
               BottomNavigationBarItem(
                   icon: Icon(
                     Icons.menu,
                   ),
                   label: 'New Task'
               ),
               BottomNavigationBarItem(
                   icon: Icon(
                     Icons.check_box,
                   ),
                   label: 'Done Task'
               ),
               BottomNavigationBarItem(
                   icon: Icon(
                     Icons.archive,
                   ),
                   label: 'Archive Task'
               ),
             ],
           ),
         );
        },

      ),
    );
  }
}
