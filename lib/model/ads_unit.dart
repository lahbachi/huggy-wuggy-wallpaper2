import 'dart:convert';

List<AdsUnit> adsUnitFromJson(String str) =>
    List<AdsUnit>.from(json.decode(str).map((x) => AdsUnit.fromJson(x)));

String adsUnitToJson(List<AdsUnit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdsUnit {
  AdsUnit({
    this.unityad,
    this.admob,
    this.facebookAN,
    this.applovin,
  });

  Admob? unityad;
  Admob? admob;
  Admob? facebookAN;
  Applovin? applovin;

  factory AdsUnit.fromJson(Map<String, dynamic> json) => AdsUnit(
        unityad: Admob.fromJson(json["unityad"]),
        admob: Admob.fromJson(json["admob"]),
        facebookAN: Admob.fromJson(json["facebookAN"]),
        applovin: Applovin.fromJson(json["Applovin"]),
      );

  Map<String, dynamic> toJson() => {
        "unityad": unityad!.toJson(),
        "admob": admob!.toJson(),
        "facebookAN": admob!.toJson(),
        "Applovin": applovin!.toJson(),
      };
}

class Admob {
  Admob({
    this.interstitialid,
    this.bannerid,
    this.active,
    this.initid,
  });

  String? interstitialid;
  String? bannerid;
  String? initid;
  bool? active;

  factory Admob.fromJson(Map<String, dynamic> json) => Admob(
        interstitialid: json["Interstitialid"],
        bannerid: json["bannerid"],
        active: json["active"],
        initid: json["initid"],
      );

  Map<String, dynamic> toJson() => {
        "Interstitialid": interstitialid,
        "bannerid": bannerid,
        "active": active,
        "initid": initid,
      };
}

class Applovin {
  Applovin({
    this.bannerAdUnitId,
    this.interstitialAdUnitId,
    this.active,
    this.mrecAdUnitId,
    this.rewardedAdUnitId,
    this.sdkKey,
  });

  String? bannerAdUnitId;
  String? interstitialAdUnitId;
  String? mrecAdUnitId;
  String? rewardedAdUnitId;
  String? sdkKey;
  bool? active;

  factory Applovin.fromJson(Map<String, dynamic> json) => Applovin(
        bannerAdUnitId: json["bannerAdUnitId"],
        interstitialAdUnitId: json["interstitialAdUnitId"],
        mrecAdUnitId: json["mrecAdUnitId"],
        rewardedAdUnitId: json["rewardedAdUnitId"],
        active: json["active"],
        sdkKey: json["sdkKey"],
      );

  Map<String, dynamic> toJson() => {
        "bannerAdUnitId": bannerAdUnitId,
        "interstitialAdUnitId": interstitialAdUnitId,
        "active": active,
        "mrecAdUnitId": mrecAdUnitId,
        "rewardedAdUnitId": rewardedAdUnitId,
        "sdkKey": sdkKey,
      };
}
