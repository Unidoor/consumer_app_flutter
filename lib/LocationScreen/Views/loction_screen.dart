import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../OnBoardingScreen/Views/intro_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  // Future<SharedPreferences> currentLocationStorage =
  //     SharedPreferences.getInstance();
  // final currentLocationStorage = GetStorage();
  // GetStorage currentLocationStorage = GetStorage('cLocation');
  Future<BitmapDescriptor> _getAssetIcon(BuildContext context) async {
    final bitmapIcon = Completer<BitmapDescriptor>();
    final config = createLocalImageConfiguration(context, size: Size(30, 30));

    const AssetImage('assets/images/location_pointer.png')
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final bytes = await image.image.toByteData(format: ImageByteFormat.png);
      final bitmap = BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }

  var address;
  var first;

  String _selectedAddress;

  BitmapDescriptor pinLocationIcon;
  final Completer<GoogleMapController> _mapController = Completer();

  /// Indicator for the selected location
  final Set<Marker> _markers = <Marker>{}..add(
      Marker(
        draggable: true,
        position: LatLng(23.4241, 53.8478),
        markerId: MarkerId('selected-location'),
      ),
    );

  var addresses;

  // TODO:- Change initial position to where ever you like and currently is showing Cords of Mogral
  LatLng _initialPosition = LatLng(12.562244730306842, 74.95255538729042);

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
    moveToCurrentUserLocation();
  }

  void moveToCurrentUserLocation() async {
    var location = Location();
    location.getLocation().then((locationData) async {
      var target = LatLng(locationData.latitude, locationData.longitude);
      moveToLocation(target);

      print("current location = $target");
      // currentLocationStorage.write("currentLocation", target);
    });
  }

  Future<void> moveToLocation(LatLng latLng) async {
    await _mapController.future.then((controller) async {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 17.0,
          ),
        ),
      );
    });

    await setMarker(latLng);

    final useRestApiWithoutPackage = false;
    if (useRestApiWithoutPackage) {
      reverseGeocodeLatLngAPI(latLng);
    } else {
      reverseGeocodeLatLng(latLng);
    }
  }

  //  using GeoCoder Package
  void reverseGeocodeLatLng(LatLng latLng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentLocationLat', "${latLng.latitude}");
    prefs.setString('currentLocationLong', "${latLng.longitude}");
    address = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(latLng.latitude, latLng.longitude));
    first = address.first;
    _selectedAddress = first.addressLine;
    print('${first.addressLine}');
    setState(() {});
  }

  // using rest api
  void reverseGeocodeLatLngAPI(LatLng latLng) {
    const apiKey = 'AIzaSyBhk7J3tDqUyvFiLQ0VhZTSziqS1bz0pu8';
    http
        .get(Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?&language=en&latlng=${latLng.latitude},${latLng.longitude}&key=$apiKey'))
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);

        String road =
            responseJson['results'][0]['address_components'][0]['short_name'];
        String locality =
            responseJson['results'][0]['address_components'][1]['short_name'];

        var number = '';
        var street = '';
        var state = '';

        var city = '';
        var country = '';
        var zip = '';

        List components = responseJson['results'][0]['address_components'];
        for (var i = 0; i < components.length; i++) {
          final item = components[i];
          List types = item['types'];

          // ignore: prefer_contains
          if (types.indexOf('street_number') > -1) {
            number = item['long_name'];
          }
          // ignore: prefer_contains
          if (types.indexOf('route') > -1) {
            street = item['long_name'];
          }
          // ignore: prefer_contains
          if (types.indexOf('administrative_area_level_1') > -1) {
            state = item['short_name'];
          }
          // ignore: prefer_contains
          if (types.indexOf('administrative_area_level_2') > -1) {
            city = item['long_name'];
          }
          // ignore: prefer_contains
          if (types.indexOf('country') > -1) {
            country = item['long_name'];
          }
          // ignore: prefer_contains
          if (types.indexOf('administrative_area_level_4') > -1 ||
              // ignore: prefer_contains
              types.indexOf('postal_code') > -1) {
            zip = item['long_name'];
          }
        }

        setState(() {
          _selectedAddress =
              '$road, ${locality ?? ''}, $number $street, $city, $zip, $state, $country';
        });
      }
    });
  }

  Future<void> setMarker(LatLng latLng) async {
    var markerIcon = await _getAssetIcon(context);
    // markers.clear();
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          draggable: true,
          markerId: MarkerId('selected-location'),
          position: latLng,
          icon: markerIcon,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // (_currentPosition != null)
            true
                ? Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 200,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition,
                                // _initialcameraposition,
                                zoom: 17,
                                bearing: 30),
                            myLocationButtonEnabled: true,
                            scrollGesturesEnabled: true,
                            compassEnabled: true,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            rotateGesturesEnabled: true,
                            buildingsEnabled: true,
                            tiltGesturesEnabled: true,
                            mapToolbarEnabled: true,
                            myLocationEnabled: true,
                            mapType: MapType.normal,
                            onMapCreated: onMapCreated,
                            markers: _markers,
                            onTap: (latLng) {
                              moveToLocation(latLng);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            // if (_currentPosition != null)
            //   Text(
            //       "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            // TextButton(
            //   child: Text("Get location"),
            //   onPressed: () {
            //     getLocation();
            //   },
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0, top: 15.0, bottom: 10.0),
                  child: Text(
                    "Select your location",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "your current location".toUpperCase(),
                        style: TextStyle(fontSize: 12.0),
                      ),
                      _selectedAddress != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    " $_selectedAddress",
                                    softWrap: false,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Get.to(SecondScreen());
                                  },
                                  child: Text(
                                    "CHANGE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                ),
                Divider(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                        ),
                        onPressed: () {
                          Get.to(IntroScreen());
                        },
                        child: Text(
                          "Confirm location",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
