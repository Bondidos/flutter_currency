import 'package:flutter/material.dart';
import 'package:flutter_currency/presentation/app.dart';

import 'app/di/dependency_creator.dart';

void main() async {
  DependencyCreator.init();
  runApp(const App());
}
