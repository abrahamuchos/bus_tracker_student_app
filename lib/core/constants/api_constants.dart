import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants{
  ApiConstants._();

  static String baseUrl = dotenv.get('API_BASE_URL');
  static String reverbHost = dotenv.get('REVERB_HOST');
  static int reverbPort = dotenv.getInt('REVERB_PORT', fallback: 8080);
  static String reverbAppKey = dotenv.get('REVERB_APP_KEY');
  static bool reverbUseTLS = false;

  static const String activeTrip = '/trips/active';

}