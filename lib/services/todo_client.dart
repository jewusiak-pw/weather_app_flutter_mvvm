import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_flutter_mvvm/constants.dart';
import 'package:weather_app_flutter_mvvm/exceptions/request_failure_exception.dart';
import 'package:weather_app_flutter_mvvm/model/lists_response.dart';

class TodoClient {
  static dynamic decodeResponseBody(http.Response res) {
    return jsonDecode(utf8.decode(res.bodyBytes));
  }

  Future<ListsResponse> getLists(int? page) async {
    final params = {'size': '50', 'page': page.toString() ?? '0'};
    var res = await makeGetRequest(Uri.parse("${Constants.TODO_URL}/list")
        .replace(queryParameters: params));
    var obj = ListsResponse.fromJson(decodeResponseBody(res));
    return obj;
  }

  Future createList(String name) async {
    await makePostRequest(
        Uri.parse("${Constants.TODO_URL}/list"), {'name': name},
        expc: 201);
  }

  Future deleteList(String id) async {
    await makeDeleteRequest(Uri.parse("${Constants.TODO_URL}/list/$id"));
  }

  Future createItem(String name, String listUuid) async {
    var res = await makePostRequest(
        Uri.parse("${Constants.TODO_URL}/item"), {'name': name},
        expc: 201);
    var obj = TodoItem.fromJson(decodeResponseBody(res));
    await makePostRequest(
        Uri.parse("${Constants.TODO_URL}/item/${obj.uuid!}/setlist/$listUuid"),
        {});
  }

  Future setItemDone(String id, bool done) async {
    await makePutRequest(Uri.parse("${Constants.TODO_URL}/item/$id"),
        {'status': done.toString()});
  }

  Future deleteItem(String id) async {
    var res =
        await makeDeleteRequest(Uri.parse("${Constants.TODO_URL}/item/$id"));
    print("object");
  }

  Future<http.Response> makeGetRequest(Uri uri) async {
    var res = await http.get(uri);
    if (res.statusCode != 200) {
      throw RequestFailureException(
          "Request GET $uri failed with ${res.statusCode}. Message: ${res.body}");
    }

    return res;
  }

  Future<http.Response> makePutRequest(
      Uri uri, Map<String, dynamic> body) async {
    var res = await http.put(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });
    if (res.statusCode != 200) {
      throw RequestFailureException(
          "Request PUT $uri failed with ${res.statusCode}. Message: ${res.body}");
    }

    return res;
  }

  Future<http.Response> makeDeleteRequest(Uri uri) async {
    var res = await http.delete(uri);
    if (res.statusCode != 204) {
      throw RequestFailureException(
          "Request DELETE $uri failed with ${res.statusCode}. Message: ${res.body}");
    }

    return res;
  }

  Future<http.Response> makePostRequest(Uri uri, Map<String, dynamic> body,
      {expc = 200}) async {
    var res = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });
    if (res.statusCode != expc) {
      throw RequestFailureException(
          "Request POST $uri failed with ${res.statusCode}. Message: ${res.body}");
    }

    return res;
  }
}
