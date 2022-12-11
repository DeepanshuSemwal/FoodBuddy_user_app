import 'package:cloud_firestore/cloud_firestore.dart';

class Menus
{
  String? menuID;
  String? sellersId;
  String? menuTitle;
  String? menuInfo;
  Timestamp? published;
  String? thumbnail;
  String? status;

  Menus({
    this.menuID,
    this.sellersId,
    this.menuTitle,
    this.menuInfo,
    this.published,
    this.thumbnail,
    this.status
  });
  Menus.fromJson(Map<String,dynamic> json)
  {
    menuID=json["menuId"];
    sellersId=json["sellersId"];
    menuTitle=json["menuTitle"];
    menuInfo=json["menuInfo"];
    published=json["published"];
    status=json["status"];
    thumbnail=json["thumbnail"];
  }
  Map<String,dynamic> toJson()
  {
    final Map<String,dynamic> data=Map<String,dynamic>();
    data["menuID"]=menuID;
    data["sellersId"]=sellersId;
    data["menuTitle"]=menuTitle;
    data["menuInfo"]=menuInfo;
    data["published"]=published;
    data["thumbnail"]=thumbnail;
    data["status"]=status;
    return data;
  }

}