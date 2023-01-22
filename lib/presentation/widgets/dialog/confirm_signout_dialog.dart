import 'package:flutter/material.dart';
import 'package:minapharm_task/presentation/resources/resources.dart';
import 'package:minapharm_task/presentation/widgets/dialog/generic_dialog.dart';

Future<bool?> showConfirmSignOutDialog({required BuildContext context}) {
  return showGenericDialog<bool>(
    context: context,
    title: AppStrings.areYouSure,
    content: AppStrings.sureToSignOut,
    optionsBuilder: () => {AppStrings.signOut: true, AppStrings.cancel: false},
  );
}
