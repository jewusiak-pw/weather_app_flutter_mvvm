class DailyForecastDetails {
  Headline? headline;
  List<DailyForecasts>? dailyForecasts;

  DailyForecastDetails({this.headline, this.dailyForecasts});

  DailyForecastDetails.fromJson(Map<String, dynamic> json) {
    headline = json['Headline'] != null
        ? new Headline.fromJson(json['Headline'])
        : null;
    if (json['DailyForecasts'] != null) {
      dailyForecasts = <DailyForecasts>[];
      json['DailyForecasts'].forEach((v) {
        dailyForecasts!.add(new DailyForecasts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.headline != null) {
      data['Headline'] = this.headline!.toJson();
    }
    if (this.dailyForecasts != null) {
      data['DailyForecasts'] =
          this.dailyForecasts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Headline {
  String? effectiveDate;
  int? effectiveEpochDate;
  int? severity;
  String? text;
  String? category;
  String? endDate;
  int? endEpochDate;
  String? mobileLink;
  String? link;

  Headline(
      {this.effectiveDate,
      this.effectiveEpochDate,
      this.severity,
      this.text,
      this.category,
      this.endDate,
      this.endEpochDate,
      this.mobileLink,
      this.link});

  Headline.fromJson(Map<String, dynamic> json) {
    effectiveDate = json['EffectiveDate'];
    effectiveEpochDate = json['EffectiveEpochDate'];
    severity = json['Severity'];
    text = json['Text'];
    category = json['Category'];
    endDate = json['EndDate'];
    endEpochDate = json['EndEpochDate'];
    mobileLink = json['MobileLink'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EffectiveDate'] = this.effectiveDate;
    data['EffectiveEpochDate'] = this.effectiveEpochDate;
    data['Severity'] = this.severity;
    data['Text'] = this.text;
    data['Category'] = this.category;
    data['EndDate'] = this.endDate;
    data['EndEpochDate'] = this.endEpochDate;
    data['MobileLink'] = this.mobileLink;
    data['Link'] = this.link;
    return data;
  }
}

class DailyForecasts {
  String? date;
  int? epochDate;
  Temperature? temperature;
  Day? day;
  Day? night;
  List<String>? sources;
  String? mobileLink;
  String? link;

  DailyForecasts(
      {this.date,
      this.epochDate,
      this.temperature,
      this.day,
      this.night,
      this.sources,
      this.mobileLink,
      this.link});

  DailyForecasts.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    epochDate = json['EpochDate'];
    temperature = json['Temperature'] != null
        ? new Temperature.fromJson(json['Temperature'])
        : null;
    day = json['Day'] != null ? new Day.fromJson(json['Day']) : null;
    night = json['Night'] != null ? new Day.fromJson(json['Night']) : null;
    sources = json['Sources'].cast<String>();
    mobileLink = json['MobileLink'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['EpochDate'] = this.epochDate;
    if (this.temperature != null) {
      data['Temperature'] = this.temperature!.toJson();
    }
    if (this.day != null) {
      data['Day'] = this.day!.toJson();
    }
    if (this.night != null) {
      data['Night'] = this.night!.toJson();
    }
    data['Sources'] = this.sources;
    data['MobileLink'] = this.mobileLink;
    data['Link'] = this.link;
    return data;
  }
}

class Temperature {
  Minimum? minimum;
  Minimum? maximum;

  Temperature({this.minimum, this.maximum});

  Temperature.fromJson(Map<String, dynamic> json) {
    minimum =
        json['Minimum'] != null ? new Minimum.fromJson(json['Minimum']) : null;
    maximum =
        json['Maximum'] != null ? new Minimum.fromJson(json['Maximum']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.minimum != null) {
      data['Minimum'] = this.minimum!.toJson();
    }
    if (this.maximum != null) {
      data['Maximum'] = this.maximum!.toJson();
    }
    return data;
  }
}

class Minimum {
  double? value;
  String? unit;
  int? unitType;

  Minimum({this.value, this.unit, this.unitType});

  Minimum.fromJson(Map<String, dynamic> json) {
    value = json['Value'];
    unit = json['Unit'];
    unitType = json['UnitType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Value'] = this.value;
    data['Unit'] = this.unit;
    data['UnitType'] = this.unitType;
    return data;
  }
}

class Day {
  int? icon;
  String? iconPhrase;
  bool? hasPrecipitation;
  String? precipitationType;
  String? precipitationIntensity;

  Day(
      {this.icon,
      this.iconPhrase,
      this.hasPrecipitation,
      this.precipitationType,
      this.precipitationIntensity});

  Day.fromJson(Map<String, dynamic> json) {
    icon = json['Icon'];
    iconPhrase = json['IconPhrase'];
    hasPrecipitation = json['HasPrecipitation'];
    precipitationType = json['PrecipitationType'];
    precipitationIntensity = json['PrecipitationIntensity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Icon'] = this.icon;
    data['IconPhrase'] = this.iconPhrase;
    data['HasPrecipitation'] = this.hasPrecipitation;
    data['PrecipitationType'] = this.precipitationType;
    data['PrecipitationIntensity'] = this.precipitationIntensity;
    return data;
  }
}
