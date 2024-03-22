import 'dart:convert';

import 'package:eccommerce_application/Services/all_api_services.dart';
import 'package:eccommerce_application/model/all_products_model.dart';
import 'package:eccommerce_application/screen/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List <AllProductsModel> allproductsmodel=[];
  List <AllProductsModel> searchmodel=[];

  void UpdateModel(String val){
    setState(() {
      if(val.isEmpty){
        searchmodel=allproductsmodel;
      }else{
        searchmodel =allproductsmodel.where((element) => element.title!.toLowerCase().contains(val.toLowerCase())).toList();
      }
    });
  }

  bool isLoading= false;

  getAllproducts(){
    AllApiServices().allProducts().then((value) {
      setState(() {
        isLoading= true;
      });
      allproductsmodel=value;
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
    return SafeArea(
      child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'search'
              ),
              onChanged: (value){
                UpdateModel(value);
              },
            ),
            SizedBox(
              height: 30,
            ),
            
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemCount: searchmodel.length,
                  itemBuilder: (context,index){
                    var data= searchmodel[index];
                    return InkWell(
                      onTap: (){
                        PDetailsScreen(
                            id: data.id.toString(),
                            price: data.price.toString(),
                            title: data.title.toString(),
                            description: data.description.toString(),
                            category: data.category.toString(),
                            image: data.image.toString(),
                            rating: data.rating
                        );

                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.title.toString()),
                              Text(data.price.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}
