enum StorageKeys { THEME_MODE }

extension StorageKeysExten on StorageKeys {
  String get key {
    switch (this) {
      case StorageKeys.THEME_MODE:
        return "THEME_MODE";
    }
  }
}
