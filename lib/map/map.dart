import 'package:url_launcher/url_launcher.dart';

class MapUtils
{
  MapUtils._();

  // there are two ways for launching google maps
// 1 . using latitude and longitude
// 2. using complete address

// 1. latitude and longitude

static Future<void>openMapWithPositions(double latitude,double longitude) async
{
  String googleMapUrl="https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
  if(await canLaunchUrl(Uri.parse(googleMapUrl)))
    {
      await launchUrl(Uri.parse(googleMapUrl));

    }
  else
    {
      throw "Could not open the google map.";
    }
}

// 2. complete text address
static Future<void>openMapWithCompleteAddress(String completeAddress) async
{
  String query=Uri.encodeComponent(completeAddress);
  String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$query";
  if(await launchUrl(Uri.parse(googleMapUrl)))
    {
      await launchUrl(Uri.parse(googleMapUrl));
    }
  else
    {
      throw "Could not open the google map.";
    }
}
}