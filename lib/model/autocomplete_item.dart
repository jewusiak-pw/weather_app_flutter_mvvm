class AutocompleteItem {
  int? version;
  String? key;
  String? type;
  int? rank;
  String? localizedName;
  Country? country;
  Country? administrativeArea;

  AutocompleteItem(
      {this.version,
      this.key,
      this.type,
      this.rank,
      this.localizedName,
      this.country,
      this.administrativeArea});

  AutocompleteItem.fromJson(Map<String, dynamic> json) {
    version = json['Version'];
    key = json['Key'];
    type = json['Type'];
    rank = json['Rank'];
    localizedName = json['LocalizedName'];
    country =
        json['Country'] != null ? new Country.fromJson(json['Country']) : null;
    administrativeArea = json['AdministrativeArea'] != null
        ? new Country.fromJson(json['AdministrativeArea'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Version'] = this.version;
    data['Key'] = this.key;
    data['Type'] = this.type;
    data['Rank'] = this.rank;
    data['LocalizedName'] = this.localizedName;
    if (this.country != null) {
      data['Country'] = this.country!.toJson();
    }
    if (this.administrativeArea != null) {
      data['AdministrativeArea'] = this.administrativeArea!.toJson();
    }
    return data;
  }
}

class Country {
  String? iD;
  String? localizedName;

  Country({this.iD, this.localizedName});

  Country.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    localizedName = json['LocalizedName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['LocalizedName'] = this.localizedName;
    return data;
  }
}
