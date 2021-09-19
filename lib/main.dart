import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mgmt_provider/models/cart_model.dart';
import 'package:state_mgmt_provider/models/catalog_model.dart';
import 'package:state_mgmt_provider/screens/cart.dart';
import 'package:state_mgmt_provider/screens/catalog.dart';
import 'package:state_mgmt_provider/screens/login.dart';
import 'package:state_mgmt_provider/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(
          create: (context) => CatalogModel(),
        ),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
            create: (context) => CartModel(),
            update: (context, catalog, cart) {
              if (cart == null) throw ArgumentError.notNull('cart');
              cart.catalog = catalog;
              return cart;
            }),
      ],
      child: MaterialApp(
          title: 'Provider Demo',
          theme: appTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const MyLogin(),
            '/catalog': (context) => const MyCatalog(),
            '/cart': (context) => const MyCart(),
          }),
    );
  }
}
