import 'package:formz/formz.dart';

enum PasswordInputError { empty }

class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');

  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  @override
  PasswordInputError? validator(String value) {
    return value.length >= 8 ? null : PasswordInputError.empty;
  }
}
