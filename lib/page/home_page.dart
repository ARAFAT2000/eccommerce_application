import 'package:eccommerce_application/Services/all_api_services.dart';
import 'package:eccommerce_application/Urls/model_text.dart';
import 'package:eccommerce_application/model/all_products_model.dart';
import 'package:eccommerce_application/screen/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/search_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<AllProductsModel> _allProductsList=[];

 bool isLoading= false;

  getAllproducts(){
    AllApiServices().allProducts().then((value) {
      setState(() {
        isLoading= true;
      });
      _allProductsList=value;
      setState(() {
        isLoading= false;
      });
    }).onError((error, stackTrace) {
   debugPrint(error.toString());
    });

  }
  @override
  void initState() {
    getAllproducts();
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 50),
        child: Column(
          children: [
          Search_bar(),

            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemCount:_allProductsList.length,

                  itemBuilder: (context,index){
                    var data= _allProductsList[index];
                  return Card(
                    child: Column(

                      children: [
                         Row(

                           children: [
                             Container(
                                height: 150,
                                 width: 100,
                                 margin: EdgeInsets.all(5.6),
                                 decoration: BoxDecoration(
                                   color: Colors.grey,
                                   image: DecorationImage(
                                     fit: BoxFit.fill,
                                       image: NetworkImage(data.image.toString()))
                                 ),
                                 ),
                             SizedBox(
                               width: 10,
                             ),

                             Expanded(
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,

                                                          children: [
                                   Model_Text(text: data.title.toString(), size: 17),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Model_Text(text: 'Price : ${data.price.toString()}', size: 13),
                                   Model_Text(text:' ⭐⭐⭐ ${data.rating!.rate.toString()}', size: 13),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   GestureDetector(
                                     onTap: (){
                                       Navigator.push(context, MaterialPageRoute(
                                           builder: (context)=>
                                               PDetailsScreen(
                                                   id: data.id.toString(),
                                                   price: data.price.toString(),
                                                   title: data.title.toString(),
                                                    description: data.description.toString(),
                                                    category: data.category.toString(),
                                                   image: data.image.toString(),
                                                    rating: data.rating
                                               )
                                       ));
                                     },
                                     child: Container(
                                       height: 35,
                                       width: 100,
                                       decoration: BoxDecoration(
                                         color: Colors.blueGrey,
                                         borderRadius: BorderRadius.circular(10)
                                       ),
                                       child: Center(child: Model_Text(text: 'Details', size: 15)),
                                     ),
                                   )
                                                          ],
                                                        ),
                                 ))
                           ],
                         )
                      ],
                    ),
                  );
                  },

              ),
            ),
          ],
        ),
      ),
    );
  }
}


