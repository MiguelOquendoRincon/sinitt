

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sinitt/controller/request_permission_controller.dart';
import 'package:sinitt/utils/text_style.dart';

class RequestPermissionPage extends StatefulWidget {
  const RequestPermissionPage({ Key? key }) : super(key: key);

  @override
  _RequestPermissionPageState createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage> {

  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  // StreamSubscription _subscription = ;
  final textStyle = TextStyles();
  @override
  void initState() {
    super.initState();
    _controller.onStatusChanged.listen((status) {
      if(status == PermissionStatus.granted){
        Navigator.pushReplacementNamed(context, '/home');
      }  
    });
  }

  @override
  void dispose() {
    // _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).primaryColor,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.45),
                margin: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0, bottom: 30.0),
                // width: ScreenSize.screenWidth * 0.9,
                // height: ScreenSize.screenHeight * 0.7,
                alignment: Alignment.center,
                child: Text(
                  'La aplicación SINITT requiere acceso a la ubicación para funcionar correctamente.',
                  style: textStyle.whiteText(context: context, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                // margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.10),
                width: 200.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  child: Text("Permitir", style: textStyle.blackText(),),
                  onPressed: (){
                    _controller.request();
                  },
                ),
              ),
            ],
          ),
        ),
        // Stack(
        //   children: [
        //     // Container(
        //     //   height: double.infinity,
        //     //   child: Image.asset(
        //     //     'assets/FondoCarga.JPG',
        //     //     height: double.infinity,
        //     //   )
        //     // ),
        //     Container(
        //       color: Theme.of(context).primaryColor,
        //       height: double.infinity,
        //       width: double.infinity,
        //       alignment: Alignment.center,
        //       child: Column(
        //         children: [
        //           Container(
        //              width: ScreenSize.screenWidth * 0.9,
        //              height: ScreenSize.screenHeight * 0.7,
        //              alignment: Alignment.center,
        //             child: Text(
        //               'La aplicación SINITT requiere acceso a la ubicación para funcionar correctamente.',
        //               style: textStyle.whiteText(),
        //               textAlign: TextAlign.center,
        //             ),
        //           ),
        //           Container(
        //             margin: EdgeInsets.only(top: ScreenSize.screenHeight * 0.10),
        //             width: 200.0,
        //             child: ElevatedButton(
        //               style: ButtonStyle(
        //                 backgroundColor: MaterialStateProperty.all(Colors.white)
        //               ),
        //               child: Text("Permitir", style: textStyle.blackText(),),
        //               onPressed: (){
        //                 _controller.request();
        //               },
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // )
      ),
    );
  }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<StreamSubscription>('_subscription', _subscription));
  // }
}