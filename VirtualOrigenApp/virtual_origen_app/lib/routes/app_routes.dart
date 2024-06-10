enum Routes {
  FIRST_TIME,
  LOGIN,
  SINGUP,
  FORGOT_PASSWORD,
  EMAIL_VERIFICATION,

  HOME, // Properties
  PROPERTY, // Smart devices, property details
  INVERSOR,
  WEATHER,
  USER,

  PRIVACY_POLICY,
}

extension RoutesPath on Routes {
  String get path {
    switch (this) {
      case Routes.FIRST_TIME:
        return "/first_time";
      case Routes.LOGIN:
        return "/auth/login";
      case Routes.SINGUP:
        return "/auth/singin";
      case Routes.FORGOT_PASSWORD:
        return "/auth/forgot_password";
      case Routes.EMAIL_VERIFICATION:
        return "/auth/email_verification";
      case Routes.HOME:
        return "/home";
      case Routes.PROPERTY:
        return "/home/property";
      case Routes.INVERSOR:
        return "/home/property/inversor";
      case Routes.WEATHER:
        return "/home/property/weather";
      case Routes.USER:
        return "/home/user";
      case Routes.PRIVACY_POLICY:
        return "/privacy_policy";
    }
  }
}
