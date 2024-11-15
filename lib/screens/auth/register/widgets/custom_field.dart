import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_application/core/utiles/app_styles.dart';
import 'package:to_do_application/core/utiles/colors_managers.dart';
typedef Validator =String ?Function(String?);
class CustomField extends StatelessWidget {
   CustomField({super.key,required this.hintText,required this.controller,required this.validator,this.isSecure =false, this.KeyBoardType=TextInputType.text});
  String hintText;
  TextEditingController controller ;
  Validator validator;
  bool isSecure =false;
  TextInputType KeyBoardType;

  @override
  Widget build(BuildContext context) {
    return             TextFormField(
      validator:validator ,
      controller:controller ,
      obscureText: isSecure,
      keyboardType: KeyBoardType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppLightStyles.titlef,
                fillColor: ColorsManagers.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: Colors.red,width: 2)
         
                ),
              ),
            );

  }
}