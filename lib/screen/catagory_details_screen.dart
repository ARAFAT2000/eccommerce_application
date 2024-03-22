import 'package:eccommerce_application/Services/all_api_services.dart';
import 'package:eccommerce_application/Urls/model_text.dart';
import 'package:flutter/material.dart';

import '../model/catagory_details_model.dart';


class CatagoryDetailsScreen extends StatefulWidget {
  String catagoryname;
   CatagoryDetailsScreen({super.key,required  this.catagoryname});

  @override
  State<CatagoryDetailsScreen> createState() => _CatagoryDetailsScreenState();
}

class _CatagoryDetailsScreenState extends State<CatagoryDetailsScreen> {
  bool isLoading= false;
  List<CatagoryDetailsModel> catagorydetails=[];

  getCatagoryDetails(){
    AllApiServices().catagoryDetails(widget.catagoryname).then((value) {
      setState(() {
        isLoading=true;
      });
      catagorydetails=value;
      setState(() {
        isLoading =false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
@override
  void initState() {
  getCatagoryDetails();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.catagoryname,style: TextStyle(color: Colors.black)),
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: catagorydetails.length,
          itemBuilder: (context,index){
          var data= catagorydetails[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Stack(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data.image.toString()))
                      ),
                    ),
                    Positioned(
                      right: 15,
                        child: Icon(Icons.favorite_border))
                  ],
                ),
                  Model_Text(text: data.title.toString(), size: 15),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Model_Text(text: ' ⭐⭐⭐ ${data.rating?.rate?.toString()} (${data.rating?.count?.toString()} review)'??  ' ', size: 15),
                      Model_Text(text: 'Price : ${data.price}', size: 18),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Model_Text(text: 'Details', size: 20,),
                  SizedBox(
                    height: 12,
                  ),
                  Model_Text(text: data.description.toString(), size: 12,),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 40,
                    color: Colors.yellow,
                    child:  Center(
                        child: Model_Text(text: 'Cart'.toString(), size: 18,)),
                  ),
                ],
              ),
            )
          );
          },
        
      ),
    );
  }
}
