import 'package:get_it/get_it.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GetNavigation());
  locator.registerLazySingleton(() => Singleton());
}
