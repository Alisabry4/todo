import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/core/utiles/app_styles.dart';
import 'package:to_do_application/core/utiles/date_utlits.dart';
import 'package:to_do_application/dataase_manager/model/todo_dm.dart';
import 'package:to_do_application/dataase_manager/model/user_dm.dart';

// ignore: must_be_immutable
class TaskBottomSheet extends StatefulWidget {

   TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
  //  static Widget show ()=> TaskBottomSheet();

  static Future show (BuildContext context){
   return showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (context){return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: TaskBottomSheet(),
    );
      }
    );
  }
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  TextEditingController titileController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  GlobalKey<FormState>formKey=GlobalKey();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.5,
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add New Task',textAlign: TextAlign.center,style: AppLightStyles.bottomSheetTitle,),
            SizedBox(height: 8,),
            TextFormField(
              validator: (input){
                if(input ==null||input.trim().isEmpty){
                return'plz enter task title';
              } 
              return null;},
              controller: titileController,
              decoration: InputDecoration(
                hintText: 'Enter your task',
                hintStyle: AppLightStyles.hintStyle
              ),
            ),
            SizedBox(height: 8,),
            TextFormField(
                            validator: (input){
                if(input ==null||input.trim().isEmpty){
                return'plz enter task decription';
              } 
              if(input.length<6){
                return 'sorry discrption should less 6 cahaacter';
              }
              return null;
                            },

              controller: discriptionController,
              decoration: InputDecoration(
                hintText: 'Enter your task description',
                hintStyle: AppLightStyles.hintStyle
              ),
            ),
            SizedBox(height: 12,),
            Text('Select Date',style: AppLightStyles.dateLabel,),
            SizedBox(height:8,),
            InkWell(
              onTap: (){
                // finction
                showTaskDatePicker();
              },
              child: 
            Text(selectedDate.toFormattedDate,textAlign: TextAlign.center,style: AppLightStyles.dateStyle,),),
            Spacer(),
            ElevatedButton(onPressed: (){
              addTaskToFireStore();
            }, child: Text('Add Task')),
        
          ],
        ),
      ),

      // width: double.infinity,
      // height: 100,
      // color: Colors.yellow,
      
    );

  }
  void showTaskDatePicker( )async {
  selectedDate =await showDatePicker(
    context: context,
  initialDate: DateTime.now(),
   firstDate: DateTime.now(),
    lastDate:DateTime.now().add(Duration(days: 365)),
  ) ??selectedDate;
  setState(() {
    
  });

}
addTaskToFireStore(){
  if(formKey.currentState!.validate()==false)return;
 CollectionReference collectionReference = FirebaseFirestore.instance.collection(UserDm.collectionName).doc(UserDm.currentUser!.id).collection(TodoDm.collectionName);
 DocumentReference documentReference = collectionReference.doc();
 TodoDm todo =TodoDm(id: documentReference.id, title: titileController.text, description: discriptionController.text,
  dateTime: selectedDate.copyWith(
    second: 0,
    millisecond: 0,
    hour: 0,
    minute: 0,
    microsecond: 0,
  ), isDone: false);
  documentReference.set(todo.toFireStore()).then((_){
        Navigator.pop(context);

  }).onError((error, stackTrace) {},)
  .timeout(const Duration(seconds: 4),onTimeout:(){
    if(context.mounted){
    Navigator.pop(context);
    }

  });

}

}

