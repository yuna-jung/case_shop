import 'package:flutter/material.dart';
import 'package:shopping_mall_project/homepage/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent,
          brightness: Brightness.light,
        ),
      ),
      home: const Homepage(),
    );
  }
}


//import 'package:flutter/material.dart';
// import 'pages/product_list_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CaseShop',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
//         useMaterial3: true,
//       ),
//       home: const ProductListPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }