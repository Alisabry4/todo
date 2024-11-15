import 'package:flutter/material.dart';
import 'package:to_do_application/screens/home/tabs/settings_tab.dart';
import 'package:to_do_application/screens/home/tabs/tasks_tap/tasks_tab.dart';
import 'package:to_do_application/screens/home/task_bottom_sheet/taskBottom_sheet.dart';
//import 'package:to_do_application/core/utiles/app_styles.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey <TasksTabState> tasksTabkey =GlobalKey();
  List <Widget> tabs = [
    // TasksTab(),
    // SettingsTab(),

  ];
    @override

  void initState(){
    super.initState();
    tabs =[
      TasksTab(key: tasksTabkey,),
    SettingsTab(),
    ];
  }
  int currentIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,// زرار button يبقي اللون مغطي وراه

      appBar:AppBar(
        title: Text('ToDo List'),
        //titleTextStyle: AppLightStyles.appBarTextStyle,
      ) ,
      
      bottomNavigationBar: buildBottomNavBar(),
      //floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
      floatingActionButton: buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[currentIndex],
      
    );
  }

  buildBottomNavBar()=> BottomAppBar(
    notchMargin: 8,
    child: BottomNavigationBar(
      

      currentIndex: currentIndex,//1
      onTap:onTapped ,
      // onTap: (index){//1
      //   currentIndex =index; //task //settings
      //   setState(() {
          
      //   });
      // } ,
      items:[
      BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
    
    ]),
  );
  // او تعمل function
  void onTapped(int index){
    currentIndex =index;
    setState(() {
      
    });
  }
 Widget buildFAB()=>FloatingActionButton(onPressed: ()async{
   await TaskBottomSheet.show(context);
   tasksTabkey.currentState?.getTodosFromFireStore();

    //showTaskBottomSheet();
  },child: Icon(Icons.add),);
//   void showTaskBottomSheet() {         //كدا دي ملشهاش  لازمه
//   showModalBottomSheet(context: context, builder: (context)=>TaskBottomSheet.show());
// }
}

