import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/ui/widgets/rounded_button.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class AddressLocationPickerScreen extends StatefulWidget {
  const AddressLocationPickerScreen({Key key, this.onLocationPicker}) : super(key: key);

  final Function(RecipentLocationPicker pickerLocation) onLocationPicker;

  @override
  State<AddressLocationPickerScreen> createState() =>
      _AddressLocationPickerScreenState();
}

class _AddressLocationPickerScreenState
    extends State<AddressLocationPickerScreen> {
  GoogleMapController controller1;
  MapType _currentMapType = MapType.normal;
  bool _isGetCurrentLoading = false;
  String _address = "-";
  static LatLng _currentPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    _onMapCurrTap();
    super.initState();
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1 = controller;
    });
  }

  // _onMapTap(LatLng latLng) {
  //   setState(
  //     () {
  //       _currentPosition = latLng;
  //       _markers.clear();
  //       _markers.add(
  //         Marker(
  //             markerId: MarkerId(latLng.toString()),
  //             position: latLng,
  //             onTap: () {},
  //             icon: BitmapDescriptor.defaultMarker),
  //       );
  //     },
  //   );
  //   _getGeolocationAddress(
  //       Position(latitude: latLng.latitude, longitude: latLng.longitude));
  // }

  _onMapCurrTap() async {
    setState(() {
      _isGetCurrentLoading = true;
    });
    Position _updatedPosition = await _determinePosition();
    controller1?.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(_updatedPosition.latitude, _updatedPosition.longitude), 16));
    setState(
      () {
        _isGetCurrentLoading = false;
        _currentPosition =
            LatLng(_updatedPosition.latitude, _updatedPosition.longitude);
        _markers.clear();
        _markers.add(
          Marker(
              draggable: true,
              markerId: MarkerId(_currentPosition.toString()),
              position: _currentPosition,
              onTap: () {},
              icon: BitmapDescriptor.defaultMarker,
              onDragEnd: (LatLng position) {
                _getGeolocationAddress(Position(
                    latitude: position.latitude,
                    longitude: position.longitude));
              }),
        );
      },
    );
    _getGeolocationAddress(_updatedPosition);
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      margin: EdgeInsets.zero,
                      duration: Duration(seconds: 10),
                      content: Text('GPS belum diaktifkan'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _getGeolocationAddress(Position position) async {
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      final Placemark place = places.first;
      setState(() {
        _address = place.thoroughfare == null || place.thoroughfare.isEmpty
            ? place.locality 
            // place.street subAdministrativeArea locality subLocality administrativeArea postalCode
            : place.street + ", " + place.subLocality + ", " + place.locality + ", " + place.subAdministrativeArea + ", " + place.administrativeArea + ", " + place.postalCode ;
      });
      return;
    }
    setState(() {
      _address = "Alamat tidak tersedia";
    });
    return;
  }

  // void _handleSubmitLocation() async {
  //   ScaffoldMessenger.of(context)..hideCurrentSnackBar();
  //   AUExt.hideKeyboard(context);
  //   _userLocationActivationCubit.activationLocation(
  //       lat: "${_currentPosition.latitude}",
  //       long: "${_currentPosition.longitude}");
  // }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tentukan Lokasi"),
      ),
      body: _currentPosition == null
          ? Container(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'loading map..',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            )
          : Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        markers: _markers,
                        mapType: _currentMapType,
                        initialCameraPosition: CameraPosition(
                          target: _currentPosition,
                          zoom: 18,
                        ),
                        buildingsEnabled: false,
                        onMapCreated: _onMapCreated,
                        zoomGesturesEnabled: true,
                        myLocationEnabled: true,
                        compassEnabled: true,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                        // onTap: _onMapTap,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(15).copyWith(bottom: 50),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FloatingActionButton(
                                // mini: true,
                                child: Icon(Boxicons.bx_world,color: Colors.white),
                                backgroundColor: AppColor.primary,
                                onPressed: _onMapTypeButtonPressed,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FloatingActionButton(
                                child: _isGetCurrentLoading
                                    ? Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            valueColor: AlwaysStoppedAnimation(
                                              Colors.white,
                                            )),
                                      )
                                    : Icon(Boxicons.bx_current_location,color: Colors.white),
                                backgroundColor: AppColor.primary,
                                onPressed:
                                    _isGetCurrentLoading ? null : _onMapCurrTap,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
              ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    // color: AUColor.background,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [    
                        SizedBox(
                          height: 8,
                        ),       
                        Row(
                          children: [
                            Expanded(
                              child: Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.red,
                                            size: 32,
                                          ),
                            ),
                                       
                            // SizedBox(width: 8,),
                            Expanded(
                              flex: 8,
                              child: Column(
                                children: [
                                  Text(
                                    "${_address}",
                                    style: AppTypo.body1Lato,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        RoundedButton.contained(label: "Pilih Lokasi Ini", isUpperCase: false,onPressed: (){
                          widget.onLocationPicker(RecipentLocationPicker(address: _address, latitude: _currentPosition.latitude.toString(), longitude: _currentPosition.longitude.toString()));
                          AppExt.popScreen(context);
                        })
                    
                      ],
                    ),
                  ),
                ),
            ],
          ),
    );
  }
}
