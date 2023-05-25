import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_cart_withsqllite/cart_provider.dart';
import 'package:shoping_cart_withsqllite/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider(create: (_)=>CartProvider(),
   child:Builder(builder: (BuildContext context)
    { return MaterialApp(
     title: 'Flutter Demo',
     theme: ThemeData(

       primarySwatch: Colors.blue,
     ),
     home: const ProductList(),
   );}));
  }
}
