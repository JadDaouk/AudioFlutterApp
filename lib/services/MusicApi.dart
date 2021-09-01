import 'package:http/http.dart' as http;
import 'package:technical_test/models/music.dart';

Future<dynamic> getMusicsFromApi() async{
  final url = 'https://api.deezer.com/track/3135556&output=json';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return musicFromJson(response.body);
  } else {
    return [];
  }
}