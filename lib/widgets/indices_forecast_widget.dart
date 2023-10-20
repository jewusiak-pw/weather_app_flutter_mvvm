import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter_mvvm/model/weather_index.dart';

class IndicesForecastWidget extends StatelessWidget {
  final Iterable<WeatherIndex>? _uvIndices;
  final Iterable<WeatherIndex>? _aqIndices;

  const IndicesForecastWidget(this._uvIndices, this._aqIndices, {super.key});

  @override
  Widget build(BuildContext context) {
    if (_uvIndices == null || _aqIndices == null) return Container();
    try {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: mapForecasts(),
      );
    } catch (e) {
      return Container();
    }
  }

  List<Widget> mapForecasts() {
    List<Widget> forecasts = [];
    for (int i = 0; i < _uvIndices!.length; i++) {
      forecasts.add(IndexForecastColumn(
          _uvIndices!.elementAt(i), _aqIndices!.elementAt(i)));
      forecasts.add(SizedBox(
        width: 5,
      ));
    }
    if (forecasts.isNotEmpty) forecasts.removeLast();
    forecasts.insert(
        0,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(" "), Text("UV:"), Text("Air Quality:")],
        ));
    return forecasts;
  }
}

class IndexForecastColumn extends StatelessWidget {
  final WeatherIndex _uvIndex;
  final WeatherIndex _aqIndex;

  const IndexForecastColumn(this._uvIndex, this._aqIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(getDayNameFromDate(_uvIndex.localDateTime!)),
        Text("${_uvIndex.value?.round() ?? "n/a"}/10"),
        Text("${_aqIndex.value?.round() ?? "n/a"}/10")
      ],
    );
  }

  String getDayNameFromDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      final formatter = DateFormat('EEE', 'en_US');
      final dayName = formatter.format(dateTime);

      return dayName;
    } catch (e) {
      return "";
    }
  }
}
