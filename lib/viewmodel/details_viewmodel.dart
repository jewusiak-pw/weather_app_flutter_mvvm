import 'dart:ffi';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter_mvvm/services/api_client.dart';
import 'package:weather_app_flutter_mvvm/main.dart';
import 'package:weather_app_flutter_mvvm/model/autocomplete_item.dart';
import 'package:weather_app_flutter_mvvm/model/current_conditions_details.dart';
import 'package:weather_app_flutter_mvvm/model/daily_forecast_details.dart';
import 'package:weather_app_flutter_mvvm/model/hourly_forecast_details.dart';
import 'package:weather_app_flutter_mvvm/model/weather_index.dart';
import 'package:weather_app_flutter_mvvm/services/selected_city_service.dart';

class DetailsViewModel extends ChangeNotifier {
  CurrentConditionsDetails? _currentConditions;
  DailyForecastDetails? _dailyForecast;
  Iterable<HourlyForecastDetails>? _hourlyForecast;
  Iterable<WeatherIndex>? _airQualityIndexForecast;
  Iterable<WeatherIndex>? _uvIndexForecast;
  String thisCityKey="";
  bool _finishedLoading = false;

  bool get finishedLoading => _finishedLoading;
  bool _loading = false;

  final ApiClient _apiClient;

  final SelectedCityService _selectedCityService;


  DetailsViewModel(this._apiClient, this._selectedCityService);

  Future<void> ensureLoading() async {
    if(_finishedLoading) return;
    if(!_loading){
      await fetchAllData(_selectedCityService.getKey()!);
    }
  }

  Future fetchAllData(String locationId) async {
    _loading = true;
    _currentConditions = await _apiClient.fetchCurrentConditions(locationId);
    _dailyForecast = await _apiClient.fetchDailyForecast(locationId);
    _hourlyForecast = await _apiClient.fetchHourlyForecast(locationId);
    _uvIndexForecast =
        await _apiClient.fetchWeatherIndexForecast(locationId, "-15");
    _airQualityIndexForecast =
        await _apiClient.fetchWeatherIndexForecast(locationId, "-10");
    _finishedLoading = true;
    _loading = false;
    notifyListeners();
  }

  void navigatorBackCommand() {
    Navigator.pop(GlobalKeyHelper.navigatorKey.currentContext!);
  }

  void cleanup() {
    _currentConditions = null;
    _dailyForecast = null;
    _hourlyForecast = null;
    _uvIndexForecast = null;
    _airQualityIndexForecast = null;
    _loading = false;
    _finishedLoading = false;
  }

  bool get loading => _loading;

  Iterable<WeatherIndex>? get uvIndexForecast => _uvIndexForecast;

  Iterable<WeatherIndex>? get airQualityIndexForecast =>
      _airQualityIndexForecast;

  Iterable<HourlyForecastDetails>? get hourlyForecast => _hourlyForecast;

  DailyForecastDetails? get dailyForecast => _dailyForecast;

  CurrentConditionsDetails? get currentConditions => _currentConditions;

  AutocompleteItem? get selectedCity => _selectedCityService.getCity();
}
