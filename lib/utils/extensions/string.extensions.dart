const withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
const withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

extension StringUtils on String? {
  bool get isNumeric {
    if (isBlank) {
      return false;
    }

    return num.tryParse(this!) != null ? true : false;
  }

  String? removeDiacritics() {
    if (this == null) {
      return null;
    }

    String str = this!;
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }

    return str;
  }

  bool get isBlank => this == null || this!.isEmpty || this!.trim().isEmpty;

  bool get isNotBlank => !isBlank;

  /// Convert a litteral value into it's enum item
  /// Example: final Language language = Language.en.toString().toEnum(Language.values);
  T toEnum<T extends Enum>(List<T> enumValues) => enumValues.firstWhere((enumVal) => enumVal.name == this);
}
