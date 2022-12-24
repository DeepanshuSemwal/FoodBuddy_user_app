import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wow_food_user_app/models/sellers.dart';
import 'package:wow_food_user_app/widgets/sellers_info.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  Future<QuerySnapshot>? restaurantDocumentList;
  String sellerName="";
  initSearchRestaurant(String textEntered)
  {
    restaurantDocumentList=  FirebaseFirestore.instance.collection("sellers").where("sellerName", isGreaterThanOrEqualTo: textEntered).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Colors.red.shade800,Colors.green.shade700],
                begin:FractionalOffset(0.0,0.0,),
                end:FractionalOffset(1.0,0.0),
                stops: [1.0,0.0],
                tileMode: TileMode.clamp
            ),
          ),
        ),
        title: TextField(
          onChanged: (textEnterted)
          {
            setState(() {
              sellerName=textEnterted;
            });
            // init search
            initSearchRestaurant(sellerName);
          },
          decoration: InputDecoration(
            hintText: "Search Restaurant",
            hintStyle: TextStyle(
              color: Colors.white12,
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: ()
              {
                  initSearchRestaurant(sellerName);
              },
            ),
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: restaurantDocumentList,
        builder: (context,snapshot)
        {
          return snapshot.hasData?ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index)
            {
              Sellers model=Sellers.fromJson(
                snapshot.data!.docs[index].data() as Map<String,dynamic>
              );
              return SellersInfoDesign(
                  model: model, context: context);
            },
          ): Center(child: Text("No Record Found"),);
        },
      ),



    );
  }
}
