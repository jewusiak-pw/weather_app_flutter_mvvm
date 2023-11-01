import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app_flutter_mvvm/model/lists_response.dart';
import 'package:weather_app_flutter_mvvm/services/todo_client.dart';

class TodoViewModel extends ChangeNotifier {
  final TodoClient _todoClient;
  String _newListName = "";

  TodoViewModel(this._todoClient);

  set newListName(String value) {
    _newListName = value;
  }

  Map<String, String> newItemNames = {};

  String get newListName => _newListName;

  int _page = 0;

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
    notifyListeners();
  }

  Future newListCommand() async {
    await _todoClient.createList(_newListName);
    loadLists();
  }

  Future deleteListCommand(String id) async {
    await _todoClient.deleteList(id);
    loadLists();
  }

  Future setItemDoneCommand(String id, bool done) async {
    await _todoClient.setItemDone(id, done);
    loadLists();
  }

  Future deleteItemCommand(String id) async {
    await _todoClient.deleteItem(id);
    loadLists();
  }

  Future newItemCommand(String? listUuid) async {
    if(listUuid == null || newItemNames[listUuid] == null) return;
    await _todoClient.createItem(newItemNames[listUuid]!, listUuid);
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
    loading = true;
    _listsResponse = null;
  }
}
