import 'package:eccommerce_application/Services/all_api_services.dart';
import 'package:eccommerce_application/screen/catagory_details_screen.dart';
import 'package:flutter/material.dart';


class CatagoryPage extends StatefulWidget {
  const CatagoryPage({super.key});

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  dynamic  catagorylist;

  bool isLoading= false;

  getCatagory(){
   AllApiServices().catagory().then((value) {
     setState(() {
       isLoading=true;
     });
     catagorylist=value;
     setState(() {
       isLoading=false;
     });
   }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });

  }
  @override
  void initState() {
    getCatagory();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(' Catagory List',style: TextStyle(color: Colors.black),),
      ),
      body:isLoading ? CircularProgressIndicator(): catagorylist==null?
      Center(child: CircularProgressIndicator()) :
      ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
         itemCount: catagorylist.length,
          itemBuilder: (context,index){
           return ListTile(
             onTap: (){
               Navigator.push(context, 
                   MaterialPageRoute(builder: (context)=>
                   CatagoryDetailsScreen(catagoryname: catagorylist[index].toString())
                   ));
             },
             leading: CircleAvatar(
               backgroundColor: Colors.blueGrey,
                 child: Text('${1+index}')),
             title: Text(catagorylist[index].toString()),
           );
          },

      )
    );
  }
}