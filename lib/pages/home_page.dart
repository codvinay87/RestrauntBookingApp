import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restraunt_booking_app_easemydeal/payment/phone_pe_payment_gateway.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  static final CameraPosition _kGooglePlex = const CameraPosition(target: LatLng(28.63042,77.217722),
  zoom: 14.4746

);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Completer<GoogleMapController> _controller = Completer();

List<Marker> markers=[];
List<String> restrauntList=[
  "Wok In The Clouds - Connaught Place (CP)",
  "Mughlai Junction" ,
  "The GT Road" ,
  "The Imperial Spice",
  "Tamra Restaurant",
  "Lazeez Affaire CP"
];
final Map<String,int> map={
  "Wok In The Clouds - Connaught Place (CP)":3000,
  "Mughlai Junction" : 4000,
  "The GT Road" : 5000,
  "The Imperial Spice":6000,
  "Tamra Restaurant":6000,
  "Lazeez Affaire CP":7000,
};

final List<Marker> list = const[
  Marker(
    markerId: MarkerId('1'),
    position: LatLng(28.634275,77.220257),
    infoWindow: InfoWindow(
      title: "Wok In The Clouds - Connaught Place (CP)"
    ),
    

  ),
  Marker(
    markerId: MarkerId('2'),
    position: LatLng(28.632768,77.221697),
    infoWindow: InfoWindow(
      title: "Mughlai Junction"
    ),


  ),
  Marker(
    markerId: MarkerId('3'),
    position: LatLng(28.63357,77.222912),
    infoWindow: InfoWindow(
      title: "The GT Road"
    ),


  ),
  Marker(
    markerId: MarkerId('4'),
    position: LatLng(28.634432,77.222595),
    infoWindow: InfoWindow(
      title: "The Imperial Spice"
    ),


  ),
  Marker(
    markerId: MarkerId('5'),
    position: LatLng(28.62095,77.218168),
    infoWindow: InfoWindow(
      title: "Tamra Restaurant"
    ),


  ),
  Marker(
    markerId: MarkerId('6'),
    position: LatLng(28.63527,77.220637),
    infoWindow: InfoWindow(
      title: "Lazeez Affaire CP"
    ),


  ),
  Marker(
    markerId: MarkerId('7'),
    position: LatLng(28.635701,77.220127),
    infoWindow: InfoWindow(
      title: "Minar Restaurant"
    ),


  ),
];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers.addAll(list);
  }

  


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width/1.1,
           
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: GoogleMap(
                initialCameraPosition: HomePage._kGooglePlex,
                 onMapCreated: (GoogleMapController controller ){
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(markers),
              
              ),
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width/1.1,
            child: ListView.builder(
              itemCount: restrauntList.length,
              itemBuilder: (BuildContext context, int index){
                return ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhonePeScreen(amount: map[restrauntList[index]]!
                    )
                    )
                    );
                  }
                    ,
                    
                    child: Text("${restrauntList[index]}--${map[restrauntList[index]]}"));
              })
            ,
            
          )
          
        ],),
      )
      
    );
  }
}
