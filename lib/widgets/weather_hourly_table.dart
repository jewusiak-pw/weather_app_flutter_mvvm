import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/hourly_forecast_details.dart';

class WeatherHourlyTable extends StatelessWidget {
  final Iterable<HourlyForecastDetails>? _hourlyForecast;

  const WeatherHourlyTable(this._hourlyForecast, {super.key});

  @override
  Widget build(BuildContext context) {
    if (_hourlyForecast == null) return Container();
    try {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: mapForecasts(_hourlyForecast!),
      );
    } catch (e) {
      return Container();
    }
  }

  List<Widget> mapForecasts(Iterable<HourlyForecastDetails> forecasts) {
    List<Widget> list = [];

    list.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              child: Text(""),
            ),
            Container(
              width: 50,
              child: Text("Rain"),
            ),
            Container(
              width: 50,
              child: Text("Temp"),
            ),
          ],
        ),
      );

    forecasts.forEach(
      (e) => list.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              child: Text(getTimeFromDate(e.dateTime!)),
            ),
            Container(
              width: 50,
              child: Text("${e.precipitationProbability??0}%"),
            ),
            Container(
              width: 50,
              child: Text("${e.temperature?.value??"n/a"}°"),
            ),
          ],
        ),
      ),
    );
    return list;
  }

  String getTimeFromDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      final formatter = DateFormat('HH:mm');
      final time = formatter.format(dateTime);

      return time;
    } catch (e) {
      return "";
    }
  }
}
