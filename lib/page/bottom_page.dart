import 'package:eccommerce_application/page/cart_page.dart';
import 'package:eccommerce_application/page/home_page.dart';
import 'package:eccommerce_application/page/profile_page.dart';
import 'package:eccommerce_application/page/wish_list_page.dart';
import 'package:flutter/material.dart';

import 'catagory_page.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({Key? key}) : super(key: key); // Change super.key to key

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  static final List _pageList = [
    HomePage(),
    CatagoryPage(),
    WishListPage(),// Correct the class name
    CartPage(id: '', images: '', price: ' '),
    ProfilePage(), // Correct the class name
  ];

  int selected_Index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pageList.elementAt(selected_Index),
      ),
      bottomNavigationBar: BottomNavigationBar(
       selectedItemColor: Colors.yellow,

        backgroundColor: Colors.blueAccent,
        currentIndex: selected_Index,
        onTap: (value) {
          setState(() {
            selected_Index = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Catagory', backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'WishList', backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart', backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile', backgroundColor: Colors.blueGrey),
        ],
      ),
    );
  }
}
