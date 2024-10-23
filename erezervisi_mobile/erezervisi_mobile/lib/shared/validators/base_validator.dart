import 'package:erezervisi_mobile/shared/validators/validations.dart';

class BaseValidator {

  BaseValidator();

  String? required(dynamic value) {
    if (value is String?) {
      if (value == null || value.isEmpty) {
        return ValidationMessages.required;
      }
      return null;
    }

    if (value is num?) {
      if (value == null || value == 0) {
        return ValidationMessages.required;
      }
      return null;
    }

    if (value == null) {
      return ValidationMessages.required;
    }

    return null;
  }

  String? numberOnly(dynamic value) {
    if (value == null || value == 0 || value == '') {
      return ValidationMessages.required;
    }

    var parsedValue = num.tryParse(value as String);

    if (parsedValue == null) {
      return ValidationMessages.invalidFormat;
    }

    return null;
  }
}