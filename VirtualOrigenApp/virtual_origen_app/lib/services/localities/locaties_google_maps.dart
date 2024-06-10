import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:virtual_origen_app/services/localities/interface_locaties.dart';
import 'package:virtual_origen_app/services/secrets.dart';

class LocatiesGoogleMaps extends GetxService implements ILocaties {
  late Secrets _secrets;

  @override
  void onInit() {
    _secrets = Get.find<Secrets>();
    super.onInit();
  }

  @override
  Future<String> getLocalityName(double lat, double long) async {
    final apiKey = _secrets.apiKeyMaps;
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final results = decoded['results'];
      if (results.isNotEmpty) {
        return results[0]['formatted_address'];
      } else {
        return 'No se pudo encontrar el nombre del lugar.';
      }
    } else {
      throw Exception('Error al obtener el nombre del lugar.');
    }
  }
}
