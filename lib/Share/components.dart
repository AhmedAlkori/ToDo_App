import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo_cubit/Cubit.dart';

Widget defaultText({
  required String label,
  required TextEditingController controller,
  required IconData prefix,
  required TextInputType type,
  required FormFieldValidator<String>? validate,
  GestureTapCallback? onClick,
}) =>
    TextFormField(

      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
      ),
      validator: validate,
      onTap: onClick,
    );

Widget TaskListItem(Map model,context,colorIndex) =>Padding(

  padding: const EdgeInsets.all(20.0),

  child: Dismissible(
    key: Key(model['Id'].toString()),
    onDismissed: (direction)
    {
        todoCubit.get(context).deleteTask(id: model['Id']);
    },
    child: Row(

      children:

      [

        CircleAvatar(

          radius: 40.0,

          child: Padding(

            padding: const EdgeInsets.symmetric(

              horizontal: 5.0,

            ),

            child: Text(

              '${model['Time']}',


              style: TextStyle(

                fontSize: 16.0,
                  fontFamily: "Janna",
                fontWeight: FontWeight.bold,

                color: Colors.white,

              ),

            ),

          ),

        ),

        SizedBox(

          width: 10.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children:

            [

              Text(

                '${model['Title']}',

                style: TextStyle(

                  fontSize: 21.0,

                  fontWeight: FontWeight.bold,
                  fontFamily: "Janna",
                  color: Colors.white,

                ),

              ),

              Text(

                '${model['Date']}',

                style: TextStyle(

                  fontSize: 18.0,

                  color: Colors.grey[400],

                ),

              ),

              SizedBox(

                height: 10.0,

              ),

              Container(
                padding: EdgeInsets.only(
                  bottom: 5
                ),
                width: 80.0,

                height: 25.0,

                decoration: BoxDecoration(

                  borderRadius: BorderRadiusDirectional.only(

                    topStart: Radius.circular(5.0),

                    bottomEnd: Radius.circular(5.0),


                  ),

                  color: todoCubit.get(context).colors[colorIndex],

                ),

                child: Center(

                  child: Text(

                    '${model['Statue']}',

                    style: TextStyle(
                      
                      color: Colors.white,
                      fontFamily: "Janna",
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                      
                    ),

                  ),

                ),

              ),

            ],

          ),

        ),

        IconButton(

          onPressed: ()
          {
                  todoCubit.get(context).updateTask(
                      id: model['Id'],
                      statue: 'DONE');
          },

          icon: Icon(

            Icons.check_box,

            color: Colors.green,

          ),

        ),

        SizedBox(

          width: 10.0,

        ),

        IconButton(

          onPressed: ()
          {
            todoCubit.get(context).updateTask(
                id: model['Id'],
                statue: 'ARCHIVE');
          },

          icon: Icon(

            Icons.archive,

            color: Colors.white70,

          ),

        ),

      ],

    ),
  ),

);




Widget getListType({
  required List<Map> taskList,
  required int indexColor,
})=> ConditionalBuilder(
  condition: taskList.length > 0,
  builder: (context)=> ListView.separated(
      itemBuilder: (context,index)=>TaskListItem(taskList[index], context,indexColor),
      separatorBuilder:  (context,index)=>  Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[400],
      ),
      itemCount: taskList.length),
  fallback: (context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        Center(
          child: Container(

            child: Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),

          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(

            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);