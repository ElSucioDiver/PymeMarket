import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mi_proyecto/firebase_options.dart';
import 'package:mi_proyecto/graficos_ventas.dart';
import 'package:mi_proyecto/home.dart';
import 'package:mi_proyecto/listado_productos.dart';
import 'package:mi_proyecto/services/models/product.dart';
import 'package:provider/provider.dart';
import 'registro_productos.dart';
import 'package:english_words/english_words.dart';
import 'carrito.dart';
import 'proveedor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(), // Proveedor de carrito
      child: MaterialApp(
        title: 'Pyme Market',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 238, 215, 242),
          ),
        ),
        home: HomePage(),
        routes: {
          '/admin': (context) => AdminSidebar(),
          '/carrito': (context) => ShoppingCartPage(),
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];
  var products = <Product>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }
}

class AdminSidebar extends StatefulWidget {
  @override
  State<AdminSidebar> createState() => _SideBar();
}

class _SideBar extends State<AdminSidebar> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = ProductRegistrationPage();
        break;
      case 2:
        page = EcommerceMainView();
        break;
      case 3:
        page = ChartsScreen();
        break;
      case 4:
        page = ShoppingCartPage(); // Agregué la pantalla del carrito
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.app_registration),
                    label: Text('Registro de Productos'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.filter_list),
                    label: Text('Listado de Productos'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.auto_graph),
                    label: Text('Registro de Ventas'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.shopping_cart),
                    label: Text('Carrito'), // Opción para ir al carrito
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 30,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}
