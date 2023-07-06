import 'package:flutter/material.dart';
import 'package:impero_task/app.dart';

import 'di/di_service.dart';

///Global connectivity var
var isConnected = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getServices();
  runApp(const ImperoTask());
}
