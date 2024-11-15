import 'package:flutter/material.dart';
import 'package:to_do_application/core/utiles/colors_managers.dart';

// ignore: must_be_immutable
class SettingsTab extends StatefulWidget {
   SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String selectedTheme ='Light';
    String selectedLanguage ='English';


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Theme',style: TextStyle(fontSize: 16,color: ColorsManagers.black),),
          SizedBox(height: 8),
          //
          Container(
            padding: EdgeInsets.all(8),
            height: 48,
            decoration: BoxDecoration(
              color: ColorsManagers.white,
             // borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorsManagers.blue,width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedTheme,style: TextStyle(fontSize: 16,color: ColorsManagers.blue)),
                DropdownButton<String>(
                  underline: Container(
                    color: Colors.transparent,
                  ),
                                    focusColor: Colors.transparent,
                items: <String>['Light', 'Dark'].map((String value) {
                return DropdownMenuItem<String>(
                value: value,
                 child: Text(value),
                  );
                 }).toList(),
                  onChanged: (newTheme) {
                    selectedTheme =newTheme!;
                    setState(() {
                      
                    });
                  },),
              ],
            ),
            
          ),
                    
          SizedBox(height: 18),
          Text('Language'),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            height: 48,
            decoration: BoxDecoration(
              color: ColorsManagers.white,
             // borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorsManagers.blue,width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedLanguage,style: TextStyle(fontSize: 16,color: ColorsManagers.blue)),
                DropdownButton<String>(
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  focusColor: Colors.transparent,
                items: <String>['English', 'العربيه'].map((String value) {
                return DropdownMenuItem<String>(
                value: value,
                 child: Text(value),
                  );
                 }).toList(),
                  onChanged: (newLanguage) {
                    selectedLanguage =newLanguage!;
                    setState(() {
                      
                    });
                  },),
              ],
            ),
            
          ),
        ],
      ),
    );
  }
}