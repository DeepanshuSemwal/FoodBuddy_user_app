
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wow_food_user_app/main_screens/placed_order_screen.dart';
import 'package:wow_food_user_app/map/map.dart';

import '../assistanceMethods/address_changer.dart';
import '../models/address.dart';

class AddressDesign extends StatefulWidget
{
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  AddressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

  @override
  _AddressDesignState createState() => _AddressDesignState();
}



class _AddressDesignState extends State<AddressDesign>
{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        //select this address
        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [

            //address info
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex!,
                  value: widget.value!,
                  activeColor: Colors.redAccent,
                  onChanged: (val)
                  {
                    //provider
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                    print(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.name.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Phone Number: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.phoneNumber.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Flat Number: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.flatNumber.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "City: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.city.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Country: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.country.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Complete Address: ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model!.completeAddress.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //button
            ElevatedButton(
              child: const Text("Check on Maps"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: ()
              {
                 MapUtils.openMapWithCompleteAddress(widget.model!.completeAddress!);
              // MapUtils.openMapWithPositions(widget.model!.lat!,widget.model!.lng!);

              },
            ),

            //button
            widget.value == Provider.of<AddressChanger>(context).count
                ? ElevatedButton(
              child: const Text("Proceed"),
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
              ),
              onPressed: ()
              {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>PlacedOrderScreen()));
              },
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
