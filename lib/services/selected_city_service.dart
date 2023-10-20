import 'package:weather_app_flutter_mvvm/model/autocomplete_item.dart';

class SelectedCityService {
  AutocompleteItem? _city;

  String? getKey() => _city!.key;

  AutocompleteItem? getCity() => _city;

  void setCity(AutocompleteItem? city) => this._city = city;
}
