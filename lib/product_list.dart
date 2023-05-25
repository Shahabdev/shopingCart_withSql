import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_cart_withsqllite/cart_model.dart';
import 'package:shoping_cart_withsqllite/cart_provider.dart';
import 'package:shoping_cart_withsqllite/databasehelper.dart';
import 'package:sqflite/sqflite.dart';

import 'cart_screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DataBaseHelper? dbhelper=DataBaseHelper();
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];
  List<String> productUnit = [
    'KG',
    'Dozen',
    'KG',
    'Dozen',
    'KG',
    'KG',
    'KG',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg',
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg',
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg',
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612',
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612',
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612',
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612',
  ];

  @override
  Widget build(BuildContext context) {
    final cart=Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Product List',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions:  [
            Center(
              child: InkWell(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                },
                child: Badge(
                  badgeContent: Consumer<CartProvider>(
                    builder: (context,value,child){
                      return Text(
                        value.getCounter().toString(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      );
                    },

                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 33,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: productUnit.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image(
                                    height: 100,
                                    width: 100,
                                    image: NetworkImage(productImage[index]),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5,),
                                      Text(
                                        productName[index],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 6,),
                                      Text(
                                        productUnit[index].toString()+' '+r'$' +productPrice[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: ()
                                          {
                                            dbhelper?.insert( Cart(
                                                id: index,
                                                productId: index.toString(),
                                                productName: productName[index],
                                                initialPrice: productPrice[index],
                                                productPrice: productPrice[index],
                                                quantity: 1,
                                                unitTag: productUnit[index].toString(),
                                                image: productImage[index].toString())
                                            ).then((value){

                                             print('item is added to cart');
                                             cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                             cart.addCounter();
                                            }).onError((error, stackTrace){
                                              print(error.toString());
                                            });

                                          },
                                          child: Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(child: Text('Add to cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ]),
      ),
    );
  }
}
