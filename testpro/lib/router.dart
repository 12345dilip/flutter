import 'package:flutter/material.dart';
import 'package:testpro/message.dart';
import 'package:testpro/invoice.dart';
import 'package:testpro/product.dart';
import 'package:testpro/string.dart';


class AppRouter{

Route generateSettings(RouteSettings settings){
  //  final Message args = settings.arguments as Message;
  print('args');
    print(settings.arguments );
  switch(settings.name){
    case MESSAGE_PAGE:
     return MaterialPageRoute(builder: (_)=> Message(argument : settings.arguments));
    case INVOICE_PAGE:
    return MaterialPageRoute(builder: (_)=> Invoice(argument: settings.arguments,));
    case PRODUCT_PAGE:
    return MaterialPageRoute(builder: (_)=> Product(prod: settings.arguments,));
    default:
    return null;

  }
}
  
}


