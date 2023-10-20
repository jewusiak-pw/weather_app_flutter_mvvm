import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:weather_app_flutter_mvvm/services/api_client.dart';
import 'package:weather_app_flutter_mvvm/main.dart';
import 'package:weather_app_flutter_mvvm/model/autocomplete_item.dart';
import 'package:weather_app_flutter_mvvm/services/selected_city_service.dart';
import 'package:weather_app_flutter_mvvm/view/details_view.dart';

class HomeViewModel extends ChangeNotifier {
  AutocompleteItem? _selectedOption;
  Iterable<AutocompleteItem> _hints = [];
  String? _autocompleteBoxValue;
  final _uuidGenerator = Uuid();
  var _requestDelayKey = "";

  final ApiClient _apiClient;
  final SelectedCityService _selectedCityService;

  HomeViewModel(this._apiClient, this._selectedCityService);

  String get autocompleteBoxValue => _autocompleteBoxValue ?? "";

  Future setAutocompleteBoxValue(String? value) async {
    _autocompleteBoxValue = value;

    if (_autocompleteBoxValue == "") {
      hints = [];
      return;
    }
    var requestUuid = _uuidGenerator.v4();
    _requestDelayKey = requestUuid;
    await Future.delayed(const Duration(milliseconds: 500));
    if (requestUuid == _requestDelayKey) {
      _hints = await _apiClient.getAutocompleteHints(_autocompleteBoxValue!);
    }
  }


  AutocompleteItem? get selectedOption => _selectedOption;

  set selectedOption(AutocompleteItem? value) {
    _selectedOption = value;
    notifyListeners();
  }

  Iterable<AutocompleteItem> get hints => _hints;

  set hints(Iterable<AutocompleteItem> value) {
    _hints = value;
    notifyListeners();
  }

  Future goPressedCommand() async {
    await handleSelect(_selectedOption);
  }

  Future handleSelect(AutocompleteItem? selectedOption) async {
    if (selectedOption == null) return;
    _selectedCityService.setCity(selectedOption);
    await Navigator.of(GlobalKeyHelper.navigatorKey.currentState!.context).push(MaterialPageRoute(
      builder: (context) => DetailsView(),
    ));
  }
}
