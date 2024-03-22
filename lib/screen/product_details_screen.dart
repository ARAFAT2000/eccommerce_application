import 'package:eccommerce_application/Services/all_api_services.dart';
import 'package:eccommerce_application/Urls/model_text.dart';
import 'package:eccommerce_application/model/porducts_details_model.dart';
import 'package:eccommerce_application/page/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PDetailsScreen extends StatefulWidget {
  final String id;
  final dynamic price;
 final  String title;
  final String description;
  final  String category;
 final String image;
  final  dynamic rating;
PDetailsScreen({
  required this.id,
  required this.price,
  required this.title,
   required this.description,
   required this.category,
  required this.image,
   required this.rating
});

  @override
  State<PDetailsScreen> createState() => _PDetailsScreenState();
}

class _PDetailsScreenState extends State<PDetailsScreen> {
  ProdoctDetailsModel prodoctDetailsModel= ProdoctDetailsModel();

  bool isLoading= false;
  productsdetails(){
    AllApiServices().productsDetail(widget.id).then((value) {
      setState(() {
        isLoading= true;
      });
      prodoctDetailsModel=value;
      setState(() {
        isLoading= false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });

  }
  @override
  void initState() {
    productsdetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.only(left: 13,right: 10,top: 15),
        child:ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Image.network(widget.image),
                ),

              Positioned(
                top: 15,
                left: 10,
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new))),
                Positioned(
                    top: 15,
                    right: 10,
                    child: InkWell(
                        onTap: (){
                          setState(() {
                            isLoading=!isLoading;
                          });
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(isLoading? 'Add favorite':'Remove from favorite'),
                              duration: Duration(seconds: 2),)
                          );
                        },
                        child: Icon(isLoading ?Icons.favorite:Icons.favorite_border,
                      ))),

              ],
            ),

            Model_Text(text: widget.title, size: 20),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Model_Text(text: '⭐⭐⭐ ${prodoctDetailsModel.rating?.rate?.toString()} (${prodoctDetailsModel.rating?.count?.toString()} review)'??  ' ', size: 15),
                    Model_Text(text: 'Catagory : ${widget.category}', size: 15),
                  ],
                ),
                Model_Text(text: 'Price : ${widget.price}', size: 18),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Model_Text(text: 'Details', size: 20,),
            SizedBox(
              height: 12,
            ),
            Model_Text(text: widget.description, size: 14,),


          

          ],
        )
      ),
     floatingActionButton: FloatingActionButton.extended(
         onPressed: (){
 Navigator.push(context, MaterialPageRoute(builder: (context)=>
  CartPage(
      id: widget.id,
      images: widget.image,
      price: widget.price
  ) ));
         },
         label:Text(' Cart Product ')),
    );
  }
}

