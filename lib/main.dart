import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_internet_radio/bloc_observer.dart';
import 'app.dart';
import 'injection_container.dart' as di;

// todo add similarity search to alan ai

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  Bloc.observer = MyBlocObserver();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
