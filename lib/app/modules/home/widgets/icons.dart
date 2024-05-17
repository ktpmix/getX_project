import 'package:flutter/material.dart';
import 'package:getx_prac/app/core/values/colors.dart';
import 'package:getx_prac/app/core/values/icon.dart';

List<Icon> getIcons(){
 return const [
  Icon(IconData(personIcon, fontFamily: 'MaterialIcons'),color: purple,),
  Icon(IconData(workIcon, fontFamily: 'MaterialIcons'),color:deepPink ),
  Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'),color: green),
  Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'),color: yellow),
  Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'),color: lightBlue),
  Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'),color: blue),
 ];
}