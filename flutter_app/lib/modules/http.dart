import 'dart:convert';

import "package:http/http.dart" as http;
import "package:flutter_app/configuration/settings.dart" as settings; 

const PROTOCOL = settings.PROTOCOL;
const DOMAIN = settings.DOMAIN;

class RequestResult
{
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

Future<RequestResult> http_get(String route, [dynamic data]) async
{
  var dataStr = jsonEncode(data);
  var url = "$PROTOCOL://$DOMAIN/$route?data=$dataStr";
  var result;

  // await try-cat문으로 감싸줘야함. 오류나면 PK auto-increment인지 확인하기!
  try {
    result = await http.get(url);
  } catch(e) {
    print('error caught: $e');
  }
  return RequestResult(true, jsonDecode(result.body));
}

Future<RequestResult> http_post(String route, [dynamic data]) async
{
  var url = "$PROTOCOL://$DOMAIN/$route";
  var dataStr = jsonEncode(data);
  print(dataStr + "\n");
  
  var result;

try {
  result = await http.post(url, body: dataStr, headers:{"Content-Type":"application/json"});
}  catch(e) {
  print('error caught: $e');
}
  return RequestResult(true, jsonDecode(result.body));
}
