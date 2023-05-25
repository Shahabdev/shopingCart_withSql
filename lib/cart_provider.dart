import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping_cart_withsqllite/databasehelper.dart';

import 'cart_model.dart';

class CartProvider with ChangeNotifier
{
  DataBaseHelper db=DataBaseHelper() ;
  int _counter=0;
  int get counter=>_counter;
  double _totalPrice=0.0;
  double get totalPrice=>_totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart =>_cart;
  Future<List<Cart>> getData()async
  {
   _cart=db.getCartList();
   return _cart;
  }

  void setSharedPrefrence()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setInt("cart_items", _counter);
    pref.setDouble('total_price',_totalPrice);
    notifyListeners();
    
  }
  void addTotalPrice(double productPrice)
  {
    _totalPrice=_totalPrice+productPrice;
    setSharedPrefrence();
    notifyListeners();
  }
  void removerTotalPrice(double productPrice)
  {
    _totalPrice=_totalPrice-productPrice;
    setSharedPrefrence();
    notifyListeners();
  }
  double getTotalPrice()
  {
    setSharedPrefrence();
    return _totalPrice;
  }
  void addCounter()
  {
    _counter++;
    setSharedPrefrence();
    notifyListeners();
  }
   void removerCounter()
   {
     _counter--;
     setSharedPrefrence();
     notifyListeners();
   }
   int getCounter()
   {
     setSharedPrefrence();
    return _counter;
   }

}