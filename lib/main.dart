import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/offering/provider/offering_provider.dart';
import 'features/offering/ui/offering_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OfferingsProvider(),
      child: MaterialApp(
        title: 'Holistic Offerings App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: OfferingsListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}



class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OfferingsListScreen()),
            );
          },
          child: const Text('View Offerings'),
        ),
      ),
    );
  }
}
