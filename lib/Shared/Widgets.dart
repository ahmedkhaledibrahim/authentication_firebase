import 'package:flutter/material.dart';

Widget TextFieldWidget(
        {required String labelText,
        required Color color,
        required IconData iconData,
        required TextEditingController controllerval,
        String ValidatorData = "Error",
        bool ObsecureTextVal = false,
        required double BorderRadiusValue}) =>
    Container(
      margin: EdgeInsets.only(top: 20),
      width: 350,
      child: TextFormField(
        controller: controllerval,
        validator: (input) {
          if (input==null || input.isEmpty){
            return ValidatorData;
          }
        },
        onSaved: (input) => controllerval.text = input.toString(),
        style: TextStyle(color: Colors.black),
        cursorColor: color,
        obscureText: ObsecureTextVal,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BorderRadiusValue),
              borderSide: BorderSide(color: color)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BorderRadiusValue),
              borderSide: BorderSide(color: color)),
          labelText: labelText,
          labelStyle: TextStyle(color: color),
          prefixIcon: Icon(
            iconData,
            color: color,
          ),
        ),
      ),
    );
