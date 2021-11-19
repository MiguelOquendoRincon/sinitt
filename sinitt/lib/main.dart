import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinitt/routes/routes.dart';
import 'package:sinitt/utils/hexcolor.dart';
import 'package:sinitt/utils/screen_size.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // *Se establece la orientacion como vertical siempre, para evitar que se vea extraño al girar el telefono.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    // *En este apartado se configuran los colores del la barra de notificaciones, así como los de la navegación.
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: HexColor('#004884'),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: HexColor('#004884'),
        systemNavigationBarIconBrightness: Brightness.light
      )
    );

    // !ICONO PARA MOSTRAR LA UBICACION ACTUAL
    // person_pin_circle
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            ScreenSize().init(constraints, orientation);
            return MaterialApp(

              localizationsDelegates: const[
                GlobalMaterialLocalizations.delegate
              ],
              supportedLocales: const [
                Locale('es'),
                Locale('en')
              ],
              title: 'SINITT',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // *Usado para los títulos, subtitulos y encabezados de las tablas.
                // Crear una clase que maneje los estilos con su respectiva fuente
                primaryTextTheme: GoogleFonts.montserratTextTheme(
                  Theme.of(context).textTheme,
                ),
      //   backgroundColor: HexColor('#00FFFFFF'),
                canvasColor: HexColor('#00FFFFFF'),
                /*FALTA AGREGAR #069169, #FFAB00, #4B4B4B, #F2F2F2*/
                primaryColor: HexColor('#004884'),
                shadowColor: HexColor('#BABABA'),
                dividerColor: HexColor('#F6F8F9'),
                toggleButtonsTheme: ToggleButtonsThemeData(
                  color: HexColor('#E6EFFD'),
                ),
                cardColor: HexColor('#3366CC'),
                buttonTheme: ButtonThemeData(
                  buttonColor: HexColor('#3366CC'),
                  disabledColor: HexColor('#BABABA'),
                ),
                errorColor: HexColor('#A80521'),
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
        );
      }
    );
  }
}


