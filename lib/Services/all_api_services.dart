import 'dart:convert';

import 'package:eccommerce_application/model/cartproductmodel.dart';
import 'package:http/http.dart'as http;

import '../model/all_products_model.dart';
import '../model/catagory_details_model.dart';
import '../model/porducts_details_model.dart';
class AllApiServices{
  ///All products for hamePage

  Future<List<AllProductsModel>> allProducts()async{

      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if(response.statusCode==200){
        print(response.statusCode);
        return List<AllProductsModel>.from(json.decode(response.body).map((x)=> AllProductsModel.fromJson(x)));
      }else{
           throw Exception('Error');
      }

  }
///Products details
  Future<ProdoctDetailsModel> productsDetail(String id)async{

    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
    var data=jsonDecode(response.body);
    if(response.statusCode==200){

      return ProdoctDetailsModel.fromJson(data);
    }else{
      throw Exception('Error');
    }

  }

  ///Catagory
  Future<dynamic> catagory()async{

    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

    if(response.statusCode==200){

      return jsonDecode(response.body.toString());
    }else{
      throw Exception('Error');
    }

  }

  ///Catagory details
///must me int type data k dynamic banate hbe model class ar

  Future<List<CatagoryDetailsModel>> catagoryDetails( String catagoryname)async{

    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/$catagoryname'));
    if(response.statusCode==200){
      print(response.statusCode);
      return List<CatagoryDetailsModel>.from(json.decode(response.body).map((x)=> CatagoryDetailsModel.fromJson(x)));
    }else{
      throw Exception('Error');
    }

  }


  //cart product
  Future<List<CartProductModel>> CartProduct(String id)async{

    final response = await http.get(Uri.parse('https://fakestoreapi.com/carts/$id'));

    if(response.statusCode==200){

      return jsonDecode(response.body.toString());
    }else{
      throw Exception('Error');
    }

  }


}