import 'package:http/http.dart' as http;

Future<int> makeRequest(String imagePath, String inputText, double latitude, double longitude) async {
  var url = Uri.parse('https://flutter-sandbox.free.beeceptor.com/upload_photo/');
  var request = http.MultipartRequest('POST', url)
      ..fields['comment'] = inputText
      ..fields['latitude'] = latitude.toString()
      ..fields['longitude'] = longitude.toString()
      ..files.add(await http.MultipartFile.fromPath('photo', imagePath));

  var response = await request.send();

  return response.statusCode;
}
