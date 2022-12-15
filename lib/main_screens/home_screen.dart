import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wow_food_user_app/assistanceMethods/assistance_methods.dart';
import 'package:wow_food_user_app/authentication/auth_screen.dart';
import 'package:wow_food_user_app/global/global.dart';
import 'package:wow_food_user_app/models/sellers.dart';
import 'package:wow_food_user_app/widgets/custum_drawer.dart';
import 'package:wow_food_user_app/widgets/sellers_info.dart';
import 'package:wow_food_user_app/widgets/progress_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final items=[

    "slider/0.jpg",
    "slider/1.jpg",
    "slider/2.jpg",
    "slider/3.jpg",
    "slider/4.jpg",
    "slider/5.jpg",
    "slider/6.jpg",
    "slider/7.jpg",
    "slider/8.jpg",
    "slider/9.jpg",
    "slider/11.jpg",
    "slider/12.jpg",
    "slider/13.jpg",
    "slider/14.jpg",
    "slider/15.jpg",
    "slider/16.jpg",
    "slider/17.jpg",
    "slider/18.jpg",
    "slider/19.jpg",
    "slider/20.jpg",
    "slider/21.jpg",
    "slider/22.jpg",
    "slider/23.jpg",
    "slider/24.jpg",
    "slider/25.jpg",
    "slider/26.jpg",
    "slider/27.jpg",

  ];

  @override
  void initState()
  {
    super.initState();
    clearCart(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.red.shade900,Colors.red.shade400,Colors.red.shade900],
            ),
        ),

      ),
    automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          sharedPreferences!.getString("name")!,

        ),

      ),
      drawer: CustumDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width,
                child: Container(

                    child : CarouselSlider
                      (

                      items: items.map((index)
                      {
                        return Builder(builder: (BuildContext context){
                          return Container(

                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 1.0),

                            child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Image.asset(
                                    index,
                                    fit: BoxFit.fill,
                                ),
                            ),
                          );
                        });

                      }

                      ).toList(),
                        options: CarouselOptions
                          (
                          height: 400,
                          aspectRatio: 16/9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.decelerate,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,

                        ),


                    ),

                ),
              ),
            ),

          ),
             StreamBuilder<QuerySnapshot>
              (
                  stream: FirebaseFirestore.instance.collection("sellers").snapshots(),
              builder: (context,snapshot)
              {

                  return !snapshot.hasData?SliverToBoxAdapter(child: Center(child: CircularProgressBar(),),):

                         SliverStaggeredGrid.countBuilder(
                           crossAxisCount: 1,

                           staggeredTileBuilder: (c)=>StaggeredTile.fit(1),

                            itemBuilder: (context,int index)
                            {

                              Sellers sellerModel=Sellers.fromJson(
                                  snapshot.data!.docs[index].data()! as Map<String,dynamic>
                              );
                              return  SellersInfoDesign(
                                model:sellerModel,
                                context: context,
                              );
                             // return Text("print");

                            },
                           itemCount: snapshot.data!.docs.length,
                        );

              },
            ),

        ],
      ),
    );
  }
}
