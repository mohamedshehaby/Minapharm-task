import 'package:minapharm_task/core/exceptions.dart';
import 'package:minapharm_task/data/data_source/local_data_source/hive_manager.dart';
import 'package:minapharm_task/domain/entities/user_credentials.dart';
import 'package:minapharm_task/domain/entities/user_entity.dart';

abstract class AuthLocalDataSource {
  Future<UserEntity> login(UserCredentials userCredentials);
  Future<UserEntity> signup(UserCredentials userCredentials);
  Future<void> signOut();
  Future<UserEntity?> isUserLoggedIn();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  HiveManager hiveManager;

  /// [_saveCurrentUser] Save the current user to login automatically
  Future<void> _saveCurrentUser(UserCredentials userCredentials) async {
    final appConfig = await hiveManager.openAppConfigBox();
    appConfig.put(HiveKeys.username, userCredentials.username);
  }

  /// [_isUserExist] to check if the user exists in the db
  Future<bool> _isUserExist(UserCredentials userCredentials) async {
    final users = await hiveManager.openUsersBox();
    final isUserExist = users.get(userCredentials.username);
    return isUserExist == null ? false : true;
  }

  /// [signup] handle signup
  @override
  Future<UserEntity> signup(UserCredentials userCredentials) async {
    final isUserExist = await _isUserExist(userCredentials);

    /// if the user exists throw [UserExistsException]
    if (isUserExist) {
      throw UserExistsException();
    }

    final users = await hiveManager.openUsersBox();
    await users.put(userCredentials.username, userCredentials.password);

    await _saveCurrentUser(userCredentials);
    return UserEntity(username: userCredentials.username);
  }

  @override
  Future<UserEntity> login(UserCredentials userCredentials) async {
    final isUserExist = await _isUserExist(userCredentials);

    ///  if the user not exists throw [NoUserException]
    if (!isUserExist) {
      throw NoUserException();
    }
    final isPasswordCorrect = await _isPasswordCorrect(userCredentials);

    /// if the password not correct throw [WrongPasswordException]
    if (!isPasswordCorrect) {
      throw WrongPasswordException();
    }

    await _saveCurrentUser(userCredentials);

    return UserEntity(username: userCredentials.username);
  }

  /// [signOut] handle sign-out
  @override
  Future<void> signOut() async {
    final appConfig = await hiveManager.openAppConfigBox();
    await appConfig.delete(HiveKeys.username);
  }

  /// [isUserLoggedIn] to check if the user already logged in.
  @override
  Future<UserEntity?> isUserLoggedIn() async {
    final appConfigBox = await hiveManager.openAppConfigBox();
    if (appConfigBox.containsKey(HiveKeys.username)) {
      return UserEntity(username: appConfigBox.get(HiveKeys.username));
    }
    return null;
  }

  /// [_isPasswordCorrect] to check for the password correctness.
  Future<bool> _isPasswordCorrect(UserCredentials userCredentials) async {
    final users = await hiveManager.openUsersBox();
    return users.get(userCredentials.username) == userCredentials.password;
  }

  AuthLocalDataSourceImpl({
    required this.hiveManager,
  });
}
