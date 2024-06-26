enum StorageKeys {
  THEME_MODE,
  IS_FIRST_TIME,
  LANGUAGE,
}

extension StorageKeysExten on StorageKeys {
  String get key {
    switch (this) {
      case StorageKeys.THEME_MODE:
        return "THEME_MODE";
      case StorageKeys.IS_FIRST_TIME:
        return "IS_FIRST_TIME";
      case StorageKeys.LANGUAGE:
        return "LANGUAGE";
    }
  }
}
