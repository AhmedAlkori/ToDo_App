import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Share/components.dart';
import 'package:todo_app/todo_cubit/State.dart';

import '../todo_cubit/Cubit.dart';

class DoneScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<todoCubit,todoState>(
      listener: (context,state){},
      builder: (context,state)
      {
        todoCubit cubit=todoCubit.get(context);
        return  getListType(
            taskList: cubit.doneTask,
          indexColor: 1,
        );
      },

    );


  }
}
