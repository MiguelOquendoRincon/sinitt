import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinitt/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SINITT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // *Usado para los títulos, subtitulos y encabezados de las tablas.
        // Crear una clase que maneje los estilos con su respectiva fuente
        primaryTextTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),

        
        

        // *Usado para los parrafos, captions, botones y campos de texto.
        textTheme: GoogleFonts.workSansTextTheme(
          Theme.of(context).textTheme,
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}


