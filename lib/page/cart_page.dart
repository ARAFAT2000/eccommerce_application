import 'package:eccommerce_application/Services/all_api_services.dart';
import 'package:eccommerce_application/model/cartproductmodel.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final String id;
  final String images;
  final String price;

  CartPage({required this.id, required this.images, required this.price});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String currentPrice = '';
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    currentPrice = widget.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Cart List'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 35, left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 150,
                    width: 100,
                    margin: EdgeInsets.all(5.6),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.images),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      decreaseQuantity();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Icon(Icons.minimize_outlined)),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(currentPrice), // Use currentPrice here
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      increaseQuantity();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Icon(Icons.add)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text('Confirm Here')),
            )
          ],
        ),
      ),
    );
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
      currentPrice =
          (double.parse(widget.price) * quantity).toStringAsFixed(2);
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        currentPrice =
            (double.parse(widget.price) * quantity).toStringAsFixed(2);
      });
    }
  }
}
