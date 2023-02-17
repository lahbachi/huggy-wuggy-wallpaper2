import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import '../../core/common/app_url.dart';
import '../../model/country.dart';
import '../../model/failure.dart';

class ImageService {


  // Set
  Future<void> setOnHomeScreen({required String url}) async {
    var filePath = await cachWallaper(url: url);
    await homeScreen(path: filePath.path);
    // Get.showSnackbar(const GetSnackBar(
    //   title: 'Done',
    //   message: "The Wallpaper saved on home screen",
    //   duration: Duration(seconds: 2),
    // ));
  }

  Future<void> setOnLockScreen({required String url}) async {
    var filePath = await cachWallaper(url: url);

    await lockScreen(path: filePath.path);

  }

  Future<void> setOnHomeANDLOckScreen({required String url}) async {
    var filePath = await cachWallaper(url: url);
    await homeScreen(path: filePath.path);
    await lockScreen(path: filePath.path);

  }

// screens
  Future<void> homeScreen({required String path}) async {
    await WallpaperManager.setWallpaperFromFile(
        path, WallpaperManager.HOME_SCREEN);
  }

  Future<void> lockScreen({required String path}) async {
    await WallpaperManager.setWallpaperFromFile(
        path, WallpaperManager.LOCK_SCREEN);
  }

  Future<void> lockAndHomeScreen({required String path}) async {
    await WallpaperManager.setWallpaperFromFile(
        path, WallpaperManager.HOME_SCREEN);
    await WallpaperManager.setWallpaperFromFile(
        path, WallpaperManager.LOCK_SCREEN);
  }
  // download first
  Future<File> cachWallaper({required String url}) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    return file;
  }
  Future<Country>  getCountryPhoneCode() async {

    try {
      final response = await http.get(Uri.parse(AppUrls.mapUrl));
      return Country.fromJson(_returnResponse(response));
    } on SocketException {
      throw('No Internet connection');
    } catch (e) {
      throw ("try Again Later");
    }
  }
  Map<String, dynamic> _returnResponse(final response) {
    // print(response.body);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
