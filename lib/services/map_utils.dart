import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/hospitals nearby';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await canLaunchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> openMap2(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/ambulance nearby';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await canLaunchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
