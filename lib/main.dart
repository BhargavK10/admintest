import 'package:admintest/auth/auth_gates.dart';
import 'package:admintest/providers/cart_provider.dart';
import 'package:admintest/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized;
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ProductProvider()),
        ChangeNotifierProvider(create: (_)=> CartProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthGates(),
      ),
    );
  }
}



// // import 'package:aftermarket/homepage.dart';
// import 'package:flutter/material.dart';
// // import 'package:aftermarket/providers/product_provider.dart';
// // import 'package:aftermarket/screens/product_page.dart';
// // import 'package:aftermarket/performanceproducts.dart';
// import 'package:aftermarket/login.dart';
// // import 'package:aftermarket/product.dart';
// // import 'package:provider/provider.dart';
// // import 'providers/cart_provider.dart';

// void main() {
//   runApp(
//     const MyApp()
//     // ChangeNotifierProvider(
//     //   create: (_) => CartProvider(),
//     //   child: MyApp(),
//     // )
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginPage(),
//     );
//     // return MultiProvider(
//     //   providers: [
//     //     ChangeNotifierProvider(create: (_)=> ProductProvider()),
//     //     ChangeNotifierProvider(create: (_)=> CartProvider())
//     //   ],
//     //   child: MaterialApp(
//     //     debugShowCheckedModeBanner: false,
//     //     home: ProductPage(),
//     //   ),
//     // );
//   }
// }