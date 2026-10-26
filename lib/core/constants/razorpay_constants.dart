import 'package:flutter_dotenv/flutter_dotenv.dart';

class RazorpayConstants {
  static String get keyId => dotenv.env['RAZOR_KEY_ID'] ?? '';
}
