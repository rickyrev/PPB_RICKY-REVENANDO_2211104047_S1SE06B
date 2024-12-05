import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

const String googleApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  static final LatLng _kMapCenter = LatLng(19.018255973653343, 72.84793849278007);
  static final CameraPosition _kInitialPosition = CameraPosition(
    target: _kMapCenter,
    zoom: 11.0,
  );

  void _showPlacePicker() async {
    try {
      // Navigasi ke Place Picker dan menangkap hasilnya
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlacePicker(
            apiKey: googleApiKey,
            initialPosition: _kMapCenter,
            useCurrentLocation: true,
            onPlacePicked: (result) {
              Navigator.of(context).pop();
              _showLocationDialog(result.geometry!.location.lat, result.geometry!.location.lng);
            },
          ),
        ),
      );
    } catch (e) {
      // Menampilkan dialog error jika terjadi kesalahan
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Terjadi kesalahan: ${e.toString()}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void _showLocationDialog(double lat, double lng) {
    // Menampilkan dialog lokasi yang dipilih
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Lokasi Terpilih'),
        content: Text('Latitude: $lat\nLongitude: $lng'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Place Picker'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kInitialPosition,
            myLocationEnabled: true,
            onTap: (LatLng location) {
              _showLocationDialog(location.latitude, location.longitude);
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _showPlacePicker,
              child: Text("Pilih Lokasi"),
            ),
          ),
        ],
      ),
    );
  }
}
