import 'package:url_launcher/url_launcher.dart';

class SettingService {
  Future<void> launchPhoneDialer(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $uri';
    }
  }

  Future<void> launchWhatsApp(String phone) async {
    final Uri uri = Uri.parse(
      "https://wa.me/${phone.replaceAll('+', '')}?text=${Uri.encodeComponent("Hello, I need support with the app. My issue is concerning...")}",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch WhatsApp";
    }
  }
}
