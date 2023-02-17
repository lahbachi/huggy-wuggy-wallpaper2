import 'package:flutter/material.dart';
import '../../views/share_app/share_app_view.dart';
import '../../model/firebase_file.dart';
import '../../views/Home/home.dart';
import '../../views/donation/donation_page.dart';
import '../../views/images/image_page.dart';
import '../../views/rate_app/rate_view.dart';
import '../../views/splash/splash_page.dart';
import '../../views/theme_post/select_post.dart';
import 'views/about/about.dart';
import 'views/applovinmx/applovintest.dart';
import 'views/gameAd/playGameAd.dart';

class NavigatorRoutes {
  static const String splash = '/splash';
  static const String selectPostPage = '/SelectPostPage';
//  static const String mainPage = '/MainPage';
  static const String homePage = '/HomePage';
  static const String imagePage = '/ImagePage';
  static const String rateApp = '/RateAppView';
  static const String applovinView = '/ApplovinView';
  static const String donation = '/DonationPage';
  static const String aboutView = '/AboutView';
  static const String shareAppView = '/ShareAppView';
  static const String adGameOnlineView = '/AdGameOnlineView';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {

      case NavigatorRoutes.rateApp:
        return MaterialPageRoute(builder: (_) => const RateAppView());
      case NavigatorRoutes.adGameOnlineView:
        return MaterialPageRoute(builder: (_) => const AdGameOnlineView());
        case NavigatorRoutes.applovinView:
        return MaterialPageRoute(builder: (_) => const ApplovinView());
      case NavigatorRoutes.shareAppView:
        return MaterialPageRoute(builder: (_) => const ShareAppView());
      case NavigatorRoutes.donation:
        return MaterialPageRoute(builder: (_) => const DonationPage());
      case NavigatorRoutes.aboutView:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case NavigatorRoutes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case NavigatorRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case NavigatorRoutes.selectPostPage:
        return MaterialPageRoute(builder: (_) => const SelectPostPage());

      case NavigatorRoutes.imagePage:
        ImagePageArguments imagePageArguments = args as ImagePageArguments;
        return MaterialPageRoute(
            builder: (_) => ImagePage(
                  favourite: imagePageArguments.favourite,
                ));
      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
    });
  }
}

class ImagePageArguments {
  final Favourite favourite;

  ImagePageArguments({required this.favourite});
}
