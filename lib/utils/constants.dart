import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Constants {
  static AppLocalizations translate(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}

enum UserType { student, teacher }
