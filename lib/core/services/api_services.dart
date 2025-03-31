import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices{
  ApiServices._();
  static final ApiServices apiServices = ApiServices._();

  final api = "https://api.imgur.com/3/image/";
  final clientId = "954428364df58d9";


  Future<String?> postImage(Uint8List image) async {
    final header = {'Authorization': 'Client-ID $clientId'};
    final body = base64Encode(image);
    try{
      log("calling request...");
      final Response response = await http.post(Uri.parse(api) ,headers: header, body: body);
      log(response.statusCode.toString());
      if(response.statusCode == 200){
        log("api request success");
        final data = jsonDecode(response.body);
        return data['data']['link'];
      } else {
        log(response.body);
      }

    } catch(e) {
      log("Api call failed!!!");
    }

    return null;
  }

}
