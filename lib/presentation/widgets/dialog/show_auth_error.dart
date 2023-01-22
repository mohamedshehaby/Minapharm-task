import 'package:flutter/cupertino.dart';
import 'package:minapharm_task/data/network/failure.dart';
import 'package:minapharm_task/presentation/resources/strings_manager.dart';
import 'package:minapharm_task/presentation/widgets/dialog/generic_dialog.dart';

Future<void> showAuthFailureDialog({required BuildContext context, required Failure authFailure}) {
  return showGenericDialog<void>(
    context: context,
    title: AppStrings.errorHappened,
    content: authFailure.message,
    optionsBuilder: () => {AppStrings.ok: true},
  );
}
