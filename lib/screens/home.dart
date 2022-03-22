import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:sinitt/api/api_foto_deteccion.dart';
import 'package:sinitt/api/api_peajes.dart';
import 'package:sinitt/api/api_signals.dart';
import 'package:sinitt/api/api_situtations.dart';
import 'package:sinitt/models/foto_deteccion_model.dart' as foto_deteccion;
import 'package:sinitt/models/peaje_model.dart' as peaje;
import 'package:sinitt/models/signals_model.dart' as signals;
import 'package:sinitt/models/situation_model.dart' as situation;
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/hexcolor.dart';
import 'package:sinitt/utils/icons.dart';
import 'package:sinitt/utils/screen_size.dart';
import 'package:sinitt/utils/text_style.dart';
import 'package:sinitt/widgets/drawer.dart';


class HomePage extends StatefulWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // *Importa los estilos definidos en una clase con el fin de reutilizarlos.
  TextStyles textStyles = TextStyles();
  // *Ubicación inicial quemada por el momento. En un futuro se actualizará según la ubicación del usuario.
  double? latitude = 7.1123734;
  double? longitude = -73.1165309;
  // *Usado para mostrar una alerta en caso que el usuario no acceda a encender el GPS.
  bool hasToShowAlert = false;
  // *Para obtener la ubicación del usuario.
  final location = Location();
  // *Darle formato a las fechas y horas.
  final hourFormatter = DateFormat('hh:mm a');
  final formatter = DateFormat('dd/MMM/yyyy');

  bool isLoading = true;
  bool showFailedLoad = false;

  MapboxMapController? mapController;
  // String accessToken = "sk.eyJ1IjoibWlndWVsb3F1ZW5kbzk5IiwiYSI6ImNrdzlubWMybjF1aHcydW8wYmQyaWJraGsifQ.rX5AW7lNpS00JsMmN2lTIQ";

  // *Usado para guardar los datos de las situaciones.
  Map<String, dynamic> situationJson = {};
  // *Usado para guardar los datos de los peajes.
  Map<String, dynamic> peajeJson = {};
  // *Usado para guardar los datos de las cámaras de detección.
  Map<String, dynamic> fotoDeteccionJson = {};
  //* Usado para guardar los datos de las señales.
  Map<String, dynamic> signalsJson = {};
  UserPreferences userPrefs = UserPreferences(); 


  // *Lee el JSON requerido y lo guarda en la variable para usarlos luego en la función que carga los iconos.
  Future<void> readJson(String jsonName) async {
    // final String response = await rootBundle.loadString('assets/geojson/$jsonName.json');
    // singletonApiFotoDetection.getFotoDetection().then((value) {
    //   var data = situation.situationFromJson(response);
    //   var jsonData = data.toJson();
    //   setState(() => situationJson = jsonData);
    // });
    if(jsonName == 'situation'){
      // * ?departmentCode=05&municipalityCode=05001&roadCode=6204
      await singletonApiSituations.getSituations(
        depCode: userPrefs.depID != "" ? "?departmentCode=" + userPrefs.depID : "",
        muniCode: userPrefs.muniID != "" ? "&municipalityCode=" + userPrefs.muniID : "", 
        viaCode: userPrefs.viaID != "" ? "&roadCode=" + userPrefs.viaID : "",
      ).then((value) {
        var data = situation.situationFromJson(value);
        var jsonData = data.toJson();
        setState(() => situationJson = jsonData);
        
      });
    } else if(jsonName == 'peajes'){
      await singletonApiPeajes.getPeajes(
        depCode: userPrefs.depID != "" ? "?departmentCode=" + userPrefs.depID : "",
        muniCode: userPrefs.muniID != "" ? "&municipalityCode=" + userPrefs.muniID : "", 
        viaCode: userPrefs.viaID != "" ? "&roadCode=" + userPrefs.viaID : "",
      ).then((value) {
        var data = peaje.peajesFromJson(value);
        var jsonData = data.toJson();
        setState(() => peajeJson = jsonData);
      });
    } else if(jsonName == 'fotodeteccion'){
      await singletonApiFotoDetection.getFotoDetection(
        depCode: userPrefs.depID != "" ? "?departmentCode=" + userPrefs.depID : "",
        muniCode: userPrefs.muniID != "" ? "&municipalityCode=" + userPrefs.muniID : "", 
        viaCode: userPrefs.viaID != "" ? "&roadCode=" + userPrefs.viaID : "",
      ).then((value) {
        var data = foto_deteccion.fotoDeteccionFromJson(value);
        var jsonData = data.toJson();
        setState(() => fotoDeteccionJson = jsonData);
        // userPrefs.userCapFilter = "";
        // userPrefs.depID = "";
        // userPrefs.muniID = "";
        // userPrefs.viaID = "";
      });
    } else if(jsonName == 'signals'){
      await singletonApiSignals.getSignals(
        depCode: userPrefs.depID != "" ? "?departmentCode=" + userPrefs.depID : "",
        muniCode: userPrefs.muniID != "" ? "&municipalityCode=" + userPrefs.muniID : "", 
        viaCode: userPrefs.viaID != "" ? "&roadCode=" + userPrefs.viaID : "",
      ).then((value) {
        var data = signals.signalsFromJson(value);
        var jsonData = data.toJson();
        setState(() => signalsJson = jsonData);
      });
    }
  }


  // *Funcion que se llama cuando el mapa se creo para pasarle los parametros requeridos al controlador.
  void _onMapCreated(MapboxMapController controller) => mapController = controller;


  // *Funcion que se encarga de cargar todos los datos de los GeoJson y agregar los iconos pertinentes
  // Con prefs definimos por defecto que se carguen todos. Si no hacemos un switch con numero de la capa a cargar.
  void _loadIcons(MapboxMapController controller) async{
    try{
      switch (userPrefs.userCapFilter) {
        case "":
          await _loadSituations();
          await _loadPeajes();
          await _loadFotoDetections();
          await _loadSignals();
          break;
        case "Situaciones":
          await _loadSituations();
          break;

        case "Peajes":
          await _loadPeajes();
          break;
        
        case "Foto Deteccion":
          await _loadFotoDetections();
          break;

        case "Señales":
          await _loadSignals();
          break;
        default:
        await _loadSituations();
        await _loadPeajes();
        await _loadFotoDetections();
        await _loadSignals();
      }
      userPrefs.depID = "";
      userPrefs.muniID = "";
      userPrefs.viaID = "";
      userPrefs.userCapFilter = "";
      mapController!.onSymbolTapped.add((argument) => _onSymbolTapped(argument));
      setState(() => isLoading = false);
    } catch(e){
      setState(() => isLoading = false);
      _showFailedLoad('Tuvimos problemas al cargar la información. Verifica tu conexión a internet o intentalo más tarde');
    }
    
  }


  Future _loadSituations()async{
    try{
      await readJson('situation');
      List<SymbolOptions> symbols = [];
      List<Map<dynamic, dynamic>> symbolsData = [];
      var datosTratados = situation.Situation.fromJson(situationJson);
      for (var element in datosTratados.features!) {
        symbols.add(SymbolOptions(
          geometry: LatLng(element.geometry!.coordinates![1], element.geometry!.coordinates![0]),
          iconSize: 2.0,
          iconImage: 'situation',
          zIndex: 1
        ),);
        symbolsData.add(element.toJson());
      }
      mapController!.addSymbols(symbols, symbolsData);
    } catch(e){
      _showFailedLoad('Tuvimos problemas al cargar la situación.');
      _loadPeajes();
      _loadFotoDetections();
    }

  }

  Future _loadPeajes() async{
    try{
      await readJson('peajes');
      /*El siguiente bloque se encarga de cargar, recorrer y agregar los peajes al mapa.
        Importante recordar que para agregar el simbolo correcto se debe validar con texto al momento de ir agregando*/
      List<SymbolOptions> peajeSymbols = [];
      List<Map<dynamic, dynamic>> peajeSymbolsData = [];
      var datosPeajeTratados = peaje.Peajes.fromJson(peajeJson);
      for (var element in datosPeajeTratados.features!) {
        peajeSymbols.add(SymbolOptions(
          geometry: LatLng(element.geometry!.coordinates![1], element.geometry!.coordinates![0]),
          iconSize: 2.0,
          iconImage: 'peaje',
          zIndex: 1
        ),);
        peajeSymbolsData.add(element.toJson());
      }
      mapController!.addSymbols(peajeSymbols, peajeSymbolsData);
    } catch(e){
      _showFailedLoad('Tuvimos problemas al cargar los peajes.');
      _loadFotoDetections();
    }

  }


  Future _loadFotoDetections() async{
    try{
      await readJson('fotodeteccion');
      /*El siguiente bloque se encarga de cargar, recorrer y agregar las fotodetecciones al mapa.
        Importante recordar que para agregar el simbolo correcto se debe validar con texto al momento de ir agregando*/
      List<SymbolOptions> fotoDeteccionSymbols = [];
      List<Map<dynamic, dynamic>> fotoDetectionSymbolsData = [];
      var datosFotoDetectionTratados = foto_deteccion.FotoDeteccion.fromJson(fotoDeteccionJson);
      for (var element in datosFotoDetectionTratados.features!) {
        fotoDeteccionSymbols.add(SymbolOptions(
          geometry: LatLng(element.geometry!.coordinates![1], element.geometry!.coordinates![0]),
          iconSize: 2.0,
          iconImage: 'fotoDeteccion',
          zIndex: 1
        ),);
        fotoDetectionSymbolsData.add(element.toJson());
      }
      mapController!.addSymbols(fotoDeteccionSymbols, fotoDetectionSymbolsData);
      /*------------------------------------------------------------------------------------------*/
    } catch(e){
      _showFailedLoad('Tuvimos problemas al cargar las cámara de Fotodetección.');
      _loadSignals();
    }

  }

  Future _loadSignals() async{
    try{
      await readJson('signals');
      /*El siguiente bloque se encarga de cargar, recorrer y agregar las fotodetecciones al mapa.
        Importante recordar que para agregar el simbolo correcto se debe validar con texto al momento de ir agregando*/
      List<SymbolOptions> signalSymbols = [];
      List<Map<dynamic, dynamic>> signalsSymbolData = [];
      var datosSignalTratados = signals.Signals.fromJson(signalsJson);
      for (var element in datosSignalTratados.features!) {
        signalSymbols.add(SymbolOptions(
          geometry: LatLng(element.geometry!.coordinates![1], element.geometry!.coordinates![0]),
          iconSize: 2.0,
          iconImage: 'signal',
          zIndex: 1
        ),);
        signalsSymbolData.add(element.toJson());
      }
      mapController!.addSymbols(signalSymbols, signalsSymbolData);
      /*------------------------------------------------------------------------------------------*/
    } catch(e){
      setState(() => isLoading = false);
      _showFailedLoad('Tuvimos problemas al cargar las señales.');
    }
  }

  

  //*Funcion encargada de mostrar las alertas cuando se presiona sobre un icono o simbolo dentro de MapBox
  void _onSymbolTapped(Symbol symbol) => _showEventInfo(symbol.data, symbol.options.iconImage);
  

  // *Funcion que agrega el asset y lo etiqueta con una llave para poder usarlo luego en Mapbox.
  void _onStyleLoaded(){
    addImageFromAsset("situation", "assets/images/icono-obstruccion-general.png");
    addImageFromAsset("peaje", "assets/images/icono-capa-peajes.png");
    addImageFromAsset("fotoDeteccion", "assets/images/icono-capa-camaras.png");
    addImageFromAsset("signal", "assets/images/icono-senal-foto.png");
  }


  // *Funcion que se ejecuta luego de crear el mapa para poder dibujar los iconos.
  void _onStyleLoadedCallback(){
    _onStyleLoaded();
    _loadIcons(mapController!);
  }


  // * Funcion que se llama para cargar y agregar imagenes como iconos a Mapbox.
  Future<void> addImageFromAsset(String name, String assetName) async{
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  
  // *Funcion encargada de preguntar si el GPS está activo, en caso de no estarlo lo solicita y actualiza las coordenadas.
  void getPermission() async{
    if (await location.serviceEnabled()) {
      var userLocation = await location.getLocation();
      setState(() {
        latitude = userLocation.latitude!;
        longitude = userLocation.longitude!;
      });
    } else {
      bool userHasGPSActive = await location.requestService();
      if(userHasGPSActive){
        var userLocation = await location.getLocation();
        setState(() {
          latitude = userLocation.latitude!;
          longitude = userLocation.longitude!;
          // isLoadingLocation = false;
          hasToShowAlert = false;
        });
      } else{
        setState(() {
          // isLoadingLocation = false;
          hasToShowAlert = true;
        });
      }
      
      //caso que el usuario tenga activo el gps
    }
  }


  @override
  void initState(){
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: hasToShowAlert
        ? _showAlert()
        : buildMap(),
    );
  }


  // *Alerta usada para cuando el usuario no acepta activar el GPS.
  _showAlert(){
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin:EdgeInsets.only(top: ScreenSize.screenHeight * 0.45, bottom: 20.0),
            width: ScreenSize.screenWidth * 0.9,
            child: Text(
              'Si no activas la ubicación, no podrás usar nuestra aplicación. ¿Deseas activarla?',
              textAlign: TextAlign.center,
              style: textStyles.blackText(),
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              getPermission();
            }, 
            child: Text(
              'Sí, activar automaticamente',
              style: textStyles.whiteText(),
            )
          ),
        ],
      ),
    );
  }


  // *Widget que dibuja el mapa de toda la pantalla y el ícono para poder acceder al drawer.
  Widget buildMap() {
    return SafeArea(
      child: Stack(
        children: [
          MapboxMap(
            // accessToken: accessToken,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            onStyleLoadedCallback: _onStyleLoadedCallback,
            initialCameraPosition: const CameraPosition(
              // target: LatLng(latitude!, longitude!),
              target: LatLng(4.706799, -74.0543671),
              zoom: 15
            )
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenSize.screenWidth * 0.020, left: ScreenSize.screenWidth * 0.020),
            child: TextButton(
              child: CircleAvatar(
                radius: ScreenSize.screenWidth * 0.058999,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.menu, color: Colors.white, size: ScreenSize.screenWidth * 0.065999,)
              ),
              onPressed: (){ 
                _scaffoldKey.currentState!.openDrawer();
                // Navigator.pushNamed(context, '/drawer');
              },
            ),
          ),

          isLoading 
          ? const Center(child: CircularProgressIndicator.adaptive()) 
          : const SizedBox()
        ],
      ),
    );
  }


  _showFailedLoad(String message){
    return showCupertinoDialog(
      context: context, 
      builder: (_){
        return CupertinoAlertDialog(
          title: Text(message),
          content: CupertinoButton(
            color: HexColor('#3366CC'),
            child: Text('Entendido', style: textStyles.whiteText(),),
            onPressed: () => Navigator.of(context).pop()
          ),
        );
      }
    );
  }


  // *Esta funcion recibe los datos del symbol seleccionado por el usuario así como el nombre del icono asignado.
  // *Usando este nombre se define el tipo de alerta que se dibujará.
  // *@params symbolData: Recibe todo el objeto de propiedades particular.
  // *@params eventType: Recibe el nombre que sirve para identificar que tipo de evento es.
  _showEventInfo(symbolData, String? eventType){
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).primaryColor,
      builder: (_){
        if(eventType == 'situation'){
          situation.Feature eventData = situation.Feature.fromJson(symbolData);
          return _situationAlert(eventData);
        } else if(eventType == 'peaje'){
          peaje.Feature eventData = peaje.Feature.fromJson(symbolData);
          return _peajeAlert(eventData);
        } else if(eventType == 'fotoDeteccion'){ //if(eventType == 'fotoDeteccion')
          foto_deteccion.Feature eventData = foto_deteccion.Feature.fromJson(symbolData);
          return _camaraDetectionAlert(eventData);
        } else {
          signals.Feature eventData = signals.Feature.fromJson(symbolData);
          return _signalAlert(eventData);
        } 
      }
    );
  }


  //*Widget que retorna la alerta de una situacion informando sus datos en particular.
  // *@params eventData: Recibe todo el objeto de propiedades particular.
  Widget _situationAlert(situation.Feature eventData){
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                // width: ScreenSize.screenWidth * 0.75,
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset:  Offset(-ScreenSize.screenWidth * 0.025, -ScreenSize.screenWidth * 0.01),
                          child: Transform.rotate(
                            angle: pi/4,
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 50),
                              height: ScreenSize.screenWidth * 0.0550,
                              width: ScreenSize.screenWidth * 0.0550,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 20.0, right: 20.0),
                          child: Text(
                            '${eventData.properties!.situationType}',
                            style: textStyles.whiteText(
                              context: context,
                              fontSize: ScreenSize.screenWidth * 0.065,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        'Cra 45 # 55-10 - Bogotá',
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.045,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        "Desde: " + hourFormatter.format(eventData.properties!.situationDate!).toLowerCase() + " " + formatter.format(eventData.properties!.situationDate!),
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    ),

//                     Text('''Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
// Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a
// galley of type and scrambled it to make a type specimen book.''',
//                       style: textStyles.whiteText(
//                         context: context,
//                         fontSize: ScreenSize.screenWidth * 0.038
//                       )
//                     )
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/icono-accidente.svg',
                  alignment: Alignment.center,
                  width: ScreenSize.screenWidth * 0.2,
                  height: ScreenSize.screenWidth * 0.2,
                ),
                
                // Icon(
                //   SinittIcons.icono_accidente_circular,
                //   // color: Colors.white,
                //   size: ScreenSize.screenWidth * 0.15,
                // ),
              )
            ],
          )
        ],
      ),
    );
  }


  //*Widget que retorna la alerta de un peaje informando sus datos en particular.
  // *@params eventData: Recibe todo el objeto de propiedades particular.
  Widget _peajeAlert(peaje.Feature eventData){
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                // width: ScreenSize.screenWidth * 0.75,
                padding: const EdgeInsets.only(top: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset:  Offset(-ScreenSize.screenWidth * 0.025, -ScreenSize.screenWidth * 0.01),
                          child: Transform.rotate(
                            angle: pi/4,
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 50),
                              height: ScreenSize.screenWidth * 0.0550,
                              width: ScreenSize.screenWidth * 0.0550,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 20.0, right: 20.0),
                          child: Text(
                            'Peaje ${eventData.properties!.nombre}',
                            style: textStyles.whiteText(
                              context: context,
                              fontSize: ScreenSize.screenWidth * 0.065,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
                      child: Text(
                        'Vía Bogotá - Villavicencio',
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.045,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
                      child: Text(
                        'Código de Vía: ${eventData.properties!.via}',
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
                      child: Text(
                        'Territorio: ${eventData.properties!.depto}',
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
                      child: Text(
                        'Sector: ${eventData.properties!.sector}',
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: ScreenSize.screenWidth * 0.045),
                child: SvgPicture.asset(
                  'assets/icons/icono-peaje.svg',
                  alignment: Alignment.center,
                  width: ScreenSize.screenWidth * 0.20,
                  height: ScreenSize.screenWidth * 0.20,
                ),
              ),
            ],
          ),
          Container(
            width: ScreenSize.screenWidth * 0.90,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                SizedBox(
                  width: ScreenSize.screenWidth * 0.45,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              "I\$:",
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            )
                          ),
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              '\$12.800',
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),


                SizedBox(
                  width: ScreenSize.screenWidth * 0.45,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              "IV\$:",
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            )
                          ),
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              '\$53.100',
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),


          Container(
            width: ScreenSize.screenWidth * 0.90,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                SizedBox(
                  width: ScreenSize.screenWidth * 0.45,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              "II\$:",
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            )
                          ),
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              '\$18.000',
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),


                SizedBox(
                  width: ScreenSize.screenWidth * 0.45,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              "V\$:",
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            )
                          ),
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              '\$66.000',
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          Container(
            width: ScreenSize.screenWidth * 0.90,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                SizedBox(
                  width: ScreenSize.screenWidth * 0.45,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              "III\$:",
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            )
                          ),
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              '\$25.400',
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),


                SizedBox(
                  width: ScreenSize.screenWidth * 0.45,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              "VI\$:",
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            )
                          ),
                          SizedBox(
                            width: ScreenSize.screenWidth * 0.20,
                            child: Text(
                              '\$78.300',
                              style: textStyles.whiteText(
                                context: context,
                                fontSize: ScreenSize.screenWidth * 0.038
                              )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  //*Widget que retorna la alerta de una camara de detección informando sus datos en particular.
  // *@params eventData: Recibe todo el objeto de propiedades particular.
  Widget _camaraDetectionAlert(foto_deteccion.Feature eventData){
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: ScreenSize.screenWidth * 0.75,
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset:  Offset(-ScreenSize.screenWidth * 0.025, -ScreenSize.screenWidth * 0.01),
                          child: Transform.rotate(
                            angle: pi/4,
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 50),
                              height: ScreenSize.screenWidth * 0.0550,
                              width: ScreenSize.screenWidth * 0.0550,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 20.0, left: 20.0),
                          child: Text(
                            'Foto Detección',
                            style: textStyles.whiteText(
                              context: context,
                              fontSize: ScreenSize.screenWidth * 0.065,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        'Dirección: ${eventData.properties!.direccion}',
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.045,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        'Tipo Vía: ${eventData.properties!.tipoTramo}',
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.045,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        "Departamento: ${eventData.properties!.departamento}",
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        "Municipio: ${eventData.properties!.municipio}",
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        "Tipo de tecnología: ${eventData.properties!.tipoTecnologia}" ,
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text('${eventData.properties!.observaciones}',
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    )
                  ],
                ),
              ),

              


              Container(
                margin: const EdgeInsets.only(top: 35.0),
                child: SvgPicture.asset(
                  'assets/icons/icono-deteccion.svg',
                  alignment: Alignment.center,
                  width: ScreenSize.screenWidth * 0.20,
                  height: ScreenSize.screenWidth * 0.20,
                ),
                
                
                // Icon(
                //   SinittIcons.icono_capa_fotodeteccion,
                //   color: Colors.white,
                //   size: ScreenSize.screenWidth * 0.15,
                // ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _signalAlert(signals.Feature eventData){
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: ScreenSize.screenWidth * 0.75,
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset:  Offset(-ScreenSize.screenWidth * 0.025, -ScreenSize.screenWidth * 0.01),
                          child: Transform.rotate(
                            angle: pi/4,
                            child: Container(
                              // margin: EdgeInsets.only(bottom: 50),
                              height: ScreenSize.screenWidth * 0.0550,
                              width: ScreenSize.screenWidth * 0.0550,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 20.0, right: 20.0),
                          child: Text(
                            'Señal N° ${eventData.properties!.id}',
                            style: textStyles.whiteText(
                              context: context,
                              fontSize: ScreenSize.screenWidth * 0.065,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        'Código Camara: ${eventData.properties!.codCamara}',
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.045,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        "Entidad: ${eventData.properties!.entidad}",
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        "Código Municipio: ${eventData.properties!.codigoMunicipioDivipola}",
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                      child: Text(
                        "Código Departamento: ${eventData.properties!.codigoDeptoDivipola}",
                        style: textStyles.whiteText(
                          context: context,
                          fontSize: ScreenSize.screenWidth * 0.038
                        )
                      ),
                    )

                    
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                child: Icon(
                  SinittIcons.iconoCapaFotodeteccion,
                  color: Colors.white,
                  size: ScreenSize.screenWidth * 0.15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}