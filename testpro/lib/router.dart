import 'package:flutter/material.dart';
import 'package:testpro/main.dart';
import 'package:testpro/message.dart';
import 'package:testpro/invoice.dart';
import 'package:testpro/product.dart';
import 'package:testpro/string.dart';


class AppRouter{

Route generateSettings(RouteSettings settings){
  switch(settings.name){
    case MESSAGE_PAGE:
     return MaterialPageRoute(builder: (_)=> Message(argument : settings.arguments));
    case INVOICE_PAGE:
    return MaterialPageRoute(builder: (_)=> Invoice(argument: settings.arguments,));
    case PRODUCT_PAGE:
    return MaterialPageRoute(builder: (_)=> Product(prod: settings.arguments,));
    case MYAPP_PAGE:
    return MaterialPageRoute(builder: (_)=>MyApp(router: AppRouter()));
    default:
    return null;

  }
}
  
}


