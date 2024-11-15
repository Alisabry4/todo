import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_application/core/utiles/app_styles.dart';
import 'package:to_do_application/core/utiles/colors_managers.dart';
import 'package:to_do_application/core/utiles/date_utlits.dart';
import 'package:to_do_application/dataase_manager/model/todo_dm.dart';
import 'package:to_do_application/dataase_manager/model/user_dm.dart';
import 'package:to_do_application/screens/home/tabs/tasks_tap/widget/task_item.dart';
//import 'package:to_do_application/core/utiles/colors_managers.dart';
//import 'package:to_do_application/screens/home/tabs/tasks_tap/widget/task_item.dart';

// ignore: must_be_immutable
class TasksTab extends StatefulWidget {
   TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  List <TodoDm> todosList=[];
    @override

  void initState(){
    super.initState();
        getTodosFromFireStore();

  }

  @override
  Widget build(BuildContext context) {
    //if(todosList.isEmpty )getTodosFromFireStore();
    return Column(
      children: [
        Stack(children: [
                     Container(
                      height: 115.h,
                  color: ColorsManagers.blue,
                     ),
                              buildCalenderTimeLine(),        
                  // TaskItem(),
                ],
              ),
          Expanded(child: ListView.builder(itemBuilder: (context,index){
           return TaskItem(todo:todosList[index], onDeletedTask:(){ getTodosFromFireStore();}

            );
        },itemCount:todosList.length)),
      ],
    );    
  }

   Widget buildCalenderTimeLine()=>EasyInfiniteDateTimeLine(
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          focusDate: calenderSelectedDate,
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateChange: (selectedDate) {
   
          },
          itemBuilder: (context, date, isSelected, onTap) {
            return InkWell(
              onTap:(){
                calenderSelectedDate = date;
                getTodosFromFireStore();
                

              },
              child: Card(
                color: ColorsManagers.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                elevation: 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${date.day}',style: isSelected ? AppLightStyles.calenderSelectedItem :AppLightStyles.calenderUnSelectedItem),
                    Text('${date.getDayName}',style: isSelected ? AppLightStyles.calenderSelectedItem :AppLightStyles.calenderUnSelectedItem),
                  ],
                ),
              
              ),
            );
          },
        );
      void  getTodosFromFireStore()async{
         CollectionReference todoCollection = FirebaseFirestore.instance.collection(UserDm.collectionName).doc(UserDm.currentUser!.id).collection(TodoDm.collectionName);
        QuerySnapshot collectionSnapShot =await todoCollection.where('dateTime', isEqualTo:calenderSelectedDate.copyWith(    second: 0,
    millisecond: 0,
    hour: 0,
    minute: 0,
    microsecond: 0,
)).get();
       List<QueryDocumentSnapshot> documentsSnapShots = collectionSnapShot.docs;
      todosList =documentsSnapShots.map((docSnapshot){
       Map<String,dynamic>json= docSnapshot.data() as Map<String,dynamic>;
       TodoDm todo =TodoDm.fromFireStore(json);
       return todo; 
       },).toList();
      //  todosList =todosList.where((todo) =>todo.dateTime.day ==calenderSelectedDate.day &&
      //  todo.dateTime.month ==calenderSelectedDate.month&& todo.dateTime.year == calenderSelectedDate.year
      //  ,).toList();
       setState(() {
         
       });


        } 
}