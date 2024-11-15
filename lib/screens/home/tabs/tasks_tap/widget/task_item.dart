import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_application/core/utiles/app_styles.dart';
import 'package:to_do_application/core/utiles/date_utlits.dart';
import 'package:to_do_application/dataase_manager/model/todo_dm.dart';
import 'package:to_do_application/dataase_manager/model/user_dm.dart';

class TaskItem extends StatelessWidget {
  TaskItem({super.key, required this.todo, required this.onDeletedTask});
  TodoDm todo;
  Function onDeletedTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              flex: 2,
              onPressed: (context) {
                deleteTodoFromFireStore(todo);
                onDeletedTask();
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              autoClose: true,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
            SlidableAction(
              flex: 2,
              onPressed: (context) {
                showEditDialog(context, todo);
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              autoClose: true,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(width: 7),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(todo.title, style: AppLightStyles.Tasktitle),
                  SizedBox(height: 4),
                  Text(todo.description, style: AppLightStyles.TaskDescriotion),
                  SizedBox(height: 4),
                  Text(DateTime.now().toFormattedDate, style: AppLightStyles.Taskdate),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  toggleTaskStatus(todo);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: todo.isDone ? Colors.green : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    todo.isDone ? Icons.check_circle : Icons.check,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleTaskStatus(TodoDm todo) async {
    todo.isDone = !todo.isDone; 

    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDm.collectionName);
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.update({'isDone': todo.isDone}); 
    onDeletedTask();
  }

  void deleteTodoFromFireStore(TodoDm todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDm.collectionName);
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.delete();
    onDeletedTask();
  }

  void showEditDialog(BuildContext context, TodoDm todo) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Task Title"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: "Task Description"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                todo.title = titleController.text;
                todo.description = descriptionController.text;

                CollectionReference todoCollection = FirebaseFirestore.instance
                    .collection(UserDm.collectionName)
                    .doc(UserDm.currentUser!.id)
                    .collection(TodoDm.collectionName);
                DocumentReference todoDoc = todoCollection.doc(todo.id);

                await todoDoc.update({
                  'title': todo.title,
                  'description': todo.description,
                });

                Navigator.of(context).pop();
                onDeletedTask();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
