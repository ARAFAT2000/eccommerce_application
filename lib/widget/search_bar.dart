import 'package:eccommerce_application/screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search_bar extends StatelessWidget {
  const Search_bar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: double.infinity,
        child: InkWell(
          onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
          },
          child: Container(

            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Icon(Icons.search),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Search here'),
                  ],
                )),
          ),
        )
    );
  }
}