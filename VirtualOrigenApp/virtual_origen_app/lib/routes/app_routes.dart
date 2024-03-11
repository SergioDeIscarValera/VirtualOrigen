enum Routes { FIRST_TIME }

extension RoutesPath on Routes {
  String get path {
    switch (this) {
      case Routes.FIRST_TIME:
        return "/first_time";
    }
  }
}
