import 'package:weather_app_flutter_mvvm/model/lists_response.dart';

import '../services/todo_client.dart';

class TodoModel {
  final TodoClient _todoClient;
  String _newListName="";

  String get newListName => _newListName;

  set newListName(String value) {
    _newListName = value;
  }

  int _page = 0;


  TodoModel(this._todoClient);

  ListsResponse? _listsResponse;

  ListsResponse get listsResponse => _listsResponse!;

  bool _loading = true;


  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  Future loadLists() async {
    _listsResponse = await _todoClient.getLists(_page);
    loading = false;
  }

  Future newListCommand() async {
    await _todoClient.createList(_newListName);
    loadLists();
  }


  void nextPage() {
    if (_listsResponse?.last ?? true) return;
    _page++;
    loadLists();
  }

  void previousPage() {
    if (_page == 0 || (_listsResponse?.first ?? true)) return;
    _page--;
    loadLists();
  }

  void cleanup() {
    loading=true;
    _listsResponse=null;
  }

}