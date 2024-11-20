import 'dart:math';

extension JcpDynamic on dynamic {
  /// Returns this [Object] if its type is [T].<br>
  /// Throws [Exception] otherwise.
  T typeCheck<T>() {
    if (runtimeType == T) {
      return this;
    } else {
      throw Exception(
        '\n[Flutter_JCP] :: Invalid Type Exception'
        '\n[Flutter_JCP] :: Expected [$T], but evaluated to [$runtimeType]',
      );
    }
  }

  /// Returns this [Object] if its type is [T].<br>
  /// Returns [Null] otherwise.
  T? typeCheckSafe<T>() {
    if (runtimeType == T) {
      return this;
    } else {
      return null;
    }
  }
}

extension JcpString on String {
  /// Returns [Null] if this [String] is empty.<br>
  /// Else returns this [String].
  String? get emptyIsNull => isEmpty ? null : this;

  /// Replaces the [character] at given [index] with [newChar]
  String replaceCharAt(int index, String newChar) => substring(0, index) + newChar + substring(index + 1);

  /// Generate random alphanumeric string of length [n]
  static String randomString(int n) => String.fromCharCodes(
        Iterable.generate(
          n,
          (_) => 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'.codeUnitAt(
            Random().nextInt('AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'.length),
          ),
        ),
      );

  /// Generate random string from chars in this [String]
  String randomStringFrom(int n) => String.fromCharCodes(
        Iterable.generate(
          n,
          (_) => codeUnitAt(
            Random().nextInt(length),
          ),
        ),
      );

  /// Parse this [String] to [int].<br>
  /// Throws [Exception] if not parse-able.
  int get toInt {
    var tryParse = int.tryParse(this);
    if (tryParse != null) {
      return tryParse;
    } else {
      throw Exception(
        '\n[Flutter_JCP] :: Invalid Parse Exception'
        '\n[Flutter_JCP] :: Could not parse "$this" into int',
      );
    }
  }

  /// Parse this [String] to [int].<br>
  /// Returns [0] if not parse-able.
  int get toIntSafe {
    var tryParse = int.tryParse(this);
    if (tryParse != null) {
      return tryParse;
    } else {
      return 0;
    }
  }

  /// Parse this [String] to [double].<br>
  /// Throws [Exception] if not parse-able.
  double get toDouble {
    var tryParse = double.tryParse(this);
    if (tryParse != null) {
      return tryParse;
    } else {
      throw Exception(
        '\n[Flutter_JCP] :: Invalid Parse Exception'
        '\n[Flutter_JCP] :: Could not parse "$this" into double',
      );
    }
  }

  /// Parse this [String] to [double].<br>
  /// Returns [0.0] if not parse-able.
  double get toDoubleSafe {
    var tryParse = double.tryParse(this);
    if (tryParse != null) {
      return tryParse;
    } else {
      return 0.0;
    }
  }
}

extension JcpNumber on num {
  /// Parse this [num] to [Duration].<br>
  /// Unit is milliseconds.
  Duration get ms => Duration(milliseconds: toInt());

  /// Parse this [num] to [String].<br>
  /// Inserts "," every 3 digits.<br>
  /// Throws [Exception] if not parse-able.
  String get toStringFormatted {
    List<String> split = toString().split('.');
    if (split.length == 2) {
      return '${split[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}.${split[1]}';
    } else if (split.length == 1) {
      return split[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
    } else {
      throw Exception(
        '\n[Flutter_JCP] Invalid Number Format Exception'
        '\n[Flutter_JCP] Too many "." in the number',
      );
    }
  }
}

extension JCPInt on int {
  /// Returns [Null] if this [int] is negative.<br>
  /// Else returns this [int].
  int? get negativeIsNull => this < 0 ? null : this;
}

extension JCPDouble on double {
  /// Returns [Null] if this [double] is negative.<br>
  /// Else returns this [double].
  double? get negativeIsNull => this < 0.0 ? null : this;
}

extension JCPDateTime on DateTime {
  /// Returns [Null] if this [DateTime] is before year 1971.<br>
  /// Else returns this [DateTime].
  DateTime? get epochIsNull => year <= 1970 ? null : this;

  /// Returns a more "readable" string formatted [DateTime].
  String get readable => '$year-'
      '${month < 10 ? '0' : ''}$month-'
      '${day < 10 ? '0' : ''}$day '
      '${hour < 10 ? '0' : ''}$hour:'
      '${minute < 10 ? '0' : ''}$minute';

  /// Returns a more "readable" string formatted [DateTime], but only YMD.
  String get readableMin => '$year-'
      '${month < 10 ? '0' : ''}$month-'
      '${day < 10 ? '0' : ''}$day';

  /// Returns a more "readable" string formatted [DateTime], but to the seconds.
  String get readableMax => '$year-'
      '${month < 10 ? '0' : ''}$month-'
      '${day < 10 ? '0' : ''}$day '
      '${hour < 10 ? '0' : ''}$hour:'
      '${minute < 10 ? '0' : ''}$minute:'
      '${second < 10 ? '0' : ''}$second';
}
