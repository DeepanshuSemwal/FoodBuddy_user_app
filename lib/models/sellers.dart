class Sellers
{
  String?sellerUID;
  String?sellerName;
  String?sellerAvatar;
  String?sellerEmail;

      Sellers
      (
       {
        required this.sellerUID,
         required this.sellerName,
         required this.sellerAvatar,
         required this.sellerEmail,

           }
      );
      Sellers.fromJson(Map<String,dynamic>json)
      {
        sellerUID=json["sellerUId"];
        sellerName=json["sellerName"];
        sellerAvatar=json["sellerAvatar"];
        sellerEmail=json["sellerEmail"];

      }
      Map<String,dynamic>toJson()
      {
        final Map<String,dynamic>data=new Map<String,dynamic>();
        data["sellerUID"]=this.sellerUID;
        data["sellerName"]=this.sellerName;
        data["sellerAvatar"]=this.sellerAvatar;
        data["sellerEmail"]=this.sellerEmail;
        return data;
      }


}