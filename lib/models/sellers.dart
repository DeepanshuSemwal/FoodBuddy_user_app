class Sellers
{
  String?sellerId;
  String?sellerName;
  String?sellerAvatar;
  String?sellerEmail;

      Sellers
      (
       {
        required this.sellerId,
         required this.sellerName,
         required this.sellerAvatar,
         required this.sellerEmail,

           }
      );
      Sellers.fromJson(Map<String,dynamic>json)
      {
        sellerId=json["sellerId"];
        sellerName=json["sellerName"];
        sellerAvatar=json["sellerAvatar"];
        sellerEmail=json["sellerEmail"];

      }
      Map<String,dynamic>toJson()
      {
        final Map<String,dynamic>data=new Map<String,dynamic>();
        data["sellerId"]=this.sellerId;
        data["sellerName"]=this.sellerName;
        data["sellerAvatar"]=this.sellerAvatar;
        data["sellerEmail"]=this.sellerEmail;
        return data;
      }


}