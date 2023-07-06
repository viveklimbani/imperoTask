import 'package:auto_route/annotations.dart';
import 'package:impero_task/feature/product_screen.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Page, Route',
  routes: <AutoRoute>[
    AutoRoute(page: ProductScreen, initial: true, path: routeProductScreen),
  ],
)
class $AppRouter {}

const routeProductScreen = "product_screen";

