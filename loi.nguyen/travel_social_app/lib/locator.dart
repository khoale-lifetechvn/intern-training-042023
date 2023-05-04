import 'package:get_it/get_it.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GetNavigation());
  locator.registerLazySingleton(() => Singleton());
}
