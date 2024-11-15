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


class RegisterScrren extends StatefulWidget {
  const RegisterScrren({super.key});

  @override
  State<RegisterScrren> createState() => _RegisterScrrenState();
}

class _RegisterScrrenState extends State<RegisterScrren> {
  late TextEditingController enteryourfullname;

    late TextEditingController enteryourusername;

  late TextEditingController enteryouremail;

  late TextEditingController enteryourpassword;

  late TextEditingController enterconfirmpassword;
  GlobalKey<FormState>formKey =GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enteryourfullname =TextEditingController();
    enteryourusername =TextEditingController();
    enteryouremail =TextEditingController();
    enteryourpassword =TextEditingController();
    enterconfirmpassword =TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    enteryourfullname.dispose();
    enteryourusername.dispose();
    enteryouremail .dispose();
    enteryourpassword.dispose();
    enterconfirmpassword.dispose();

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
                Text('Full Name',style: AppLightStyles.title,),
                SizedBox(height: 12.h,),
                CustomField(hintText: 'enter your full name',
                KeyBoardType: TextInputType.name,
                 controller: enteryourfullname,
                 validator: (input){
                  if(input ==null || input.trim().isEmpty){
                    return 'please enter full name';
                  }
                  return null;
                 }),
                   SizedBox(height: 12.h,),
                 Text('User Name',style: AppLightStyles.title,),
                SizedBox(height: 12.h,),
                CustomField(hintText: 'enter your user name',
                KeyBoardType: TextInputType.name,
                 controller: enteryourusername,
                 validator: (input){
                  if(input ==null || input.trim().isEmpty){
                    return 'please enter user name';
                  }
                  return null;
                 }),
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
                CustomField(hintText: 'enter Confirm Password',
                KeyBoardType: TextInputType.name,
                 controller: enterconfirmpassword,
                 validator: (input){
                  if(input ==null || input.trim().isEmpty){
                    return 'please enter Confirm Password';
                  }
                  if(input!=enteryourpassword.text){
                    return "Password dosen't match";
                  }
                  return null;
                 }),
                   SizedBox(height: 12.h,),
                   MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Text('Sign-UP',style: AppLightStyles.buttonTitle,),
                    onPressed: (){
                      signUp();
             
                   }),
                                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("Already have account?",style: AppLightStyles.title?.copyWith(
                      fontSize: 14,
                    )),
                    TextButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, RoutesManager.login);
                    }, child: Text("Sign-In", 
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
  
  void signUp()async {
    if(formKey.currentState?.validate()==false)return;
  //   DialogUtlls.showLoading(context,messsage: 'Wait.......');
  //  await Future.delayed(Duration(seconds: 2));
  //   DialogUtlls.hide(context);
  //   DialogUtlls.showMessage(context,title: 'Error',posActionTitle: 'ok',negActionTitle: 'Cancel');
  // }

  try {
    DialogUtlls.showLoading(context, messsage: 'wait.....');
  UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: enteryouremail.text,
    password: enteryourpassword.text,
  );
  addUsersToFireStore(credential.user!.uid);
  if(mounted){
   DialogUtlls.hide(context);

  }
  DialogUtlls.showMessage(context,body: 'User register Successful',
  posActionTitle: 'ok',
  posAction: (){
    Navigator.pushReplacementNamed(context, RoutesManager.login);
  }
  
  
  );
} on FirebaseAuthException catch (authError) {
  DialogUtlls.hide(context);
late String message;
  if (authError.code == ConstantManager.weekPasswordCode) {
    message ='week Password'; 
  } else if (authError.code == ConstantManager.emailAlreadyInUseCode) {
    message='The account already exists for that email.';
  }
  DialogUtlls.showMessage(context,title: 'Error occurred',body: message,posActionTitle: 'ok');
} catch (error) {
  DialogUtlls.hide(context);
  DialogUtlls.showMessage(context,title: 'Error Occured',body: error.toString());
}
   }
   void addUsersToFireStore(String uid)async{
     CollectionReference usersCollection=FirebaseFirestore.instance.collection(UserDm.collectionName);
   DocumentReference userDocument = usersCollection.doc(uid);
   UserDm userDm =UserDm(id: uid,  fullName: enteryourfullname.text,
   userName: enteryourusername.text,
   email:enteryouremail.text );
   await userDocument.set(userDm.ToFirestore());
   }
  
}