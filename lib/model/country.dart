
class Country {
  Country({
    this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.as,
    this.query,
  });
  String? status;
  String? country;
  String? countryCode;
  String? region;
  String? regionName;
  String? city;
  String? zip;
  double? lat;
  double? lon;
  String? timezone;
  String? isp;
  String? org;
  String? as;
  String? query;

  Country.fromJson(Map<String, dynamic> json){
    status = json['status']??"";
    country = json['country']??"";
    countryCode = json['countryCode']??"";
    region = json['region']??"";
    regionName = json['regionName']??"";
    city = json['city']??"";
    zip = json['zip']??"";
    lat = json['lat']??0.0;
    lon = json['lon']??0.0;
    timezone = json['timezone']??"";
    isp = json['isp']??"";
    org = json['org']??"";
    as = json['as']??"";
    query = json['query']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['country'] = country;
    _data['countryCode'] = countryCode;
    _data['region'] = region;
    _data['regionName'] = regionName;
    _data['city'] = city;
    _data['zip'] = zip;
    _data['lat'] = lat;
    _data['lon'] = lon;
    _data['timezone'] = timezone;
    _data['isp'] = isp;
    _data['org'] = org;
    _data['as'] = as;
    _data['query'] = query;
    return _data;
  }
}