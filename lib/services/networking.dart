import 'dart:convert';

import 'package:http/http.dart';

class Network{
  Network(this.url);
  final String url;

  Future getdata()async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }else{
      print(response.statusCode);
    }
  }
}