import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter_mvvm/services/api_client.dart';
import 'package:weather_app_flutter_mvvm/services/selected_city_service.dart';
import 'package:weather_app_flutter_mvvm/view/home_view.dart';
import 'package:weather_app_flutter_mvvm/viewmodel/details_viewmodel.dart';
import 'package:weather_app_flutter_mvvm/viewmodel/home_viewmodel.dart';

void main() {
  GetIt.I.registerSingleton(ApiClient());
  GetIt.I.registerSingleton(SelectedCityService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeViewModel(GetIt.I.get<ApiClient>(), GetIt.I.get<SelectedCityService>())),
        ChangeNotifierProvider.value(value: DetailsViewModel(GetIt.I.get<ApiClient>(), GetIt.I.get<SelectedCityService>()))
      ],
      child: MaterialApp(
        navigatorKey: GlobalKeyHelper.navigatorKey,
        title: 'Weather app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeView(),
      ),
    );
  }
}

class GlobalKeyHelper {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
