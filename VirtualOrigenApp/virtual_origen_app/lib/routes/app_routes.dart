enum Routes {
  FIRST_TIME,
  LOGIN,
  SINGUP,
  FORGOT_PASSWORD,
  EMAIL_VERIFICATION,

  HOME,

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
      case Routes.PRIVACY_POLICY:
        return "/privacy_policy";
    }
  }
}
