import 'package:formz/formz.dart';

enum UserNameInputError { empty }

class UserNameInput extends FormzInput<String, UserNameInputError> {
  const UserNameInput.pure() : super.pure('');

  const UserNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  UserNameInputError? validator(String value) {
    return value.trim().length >= 8 == true ? null : UserNameInputError.empty;
  }
}
