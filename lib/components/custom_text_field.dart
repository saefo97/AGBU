import 'package:agbu/constants.dart';
import 'package:flutter/material.dart';
import 'package:neon_widgets/neon_widgets.dart';

class CustomTextFormFormField extends StatefulWidget {
  final String title;
  TextEditingController? controller;
  bool? isPassword;
  String? Function(String?)? validator;
  CustomTextFormFormField({
    super.key, required this.title, this.isPassword = false,
    this.validator,
    this.controller

  });

  @override
  State<CustomTextFormFormField> createState() => _CustomTextFormFormFieldState();
}

class _CustomTextFormFormFieldState extends State<CustomTextFormFormField> {
 bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget. validator,
      controller: widget.controller,
      maxLines: 1,
      minLines: 1,
      obscureText:  widget.isPassword! ? isVisible : false,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword! ?
        IconButton(onPressed: (){
          setState(() {
            isVisible = !isVisible;
          });
        }, icon: isVisible ? NeonContainer(
          borderRadius: BorderRadius.circular(360.0),
          borderWidth: 1.0,
          borderColor: kDarkBlue1,
          padding: EdgeInsets.all(1),
          containerColor: Colors.transparent,
          child: Icon(Icons.visibility,
          color: kDarkBlue1,
          
          ),
        ) :
        Icon(Icons.visibility_off,
          color: kDarkBlue1,
        )

        ) : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
                color: Colors.blue.shade300,
                width: 2
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
                color: kDarkBlue1,
                width: 3
            )
        ),


        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
                color: Colors.red,
                width: 2
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
                color: Colors.red,
                width: 3
            )
        ),

        //     icon: Icon(Icons.email)  ,
        label: Text("${widget.title}",
        ),
        labelStyle: TextStyle(
            color:kLightBlue1
        ),
        // prefixIcon: Icon(Icons.email),
        // suffixIcon:  Icon(Icons.email),

      ),

    );
  }
}
