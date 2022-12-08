import 'package:cloud_firestore/cloud_firestore.dart';

class Items
{
  String?itemDescription;
  String?itemId;
  String?itemInfo;
  String?itemTitle;
  int?price;
  Timestamp?published;
  String?sellerName;
  String?sellersId;
  String?status;
  String?thumbnail;
  Items(
      {
        this.itemDescription,
        this.itemId,
        this.itemInfo,
        this.itemTitle,
        this.price,
        this.published,
        this.sellerName,
        this.sellersId,
        this.status,
        this.thumbnail,

      }
      );

  Items.fromJson(Map<String,dynamic> json)
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    itemDescription=json["itemDescription"];
    itemId=json["itemId"];
    itemInfo=json["itemInfo"];
    itemTitle=json["itemTitle"];
    price=json["price"];
    published=json["published"];
    sellerName=json["sellerName"];
    sellersId=json["sellersId"];
    thumbnail=json["thumbnail"];

  }
  Map<String,dynamic> toJson()
  {
    final Map<String,dynamic> data=Map<String,dynamic>();
    data["itemDescription"]=itemDescription;
    data["itemId"]=itemId;
    data["itemInfo"]=itemInfo;
    data["itemTitle"]=itemTitle;
    data["price"]=price;
    data["published"]=published;
    data["sellerName"]=sellerName;
    data["sellersId"]=sellersId;
    data["thumbnail"]= thumbnail;
    data["status"]=status;
    return data;

  }


}