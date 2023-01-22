import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:minapharm_task/core/di.dart' as di;
import 'package:minapharm_task/domain/entities/movie_entity.dart';
import 'package:minapharm_task/presentation/blocs/simple_bloc_oberserver.dart';
import 'package:minapharm_task/presentation/screens/app.dart';

void main() async {
  // Ensure that Flutter engine already started and binding is ok
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await Hive.initFlutter();
  Hive.registerAdapter(MovieEntityAdapter());

  Bloc.observer = SimpleBlocObserver();
  runApp(const App());
}
