class WeatherIndex {
  String? name;
  int? iD;
  bool? ascending;
  String? localDateTime;
  int? epochDateTime;
  double? value;
  String? category;
  int? categoryValue;
  String? mobileLink;
  String? link;

  WeatherIndex(
      {this.name,
      this.iD,
      this.ascending,
      this.localDateTime,
      this.epochDateTime,
      this.value,
      this.category,
      this.categoryValue,
      this.mobileLink,
      this.link});

  WeatherIndex.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    iD = json['ID'];
    ascending = json['Ascending'];
    localDateTime = json['LocalDateTime'];
    epochDateTime = json['EpochDateTime'];
    value = json['Value'];
    category = json['Category'];
    categoryValue = json['CategoryValue'];
    mobileLink = json['MobileLink'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['ID'] = this.iD;
    data['Ascending'] = this.ascending;
    data['LocalDateTime'] = this.localDateTime;
    data['EpochDateTime'] = this.epochDateTime;
    data['Value'] = this.value;
    data['Category'] = this.category;
    data['CategoryValue'] = this.categoryValue;
    data['MobileLink'] = this.mobileLink;
    data['Link'] = this.link;
    return data;
  }
}
