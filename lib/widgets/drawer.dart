import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:sinitt/api/api_departament.dart';
import 'package:sinitt/models/departamento_model.dart';
import 'package:sinitt/user_preferences/user_preferences.dart';
import 'package:sinitt/utils/hexcolor.dart';
import 'package:sinitt/utils/screen_size.dart';
import 'package:sinitt/utils/text_style.dart';
import 'package:geolocator/geolocator.dart';

import 'package:image_picker/image_picker.dart';

import '../api/api_situation_list.dart';
import '../models/situation_list.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({ Key? key }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with TickerProviderStateMixin{
  XFile? imageFile;
  final hourFormatter = DateFormat('hh:mm a');
  final formatter = DateFormat('dd-MM-yyyy');
  DateTime date = DateTime.now();
  TextStyles textStyles = TextStyles();
  // ================================================
  String? departamentoValue = 'ANTIOQUIA';
  List<String> nombreDept = [];
  List<Departamento> departamentos = [];
  bool isFirtsTime = true;
  // ================================================

  // ================================================
  String idDeptoSelected = "";
  String lastIdDeptoSelected = "";
  String? ciudadValue = 'Ciudad/Municipio';
  List<String> nombreCiud = [];
  List<Municipio> ciudades = [];
  bool isFirtsTimeCiudad = true;
  // ================================================
  String ciudID = "";
  String? viaValue = "";
  String? viaID = "";
  List<String> nombreVia = [];
  List<Via> vias = [];
  bool isFirtsTimeVia = true;
  String capaSelected = "Selecciona una capa";
  UserPreferences prefs = UserPreferences();
  // ================================================
  String? claseIncidente = 'Escoger';
  String? idClaseIncidente = "";
  String? prevIdClaseIncidente = "";
  String? tipoIncidente = 'Escoger';
  DateTime currentDate = DateTime.now();
  AnimationController? _animationController;
  // ================================================


  // ================================================
  String? nombreIncidente = "Situación";  
  List<SituationList>? incidentes = [];
  String? incidenteID = "";
  String? nombreSubIncidente = "Incidente";
  List<SubSituationList>? subIncidentes = [];
  // ================================================
  String latitude = "";
  String longitude = "";
  bool isDropOpen = false;


  // B2CConfiguration? _configuration;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animationController!.forward();
    super.initState();
    // AzureB2C.registerCallback(B2COperationSource.INIT, (result) async {
    //   if (result.reason == B2COperationState.SUCCESS) {
    //     _configuration = await AzureB2C.getConfiguration();
    //   }
    // });
    // AzureB2C.handleRedirectFuture().then((_) => AzureB2C.init("auth_config"));
  }

  // ?===================== SEGMENTO PARA B2C TOKEN =========================
  // *=======================================================================
  // static final Config config = Config(
  //   tenant: "mintransporteb2c",
  //   clientId: "fe032013-e8df-4fc7-a5fe-c40555cd8663",
  //   scope: "[user.read, openid, offline_access]",
  //   redirectUri: "https://login.live.com/oauth20_desktop.srf", //Para cuando se cierra el popup
  //   isB2C: true,
  //   policy: "B2C_1_signupandsign"
  // );
  // final AadOAuth oauth = AadOAuth(config);

  

  // *=======================================================================
  // ?===================== SEGMENTO PARA B2C TOKEN =========================
  
  @override
  Widget build(BuildContext context) {
    // debugPrint(oauth);
    return SizedBox(
      // elevation: 0.0,
      width: ScreenSize.screenWidth * 0.8,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            height: ScreenSize.screenHeight * 0.25,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30)
              ),
            ),
            child: Column(
              crossAxisAlignment : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Text(
                    'Bogotá',
                    style: textStyles.whiteText(
                      fontSize: ScreenSize.screenWidth * 0.040
                    ),
                  ),
                ),
                Container(
                  width: ScreenSize.screenWidth * 0.60,
                  margin: const EdgeInsets.only(bottom: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: ScreenSize.screenWidth * 0.050, 
                        color: Colors.white
                      ),
                      Text(
                        hourFormatter.format(date).toLowerCase(),
                        style: textStyles.whiteText(
                          fontSize: ScreenSize.screenWidth * 0.040
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        size: ScreenSize.screenWidth * 0.01750, 
                        color: Colors.white
                      ),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: ScreenSize.screenWidth * 0.050, 
                        color: Colors.white
                      ),
                      Text(
                        formatter.format(date),
                        style: textStyles.whiteText(
                          fontSize: ScreenSize.screenWidth * 0.040
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/icono-user.svg',
                        alignment: Alignment.center,
                        width: ScreenSize.screenWidth * 0.13,
                        height: ScreenSize.screenWidth * 0.13,
                      ),
                      
                      // Icon(
                      //   SinittIcons.icono_user,
                      //   size: ScreenSize.screenWidth * 0.110,
                      //   color: Colors.white,
                      // )
                    ),
                    Text(
                      'Usuario General',
                      style: textStyles.whiteText(
                        context: context,
                        fontSize: ScreenSize.screenWidth * 0.055
                      ),
                    )
                  ],
                )
              ],
            )
          ),
          Container (
            height: ScreenSize.screenHeight * 0.71,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            color: Colors.white,
            child:  Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor
                  ),
                  title: Text(
                    'Filtrar por capas',
                    style: textStyles.blueText(
                      context: context,
                      fontSize: ScreenSize.screenWidth * 0.0350
                    ),
                  ),
                  onTap: () => _showSearchFilter(),
                ),

                ListTile(
                  leading: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor
                  ),
                  title: Text(
                    'Reporte de incidentes',
                    style: textStyles.blueText(
                      context: context,
                      fontSize: ScreenSize.screenWidth * 0.0350
                    ),
                  ),
                  onTap: () => _newIncidente(),
                ),

                Divider(color: Theme.of(context).primaryColor,),

                ListTile(
                  leading: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor
                  ),
                  title: Text(
                    'Registrarme',
                    style: textStyles.blueText(
                      context: context,
                      fontSize: ScreenSize.screenWidth * 0.0350
                    ),
                  ),
                  onTap: () async => await _launchB2CAuth(),
                ),

                Divider(color: Theme.of(context).primaryColor,),
              ]
            ),
          )
        ],
      ),
    );
  }

  _launchB2CAuth() async{

    /*   
    tenant: "mintransporteb2c",
    clientId: "fe032013-e8df-4fc7-a5fe-c40555cd8663",
    scope: "openid, profile, email, offline_access, api",
    redirectUri: "http://localhost:3000",
    clientSecret: "",
    isB2C: true,
    policy: "B2C_1_signupandsign",
    tokenIdentifier: "Token" */
    // FlutterAppAuth _appauth = FlutterAppAuth();
    // AuthorizationTokenResponse? result;
    try{
      // FlutterAppAuth appAuth = FlutterAppAuth();
      // var queryParameters = {
      //   // "p": "B2C_1_signupandsign",
      //   "cliend_id": "fe032013-e8df-4fc7-a5fe-c40555cd8663",
      //   "nonce": "defaultNonce",
      //   "redirect_uri": "Navigator.pop()",
      //   "scope": "openid, offline_access",
      //   "response_type": "code",
      //   "prompt": "login"
      // };

      FlutterAppAuth _appauth = FlutterAppAuth();
      // result = (await _appauth.authorizeAndExchangeCode(
      //   AuthorizationTokenRequest(
      //     "fe032013-e8df-4fc7-a5fe-c40555cd8663", 
      //     "com.example.sinitt://oauthredirect",
      //     // discoveryUrl: "https://mintransporteb2c.b2clogin.com/<Tenant_ID>/v2.0/.well-known/openid-configuration?p=B2C_1_signupandsign",
      //     discoveryUrl: "https://mintransporteb2c.b2clogin.com/mintransporteb2c.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_signupandsign",
      //     scopes: ['fe032013-e8df-4fc7-a5fe-c40555cd8663','openid','profile', 'email', 'offline_access', 'api'],
      //     allowInsecureConnections: true,
      //     preferEphemeralSession: true
      //   ),
      // ))!;

      // final TokenResponse? result = await _appauth.token(
      //   TokenRequest(
      //     'fe032013-e8df-4fc7-a5fe-c40555cd8663', 
      //     'com.example.sinitt://oauthredirect',
      //     discoveryUrl: 'https://mintransporteb2c.b2clogin.com/mintransporteb2c.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_signupandsign',
      //     scopes: ['fe032013-e8df-4fc7-a5fe-c40555cd8663','profile', 'email', 'offline_access', 'api']
      //   )
      // );

      final AuthorizationTokenResponse? result = await _appauth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          'fe032013-e8df-4fc7-a5fe-c40555cd8663', 
          'com.example.sinitt://oauthredirect',
          discoveryUrl: 'https://mintransporteb2c.b2clogin.com/mintransporteb2c.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_signupandsign',
          scopes: ['fe032013-e8df-4fc7-a5fe-c40555cd8663','profile', 'email', 'offline_access', 'api']
        ),
      );


      // var queryParameters = {
      //   'p': "B2C_1_signupandsign",
      //   'client_id': "fe032013-e8df-4fc7-a5fe-c40555cd8663",
      //   'nonce': 'defaultNonce',
      //   'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob',
      //   'scope': "offline_access openid",
      //   'response_type': "code",
      //   'prompt': "login",
      // };
      // var uri = Uri.https(
      //     'mintransporteb2c.b2clogin.com',
      //     '/mintransporteb2c.onmicrosoft.com/oauth2/v2.0/authorize', queryParameters);
      // var response = await http.get(uri);
      debugPrint(result.toString());
    }catch(e){
      debugPrint(e.toString());
      _showB2CAlert();
    }
  }

  _showB2CAlert(){
    return showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text("Inicio de sesión invalido"),
          content: const Text("No completaste el proceso de inicio de sesión. Si no lo haces no podrás registrar incidentes"),
          actions: [
            MaterialButton(
              child: const Text("Cerrar", style: TextStyle(color: Colors.white),),
              color: Theme.of(context).errorColor,
              onPressed: () => Navigator.pop(context)
            ),

            MaterialButton(
              child: const Text("Intentar de nuevo", style: TextStyle(color: Colors.white),),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                Navigator.pop(context);
                await _launchB2CAuth();
              } 
            )
          ],
        );
      }
    );
  }

  _showSearchFilter(){
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30)
        ),
      ),
      context: context, 
      builder: (_){
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: ScreenSize.screenWidth * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.search,
                          color: Theme.of(context).cardColor,
                          size: ScreenSize.screenWidth * 0.0850,
                        ),
                        Text(
                          'Filtro de capas',
                          style: textStyles.blackText(
                            fontSize: ScreenSize.screenWidth * 0.0500,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context), 
                          icon: Icon(
                          Icons.close,
                            color: HexColor('#1C4780'),
                            size: ScreenSize.screenWidth * 0.0700,
                          ),
                        )
                      ],
                    ),
                  ),

                  _containerDropDown(
                    FutureBuilder(
                      future: singletonGetDepartaments.getDepartaments(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.hasData){
                          nombreDept = [];
                          departamentos = snapshot.data;
                          nombreDept.add("DEPARTAMENTO");
                          for (var departamento in departamentos) {
                            nombreDept.add(departamento.name!);
                          }
                          if(isFirtsTime) departamentoValue = nombreDept[0];
                          return DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            focusColor: Colors.blue,
                            dropdownColor: Colors.white,
                            icon: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Theme.of(context).cardColor,
                              )
                            ),
                            iconSize: 24,
                            elevation: 16,
                            hint: Text(
                              '$departamentoValue', 
                              overflow: TextOverflow.ellipsis,
                              style: departamentoValue == nombreDept[0] ? textStyles.greyText() :textStyles.blackText(),
                            ),
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                departamentoValue = newValue!;
                                isFirtsTime = false;
                                var deptoSelected = departamentos.firstWhere((element) => element.name == newValue);
                                idDeptoSelected = deptoSelected.cd!;
                                ciudadValue = "";
                                ciudID = "";
                                isFirtsTimeCiudad = true;
                                lastIdDeptoSelected = idDeptoSelected;
                              });
                            },
                            items: nombreDept
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                onTap: (){
                                  debugPrint('HOLAAAA');
                                },
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );

                        }else{
                          return const CircularProgressIndicator.adaptive();
                        }
                        
                      }
                    ),
                  ),

                  _containerDropDown(
                    idDeptoSelected != "" && idDeptoSelected == lastIdDeptoSelected
                    ?
                      FutureBuilder(
                        future: singletonGetDepartaments.getMunicipios(idDeptoSelected),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData){
                            nombreCiud = [];
                            ciudades = snapshot.data;
                            nombreCiud.add("CIUDAD/MUNICIPIO");
                            for (var ciudad in ciudades) {
                              nombreCiud.add(ciudad.name!);
                            }
                            if(!nombreCiud.contains(ciudadValue)) ciudadValue = nombreCiud[0];
                            if(isFirtsTimeCiudad) ciudadValue = nombreCiud[0];
                            return DropdownButton<String>(
                              isDense: true,
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              icon: RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Theme.of(context).cardColor,
                                )
                              ),
                              iconSize: 24,
                              elevation: 16,
                              hint: Text(
                                '$ciudadValue', 
                                overflow: TextOverflow.ellipsis,
                                style: ciudadValue == nombreCiud[0] ? textStyles.greyText() :textStyles.blackText(),
                              ),
                              underline: Container(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  ciudadValue = newValue!;
                                  var ciudSelected = ciudades.firstWhere((element) => element.name == newValue);
                                  ciudID = ciudSelected.cd!;
                                  isFirtsTimeCiudad = false;
                                });
                              },
                              items: nombreCiud
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            );

                          } else{
                            return const CircularProgressIndicator.adaptive();
                          }
                          
                        }
                      )
                    :
                    DropdownButton<String>(
                      onChanged: (String? newValue) {},
                      isDense: true,
                      isExpanded: true,
                      hint: Text(
                        'Selecciona un departamento', 
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.greyText(),
                      ),
                      dropdownColor: Colors.white,
                      icon: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).cardColor,
                        )
                      ),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(),
                      items: <String>['Selecciona un departamento']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )

                  ),

                  _containerDropDown(
                    ciudID != "" 
                    ?
                    FutureBuilder(
                      future: singletonGetDepartaments.getVia(ciudID),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.hasData){
                          nombreVia = [];
                          vias = snapshot.data;
                          nombreVia.add("Vía");
                          for (var via in vias) {
                            if(!nombreVia.contains(via.name))  nombreVia.add(via.name!);
                          }
                          if(!nombreVia.contains(viaValue)) viaValue = nombreVia[0];
                          if(isFirtsTimeVia) viaValue = nombreVia[0];


                          return DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            icon: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Theme.of(context).cardColor,
                              )
                            ),
                            iconSize: 24,
                            elevation: 16,
                            hint: Text(
                              '$viaValue', 
                              overflow: TextOverflow.ellipsis,
                              style: viaValue == nombreVia[0] ? textStyles.greyText() :textStyles.blackText(),
                            ),
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                viaValue = newValue!;
                                var viaSelected = vias.firstWhere((element) => element.name == newValue);
                                viaID = viaSelected.cd ?? '';
                                isFirtsTimeVia = false;
                              });
                            },
                            items: nombreVia.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        } else{
                          return const CircularProgressIndicator.adaptive();
                        }
                      }
                    )
                    :
                    DropdownButton<String>(
                      isDense: true,
                      onChanged: (String? newValue) {},
                      isExpanded: true,
                      hint: Text(
                        'Selecciona un municipio', 
                        overflow: TextOverflow.ellipsis,
                        style: textStyles.greyText(),
                      ),
                      dropdownColor: Colors.white,
                      icon: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).cardColor,
                        )
                      ),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(),
                      items: <String>['Selecciona un municipio']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ),


                  _containerDropDown(

                    DropdownButton<String>(
                      isDense: true,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      icon: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Theme.of(context).cardColor,
                        )
                      ),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text(
                        capaSelected, 
                        overflow: TextOverflow.ellipsis,
                        style: capaSelected == "Selecciona una capa" ? textStyles.greyText() :textStyles.blackText(),
                      ),
                      
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          capaSelected = newValue!;
                          if(capaSelected == "Todos"){
                            prefs.userCapFilter = "";
                          }else{
                            prefs.userCapFilter = capaSelected;
                          }
                        });
                      },
                      items: <String>['Selecciona una capa', 'Situaciones', 'Peajes', 'Foto Deteccion', 'Señales', 'Todos']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ),

                    // * WIDGET USADO PARA LANZAR UN CALENDARIO
                  //   InkWell(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           currentDate == DateTime.now()
                  //           ?'Fecha' 
                  //           :DateFormat('dd/MMM/yyyy', 'es').format(currentDate),
                  //           style: textStyles.greyText(),
                  //         ),

                  //         Icon(
                  //           Icons.calendar_today,
                  //           color: Theme.of(context).cardColor,
                  //         )

                  //       ],
                  //     ),
                  //     onTap: () async{
                  //       await _calendarDemo().then((value){
                  //         if (value != null && value != currentDate) setState(() => currentDate = value);
                  //       });
                  //     }
                  //   )
                  // ),

                  Container(
                    width: ScreenSize.screenWidth * 0.85,
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: ScreenSize.screenWidth * 0.30,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          )
                        ),
                        onPressed: (){
                          prefs.depID = idDeptoSelected.toString();
                          prefs.muniID = ciudID.toString();
                          prefs.viaID = viaID.toString();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/home');
                        }, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'BUSCAR',
                              style: textStyles.whiteText(),
                            ),

                            const Icon(
                              Icons.search,
                              color: Colors.white,
                            )
                          ]
                        )
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        );
      }
    );
  }

  _newIncidente(){
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30)
        ),
      ),
      context: context, 
      builder: (_){
        return StatefulBuilder(
          builder: (context, setState) {
            void _openGallery(BuildContext context) async {
              final ImagePicker _picker = ImagePicker();
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
              // var picture = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
              setState(() {
                imageFile = image;
              });
              Navigator.of(context).pop();
            }

            void _openCamera(BuildContext context) async {
              // ignore: invalid_use_of_visible_for_testing_member
              final ImagePicker _picker = ImagePicker();
              final XFile? image = await _picker.pickImage(source: ImageSource.camera);
              setState(() {
                imageFile = image;
              });
              Navigator.of(context).pop();
            }
            Future<void> _showSelectionDialog(BuildContext context) {
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text("¿De qué lugar deseas obtener la foto?", textAlign: TextAlign.center,),
                        content: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () => _openGallery(context),
                                child: const Text("Galería", style: TextStyle(color: Colors.white),),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue[200],
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(80))
                                  )
                                ),
                              ),
                              TextButton(
                                onPressed: () => _openCamera(context),
                                child: const Text("Cámara", style: TextStyle(color: Colors.white),),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(80))
                                  )
                                ),
                              ),
                            ],
                          )
                        ));
                  });
            }

            

            Widget _setImageView() {
              if (imageFile != null) {
                return Column(
                  children: [
                    Image.file(File(imageFile!.path), width: 500, height: 500),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.red, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Eliminar evidencia", style: TextStyle(color: Colors.red)),
                          onPressed: () => setState(() => imageFile = null)
                        ),

                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Cambiar evidencia", style: TextStyle(color: Colors.white)),
                          onPressed: () => _showSelectionDialog(context)
                        ),
                      ],
                    )
                  ],
                );
                // return Image.file(imageFile.file, width: 500, height: 500);
              } else {
                return DottedBorder(
                  color: Colors.blue,
                  child: Container(
                    height: 150.0,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                          size: ScreenSize.screenWidth * 0.0700,
                        ),
                        Text(
                          '''Agregar evidencia fotográfica 
          o vídeo''',
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: textStyles.blueText(
                          fontSize: ScreenSize.screenWidth * 0.03500
                        ),
                        ),
                      ],
                    )
                  ),
                );
              }
            }
            return SingleChildScrollView(
              //Usando el setstate saber si el teclado está habitlitado para extender la altura del contenedor padre
              child: Column(
                children: [
                  Container(
                    width: ScreenSize.screenWidth * 0.12,
                    margin: const EdgeInsets.only(top: 20.0),
                    height: 6.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: ScreenSize.screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reporte de incidentes',
                          style: textStyles.blueText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.0500,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context), 
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).primaryColor,
                            size: ScreenSize.screenWidth * 0.0700,
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    width: ScreenSize.screenWidth,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ubicación',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),

                        Container(
                          height: 90.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              // hintText: "La ubicación se toma de tu GPS. Recuerda tenerlo activo",
                              // counterText: "La ubicación se toma de tu GPS. Recuerda tenerlo activo",
                              hintText: latitude ==  "" ? "" : latitude + "," + longitude,
                              helperText: "La ubicación se toma de tu GPS. Recuerda tenerlo activo",
                              helperMaxLines: 2,
                              helperStyle: const TextStyle(color: Colors.black),
                              enabled: false,
                              contentPadding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                                size: ScreenSize.screenWidth * 0.0500,
                              )
                            ),
                          ),
                        ),

                        Text(
                          'Clase de incidente',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),

                        Container(
                          height: 40.0,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: HexColor('#BCBBBB')
                            )
                          ),
                          child: FutureBuilder(
                            future: singletonApiSituationsList.getSituationsList(),
                            builder: (context, AsyncSnapshot<List<SituationList>> snapshot) {
                              if(snapshot.hasData){
                                incidentes = snapshot.data;
                                List<String> incidentesName = ["Escoger"];
                                for (var element in incidentes!) {
                                  incidentesName.add(element.name!);
                                }
                                return DropdownButton<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  // value: claseIncidente,
                                  hint: Text(
                                    '$claseIncidente', 
                                    overflow: TextOverflow.ellipsis,
                                    style: claseIncidente == 'Escoger' ? textStyles.greyText(context: context, lightGrey: true) :textStyles.blackText(),
                                  ),
                                  dropdownColor: Colors.white,
                                  icon: RotatedBox(
                                    quarterTurns: 1,
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Theme.of(context).cardColor,
                                    )
                                  ),
                                  iconSize: ScreenSize.screenWidth * 0.0500,
                                  elevation: 16,
                                  underline: Container(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      claseIncidente = newValue!;
                                      idClaseIncidente = incidentes!.where((element) => element.name == newValue).first.id.toString();
                                      if(idClaseIncidente != prevIdClaseIncidente) prevIdClaseIncidente = idClaseIncidente;
                                    });
                                  },
                                  items: incidentesName.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SizedBox(
                                        width: ScreenSize.screenWidth * 0.72,
                                        child: Text(
                                          value, 
                                          maxLines: 3, 
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ),
                                    );
                                  }).toList(),
                                );
                              } else{
                                return const CircularProgressIndicator.adaptive();
                              }
                            }
                          )
                        ),


                        Text(
                          'Tipo de incidente',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),


                        // !===============================================================================
                        idClaseIncidente != ""  && idClaseIncidente == prevIdClaseIncidente
                          ? Container(
                              height: 40.0,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: HexColor('#BCBBBB')
                                )
                              ),
                              child: FutureBuilder(
                                future: singletonApiSituationsList.getSubSituationsList(idClaseIncidente!),
                                builder: (context, AsyncSnapshot<List<SubSituationList>> snapshot) {
                                  if(snapshot.hasData){
                                    subIncidentes = snapshot.data;
                                    List<String> subIncidentesName = ["Escoger"];
                                    for (var element in subIncidentes!) {
                                      subIncidentesName.add(element.name!);
                                    }
                                    return DropdownButton<String>(
                                      isDense: true,
                                      isExpanded: true,
                                      hint: Text(
                                        '$tipoIncidente', 
                                        overflow: TextOverflow.ellipsis,
                                        style: tipoIncidente == 'Escoger' ? textStyles.greyText(context: context, lightGrey: true) :textStyles.blackText(),
                                      ),
                                      dropdownColor: Colors.white,
                                      icon: RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Theme.of(context).cardColor,
                                        )
                                      ),
                                      iconSize: ScreenSize.screenWidth * 0.0500,
                                      elevation: 16,
                                      underline: Container(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          tipoIncidente = newValue!;
                                        });
                                      },
                                      items: subIncidentesName.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: SizedBox(width: ScreenSize.screenWidth * 0.72 ,child: Text(value, maxLines: 3, overflow: TextOverflow.ellipsis,))
                                        );
                                      }).toList(),
                                    );
                                  } else{
                                    return const CircularProgressIndicator.adaptive();
                                  }
                                }
                              )
                            )
                          : Container(
                              height: 40.0,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: HexColor('#BCBBBB')
                                )
                              ),
                              child: DropdownButton<String>(
                                isDense: true,
                                isExpanded: true,
                                hint: Text(
                                  'Selecciona una clase de incidente', 
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyles.greyText(context: context, lightGrey: true)
                                ),
                                dropdownColor: Colors.white,
                                icon: RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Theme.of(context).cardColor,
                                  )
                                ),
                                iconSize: ScreenSize.screenWidth * 0.0500,
                                elevation: 16,
                                underline: Container(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    tipoIncidente = newValue!;
                                  });
                                },
                                items: <String>['Escoger']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: SizedBox(width: ScreenSize.screenWidth * 0.72 ,child: Text(value, maxLines: 3, overflow: TextOverflow.ellipsis,))
                                  );
                                }).toList(),
                              ),
                            ),

                        Text(
                          'Descripción',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),

                        Container(
                          height: 150.0,
                          margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                          child: TextField(
                            minLines: null,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: 'Breve descripción del incidente',
                              hintStyle: textStyles.greyText(context: context, lightGrey: true),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: HexColor('#BCBBBB')
                                )
                                
                              ),
                            ),
                          ),
                        ),

                        Text(
                          'Evidencia',
                          style: textStyles.greyText(
                            context: context,
                            fontSize: ScreenSize.screenWidth * 0.03800
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                          child: Text(
                            'Tipo de archivo permitido .jpg y .mp4 de hasta xMB',
                            style: textStyles.greyText(
                              context: context,
                              fontSize: ScreenSize.screenWidth * 0.03500
                            ),
                          ),
                        ),

                        InkWell(
                          child: _setImageView(),
                          onTap: () {
                            _showSelectionDialog(context);
                          },
                        ),

                        Container(
                          width: ScreenSize.screenWidth * 0.85,
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(bottom: 20.0, top: 8.0),
                          child: SizedBox(
                            width: ScreenSize.screenWidth * 0.30,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                )
                              ),
                              onPressed: () async{
                                  // create this variable
                                  try{
                                    var position = await _determinePosition();
                                    latitude = position.latitude.toString();
                                    longitude = position.longitude.toString();
                                    _login();

                                  }catch(e){

                                    switch (e) {
                                      case 1:
                                        _alertEventRegister(
                                          title: 'El GPS no está activo. Por favor activalo para registrar exitosamente el incidente',
                                          buttonText: 'Activarlo ahora',
                                          onTap: () async{
                                            bool userHasGPSActive = await Location().requestService();
                                            if(userHasGPSActive) {
                                              Navigator.pop(context);
                                              Position  position = await Geolocator.getCurrentPosition();
                                              latitude = position.latitude.toString();
                                              longitude = position.longitude.toString();
                                            }
                                          } 
                                        );
                                        
                                        break;
                                      case 2:
                                        _alertEventRegister(
                                          title: 'Los permisos de ubicación fueron rechazados. Por favor activalos para registrar exitosamente el incidente',
                                          buttonText: 'Abrir Ajustes',
                                          onTap: () async{
                                            await Geolocator.openLocationSettings();
                                          } 
                                        );
                                        
                                        break;
                                      default:
                                        _alertEventRegister(
                                          title: 'Los permisos de ubicación fueron rechazados para siempre. No es posible registrar un incidente así',
                                          buttonText: 'Abrir Ajustes',
                                          onTap: () async{
                                            await Geolocator.openAppSettings();
                                          } 
                                        );

                                      
                                    }
                                  }
                                  

                              }, 
                              child: Text(
                                'Crear reporte',
                                style: textStyles.whiteText(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        );
      }
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services. 
      // return Future.error({
      //   'errorName': 'El GPS no está activo. Por favor activalo para registrar exitosamente el incidente',
      //   'buttonErrorName': "Activarlo automatimaticamente",
      //   'onTap': await Geolocator.requestPermission()
      // });
      return Future.error(1);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(2); 
        // return Future.error('Los permisos de ubicación fueron rechazados. Por favor activalos para registrar exitosamente el incidente');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(3);
      // return Future.error(
      //   'Los permisos de ubicación fueron rechazados para siempre. No es posible registrar un incidente así');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future _login() async {
    try {
      debugPrint("hola");
      // var hola = await oauth.login();
      // var accessToken = await oauth.getAccessToken();
      // debugPrint('Logged in successfully, your access token: $accessToken');
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Future _alertEventRegister({String title = "", String buttonText = "", void Function()? onTap  }){
    return showCupertinoDialog(
      context: context, 
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: CupertinoButton(
            color: HexColor('#3366CC'),
            child: Text(buttonText, style: textStyles.whiteText(),),
            onPressed: onTap
          ),
      )
    );
  }


  // *@params child: Recibe el widget, se usará para listar las opciones
  Widget _containerDropDown( Widget child){
    return Container(
      width: ScreenSize.screenWidth * 0.85,
      height: 60.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.5),
            offset: const Offset(1.5, 2.5),
            blurRadius: 8,
            spreadRadius: 2.5
          )
        ]
      ),
      child: child
    );
  }

}
