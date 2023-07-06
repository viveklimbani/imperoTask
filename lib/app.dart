import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:impero_task/provider/product_screen_provider.dart';
import 'package:impero_task/repository/base_repository.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

import 'app_route.gr.dart';
import 'di/di_service.dart';
import 'main.dart';

class ImperoTask extends StatefulWidget {
  const ImperoTask({Key? key}) : super(key: key);

  static List<ConnectivityErrorModel> listOfPendingFunctions = [];
  @override
  _ImperoTaskState createState() => _ImperoTaskState();
}

class _ImperoTaskState extends State<ImperoTask> {
  final botToastBuilder = BotToastInit();
  Connectivity connectivity = Connectivity();

  final _appRouter = getIt.get<AppRouter>();

  Future<void>? _initializeFlutterFireFuture;
  Future<void> _initializeFlutterFire() async {}

  @override
  void initState() {
    super.initState();
    _initializeFlutterFireFuture = _initializeFlutterFire();
    connectivity.onConnectivityChanged.listen((event) {
      isConnected = event != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeFlutterFireFuture,
        builder: (context, snap) {
          switch (snap.connectionState) {
            case ConnectionState.done:
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => ProductScreenProvider(),
                  ),
                ],
                child: MaterialApp.router(
                  title: "Impero Task",
                  themeMode: ThemeMode.dark,
                  debugShowCheckedModeBanner: false,
                  builder: (context, child) {
                    child = botToastBuilder(context, child);
                    child = OneContext().builder(context, child);

                    return child;
                  },
                  supportedLocales: const [Locale('en', '')],
                  routerDelegate: _appRouter.delegate(),
                  routeInformationParser: _appRouter.defaultRouteParser(),
                ),
              );

            default:
              return Container();
          }
        });
  }
}
