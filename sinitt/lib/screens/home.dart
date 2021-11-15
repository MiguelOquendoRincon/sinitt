import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:sinitt/widgets/loading.dart';

class HomePage extends StatefulWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late MapboxMapController mapController;
  String accessToken = "sk.eyJ1IjoibWlndWVsb3F1ZW5kbzk5IiwiYSI6ImNrdzEwdjNpaTU1Z2Uyb28wMWlqdHo4ZDcifQ.YbaVgWYaQ2U3Z5kAU0b_rQ";

  void _onMapCreated(MapboxMapController controller){
    mapController = controller;
  }

  double? latitude;
  double? longitude;
  bool isLoadingLocation = true;
  // late var getPermission;

  @override
  void initState(){
    void getPermission() async{
      if(!kIsWeb){
        final location = Location();
        final hasPermissions = await location.hasPermission();
        if (hasPermissions != PermissionStatus.granted) {
          await location.requestPermission();
          isLoadingLocation = false;
        } else{
          print('hola');
          var hola = await location.getLocation();
          setState(() {
            latitude = hola.latitude!;
            longitude = hola.longitude!;
            isLoadingLocation = false;
          });
        }
      }
    }

    getPermission();
      

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola'),
      ),
      body: isLoadingLocation ? const Center(child: Loading()) :buildMap(),
      floatingActionButton: FloatingActionButton(
        child: Text('Hola'),
        onPressed: () async{
          print('hola');
          if(!kIsWeb){
            final location = Location();
            final hasPermissions = await location.hasPermission();
            if (hasPermissions != PermissionStatus.granted) {
              await location.requestPermission();
              
            } else{
              print('hola');
              var hola = await location.getLocation();
              setState(() {
                latitude = hola.latitude!;
                longitude = hola.longitude!;
              });
            }
          }
        },
      ),
    );
  }

  MapboxMap buildMap() {
    return MapboxMap(

      styleString: 'mapbox://styles/migueloquendo99/ckw12c03p9e2r14qdx42lf0kz',
      accessToken: accessToken,
      onMapCreated: _onMapCreated,

      initialCameraPosition: CameraPosition(
        // target: LatLng(5.9761156, -74.5994885),
        target: LatLng(latitude!, longitude!),
        zoom: 14
      )
    );
  }
}

// class MapsDemo extends StatelessWidget {
//   // FIXME: You need to pass in your access token via the command line argument
//   // --dart-define=ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE
//   // It is also possible to pass it in while running the app via an IDE by
//   // passing the same args there.
//   //
//   // Alternatively you can replace `String.fromEnvironment("ACCESS_TOKEN")`
//   // in the following line with your access token directly.
//   static const String ACCESS_TOKEN = String.fromEnvironment("ACCESS_TOKEN");

//   void _pushPage(BuildContext context, ExamplePage page) async {
//     if (!kIsWeb) {
//       final location = Location();
//       final hasPermissions = await location.hasPermission();
//       if (hasPermissions != PermissionStatus.granted) {
//         await location.requestPermission();
//       }
//     }
//     Navigator.of(context).push(MaterialPageRoute<void>(
//         builder: (_) => Scaffold(
//               appBar: AppBar(title: Text(page.title)),
//               body: page,
//             )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('MapboxMaps examples')),
//       body: ACCESS_TOKEN.isEmpty || ACCESS_TOKEN.contains("YOUR_TOKEN")
//           ? buildAccessTokenWarning()
//           : ListView.separated(
//               itemCount: _allPages.length,
//               separatorBuilder: (BuildContext context, int index) =>
//                   const Divider(height: 1),
//               itemBuilder: (_, int index) => ListTile(
//                 leading: _allPages[index].leading,
//                 title: Text(_allPages[index].title),
//                 onTap: () => _pushPage(context, _allPages[index]),
//               ),
//             ),
//     );
//   }

//   Widget buildAccessTokenWarning() {
//     return Container(
//       color: Colors.red[900],
//       child: SizedBox.expand(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             "Please pass in your access token with",
//             "--dart-define=ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE",
//             "passed into flutter run or add it to args in vscode's launch.json",
//           ]
//               .map((text) => Padding(
//                     padding: EdgeInsets.all(8),
//                     child: Text(text,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white)),
//                   ))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }