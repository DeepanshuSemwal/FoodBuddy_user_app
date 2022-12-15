import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wow_food_user_app/assistanceMethods/assistance_methods.dart';
import 'package:wow_food_user_app/widgets/custum_drawer.dart';

import '../models/menus.dart';
import '../models/sellers.dart';
import '../slash_screen/slash_screen.dart';
import '../widgets/menu_design.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';


class MenusScreen extends StatefulWidget
{
  final Sellers? model;
  MenusScreen({this.model});

  @override
  _MenusScreenState createState() => _MenusScreenState();
}



class _MenusScreenState extends State<MenusScreen> {
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
        title: const Text(
          "Wow Food",
          style: TextStyle(fontSize: 45, fontFamily: "DancingScript"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: ()
          {
            clearCart(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=>SlashScreen()));
            Fluttertoast.showToast(msg: "Cart has been cleared");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.sellerName.toString() + " Menus")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menu")
                .orderBy("published", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: Center(child: CircularProgressBar(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Menus model = Menus.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return MenuDesign(
                    model: model,
                    context: context,
                  );
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
