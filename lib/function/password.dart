import 'package:flutter/material.dart';

/// Validates given password.<br>
/// Returns [True] if all requirements are met.<br>
bool validatePassword(
  String password, {
  int requiredLength = 8,
  bool requireLowerCase = true,
  bool requireUpperCase = true,
  bool requireNumCase = true,
  bool requireSpecialCase = true,
}) {
  if (password.length < requiredLength) return false;

  final validLowerCase = RegExp(r'^[a-z]+$');
  int lowerCaseCnt = requireLowerCase ? 0 : 1;

  final validUpperCase = RegExp(r'^[A-Z]+$');
  int upperCaseCnt = requireUpperCase ? 0 : 1;

  final validNumCase = RegExp(r'^[0-9]+$');
  int numCnt = requireNumCase ? 0 : 1;

  final validSpecialCase = RegExp(r'^[!@#%^&*]+$');
  int specialCharCnt = requireSpecialCase ? 0 : 1;

  for (String c in password.characters) {
    validLowerCase.hasMatch(c) ? lowerCaseCnt++ : null;
    validUpperCase.hasMatch(c) ? upperCaseCnt++ : null;
    validNumCase.hasMatch(c) ? numCnt++ : null;
    validSpecialCase.hasMatch(c) ? specialCharCnt++ : null;
  }

  return (lowerCaseCnt != 0 && upperCaseCnt != 0 && numCnt != 0 && specialCharCnt != 0);
}

/// Evaluates given password.<br>
/// Returns [int], corresponding to the strength of given password.<br><br>
/// Some index to consider : <br>
/// [0] => unusable password<br>
/// [1] => usable password, but weak<br>
/// [2] => usable password, but moderate<br>
/// [3] => usable password, pretty strong<br>
/// bigger than [3] => really strong password
int passwordStrength(
  String password, {
  int requiredLength = 8,
  bool requireLowerCase = true,
  bool requireUpperCase = true,
  bool requireNumCase = true,
  bool requireSpecialCase = true,
}) {
  if (password.length < requiredLength) return 0;

  final validLowerCase = RegExp(r'^[a-z]+$');
  int lowerCaseCnt = requireLowerCase ? 0 : 1;

  final validUpperCase = RegExp(r'^[A-Z]+$');
  int upperCaseCnt = requireUpperCase ? 0 : 1;

  final validNumCase = RegExp(r'^[0-9]+$');
  int numCnt = requireNumCase ? 0 : 1;

  final validSpecialCase = RegExp(r'^[!@#%^&*]+$');
  int specialCharCnt = requireSpecialCase ? 0 : 1;

  for (String c in password.characters) {
    validLowerCase.hasMatch(c) ? lowerCaseCnt++ : null;
    validUpperCase.hasMatch(c) ? upperCaseCnt++ : null;
    validNumCase.hasMatch(c) ? numCnt++ : null;
    validSpecialCase.hasMatch(c) ? specialCharCnt++ : null;
  }

  return ((lowerCaseCnt * upperCaseCnt * numCnt * specialCharCnt) / password.length).floor();
}
