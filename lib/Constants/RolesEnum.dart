enum RolesEnum {
  yonetici,
  organizator,
  konusmaci
}

extension RolesEnumExtension on RolesEnum {
  int get name {
    switch (this) {
      case RolesEnum.yonetici:
        return 1;
      case RolesEnum.organizator:
        return 2;
      case RolesEnum.konusmaci:
        return 3;
    }
  }
}