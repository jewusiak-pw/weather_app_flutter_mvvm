import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter_mvvm/main.dart';
import 'package:weather_app_flutter_mvvm/model/autocomplete_item.dart';
import 'package:weather_app_flutter_mvvm/viewmodel/details_viewmodel.dart';
import 'package:weather_app_flutter_mvvm/widgets/indices_forecast_widget.dart';
import 'package:weather_app_flutter_mvvm/widgets/weather_forecast_bars_widget.dart';
import 'package:weather_app_flutter_mvvm/widgets/weather_hourly_table.dart';

class DetailsView extends StatefulWidget {

  DetailsView({super.key});

  @override
  State<DetailsView> createState() => _DetailsViewState();

}

class _DetailsViewState extends State<DetailsView> {


  @override
  Widget build(BuildContext context) {
    final detailsViewModel = Provider.of<DetailsViewModel>(context);
    //detailsViewModel.ensureLoading();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => detailsViewModel.navigatorBackCommand()),
          title: Text(
            "Weather app",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple),
      body: detailsViewModel.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 25, left: 20, right: 20),
                child: Container(
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined, size: 18),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              "${detailsViewModel.selectedCity?.localizedName ?? "n/a"} (${detailsViewModel.selectedCity?.administrativeArea?.localizedName ?? ''}, ${detailsViewModel.selectedCity?.country?.localizedName ?? ''})")
                        ],
                      ),
                      Text(
                        "${detailsViewModel.currentConditions?.temperature?.metric?.value?.round() ?? "-"}°",
                        style: GoogleFonts.spaceGrotesk(fontSize: 150),
                      ),
                      Text(
                        "${detailsViewModel.currentConditions?.weatherText ?? ""}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text("Next days"),
                      SizedBox(
                        height: 5,
                      ),
                      WeatherForecastBarsWidget(detailsViewModel.dailyForecast),
                      SizedBox(height: 20),
                      Text("Today"),
                      SizedBox(
                        height: 5,
                      ),
                      WeatherHourlyTable(detailsViewModel.hourlyForecast),
                      SizedBox(height: 20),
                      IndicesForecastWidget(
                          detailsViewModel.uvIndexForecast, detailsViewModel.airQualityIndexForecast),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void initState() {
    final detailsViewModel = Provider.of<DetailsViewModel>(GlobalKeyHelper.navigatorKey.currentState!.context, listen: false);
    detailsViewModel.ensureLoading();
    super.initState();
  }

  @override
  void dispose() {
    final detailsViewModel = Provider.of<DetailsViewModel>(GlobalKeyHelper.navigatorKey.currentState!.context, listen: false);
    detailsViewModel.cleanup();
    super.dispose();
  }
}
