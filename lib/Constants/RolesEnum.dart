enum RolesEnum {
  toplulukYoneticisi,
  organizator,
  konusmaci
}

extension RolesEnumExtension on RolesEnum {
  int get name {
    switch (this) {
      case RolesEnum.toplulukYoneticisi:
        return 1;
      case RolesEnum.organizator:
        return 2;
      case RolesEnum.konusmaci:
        return 3;
    }
  }
}