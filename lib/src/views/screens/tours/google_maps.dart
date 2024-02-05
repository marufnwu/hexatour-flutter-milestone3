// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';


// class GoogleMaps extends StatefulWidget {
//   @override
//   _GoogleMapsState createState() => _GoogleMapsState();
// }

// class _GoogleMapsState extends State<GoogleMaps> {
//   GoogleMapController? mapController; //contrller for Google map
//   PolylinePoints polylinePoints = PolylinePoints();

//   String googleAPiKey = "AIzaSyD9O4RVbjnc1RICkFuJwPsun9T35exBjhQ";

//   Set<Marker> markers = Set(); 
//   Map<PolylineId, Polyline> polylines = {}; 

//   LatLng startLocation = LatLng(27.6683619, 85.3101895);
//   LatLng endLocation = LatLng(27.6688312, 85.3077329);

//   @override
//   void initState() {
//     markers.add(Marker(
    
//       markerId: MarkerId(startLocation.toString()),
//       position: startLocation, //position of marker
//       infoWindow: InfoWindow(
//         //popup info
//         title: 'Starting Point ',
//         snippet: 'Start Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     markers.add(Marker(
    
//       markerId: MarkerId(endLocation.toString()),
//       position: endLocation, //position of marker
//       infoWindow: InfoWindow(
//         //popup info
//         title: 'Destination Point ',
//         snippet: 'Destination Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     getDirections(); 

//     super.initState();
//   }

//   getDirections() async {
//     List<LatLng> polylineCoordinates = [];

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(startLocation.latitude, startLocation.longitude),
//       PointLatLng(endLocation.latitude, endLocation.longitude),
//       travelMode: TravelMode.driving,
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     addPolyLine(polylineCoordinates);
//   }

//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.deepPurpleAccent,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: GoogleMap(
     
//         zoomGesturesEnabled: true, 
//         initialCameraPosition: CameraPosition(
        
//           target: startLocation, 
//           zoom: 16.0, 
//         ),
      
//         mapType: MapType.normal, //map type
//         onMapCreated: (controller) {
         
//           setState(() {
//             mapController = controller;
//           });
//         },
//       ),
//     );
//   }
// }
