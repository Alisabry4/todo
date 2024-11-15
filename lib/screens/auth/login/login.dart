import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_application/core/utiles/app_styles.dart';
import 'package:to_do_application/core/utiles/assets_manager.dart';
import 'package:to_do_application/core/utiles/constant_manager.dart';
import 'package:to_do_application/core/utiles/dialog_utlls.dart';
import 'package:to_do_application/core/utiles/email_validation.dart';
import 'package:to_do_application/core/utiles/routes_manager.dart';
import 'package:to_do_application/dataase_manager/model/user_dm.dart';
import 'package:to_do_application/screens/auth/register/widgets/custom_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late TextEditingController enteryouremail;

  late TextEditingController enteryourpassword;

  GlobalKey<FormState>formKey =GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enteryouremail =TextEditingController();
    enteryourpassword =TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    enteryouremail .dispose();
    enteryourpassword.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
      ),
       body: Padding(
         padding:  REdgeInsets.all(8.0),
         child: SingleChildScrollView(
           child: Form(
            key: formKey,
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AssetsManager.logon,width: 237.w,height: 71.h,),
                             Text('E-mail',style: AppLightStyles.title,),
                SizedBox(height: 12.h,),
                CustomField(hintText: 'enter your Email ',
                KeyBoardType: TextInputType.emailAddress,
                 controller: enteryouremail,
                 validator: (input){
                  if(input ==null || input.trim().isEmpty){
                    return 'please enter Email ';
                  }
                  if(!isValidEmail(input)){
                    return 'email bad format';
                  }
                  return null;
                 }),
                   SizedBox(height: 12.h,),
                               Text('Password',style: AppLightStyles.title,),
                SizedBox(height: 12.h,),
                CustomField(hintText: 'enter your Password',
                KeyBoardType: TextInputType.name,
                 controller: enteryourpassword,
                 isSecure: true,
                 validator: (input){
                  if(input ==null || input.trim().isEmpty){
                    return 'please enter Password';
                  }
                  return null;
                 }),
                   SizedBox(height: 12.h,),
                                  SizedBox(height: 12.h,),
                               Text('Confirm Password',style: AppLightStyles.title,),
                   SizedBox(height: 12.h,),
                   MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Text('Sign-in',style: AppLightStyles.buttonTitle,),
                    onPressed: (){
                      signIn();
             
                   }),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("Don't have account?",style: AppLightStyles.title?.copyWith(
                      fontSize: 14,
                    )),
                    TextButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, RoutesManager.register);
                    }, child: Text("Create Account", 
                    style: AppLightStyles.title?.copyWith(
                      fontSize: 14,
                      decoration: TextDecoration.underline
                    )
                    ))
                   ],)
             
             
             
             
                
             
                // TextFormField(
                //   decoration: InputDecoration(
                //     hintText: 'enter your name',
                //     hintStyle: AppLightStyles.titlef,
                //     fillColor: ColorsManagers.white,
                //     filled: true,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15.r),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15.r),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15.r),
                //     ),
                //     errorBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15.r),
                //       borderSide: BorderSide(color: Colors.red,width: 2)
             
                //     ),
                //   ),
                // )
              ],
             ),
           ),
         ),
       ),
    );
  }
  
  void signIn()async {
    if(formKey.currentState?.validate()==false)return;
  //   DialogUtlls.showLoading(context,messsage: 'Wait.......');
  //  await Future.delayed(Duration(seconds: 2));
  //   DialogUtlls.hide(context);
  //   DialogUtlls.showMessage(context,title: 'Error',posActionTitle: 'ok',negActionTitle: 'Cancel');
  // }

  try {
    DialogUtlls.showLoading(context, messsage: 'wait.....');
  UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: enteryouremail.text,
    password: enteryourpassword.text,
  );
 UserDm.currentUser =await readUserFromFireStore(credential.user!.uid);
  if(mounted){
   DialogUtlls.hide(context);

  }
  DialogUtlls.showMessage(context,body: 'User logged in Successful',
  posActionTitle: 'ok',
  posAction: (){
    Navigator.pushReplacementNamed(context, RoutesManager.home);
  }
  
  
  );
} on FirebaseAuthException catch (authError) {
  DialogUtlls.hide(context);
late String message;
  if (authError.code == ConstantManager.invalidCredentialCode) {
    message ='wrong email or Password'; 
  }
  DialogUtlls.showMessage(context,body: message,posActionTitle: 'ok');
} catch (error) {
  DialogUtlls.hide(context);
  DialogUtlls.showMessage(context,body: error.toString());
}
   }
  Future<UserDm> readUserFromFireStore(String Uid)async{
   CollectionReference usersCollection = FirebaseFirestore.instance.collection(UserDm.collectionName);
  DocumentReference userDoc= usersCollection.doc(Uid);
  DocumentSnapshot userDocSnapShot = await userDoc.get();
  Map<String,dynamic> json=  userDocSnapShot.data()as Map<String,dynamic>;
  UserDm userDm =UserDm.fromFireStore(json);
  return userDm;

   }
}