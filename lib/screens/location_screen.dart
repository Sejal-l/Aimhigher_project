import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatefulWidget {
  final String? filterStream;
  const LocationScreen({super.key, this.filterStream});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  Position? _currentPosition;
  String _selectedCategory = "All";
  final List<String> _categories = ["All", "Science", "Commerce", "Arts", "Competitive Exam"];

  // Nagpur Coaching Hub Center
  final LatLng _nagpurHub = const LatLng(21.1458, 79.0882);

  // THE MASTER LIST - GUARANTEED MARKERS
  final List<Map<String, dynamic>> _allCenters = [
    {'name': 'Allen Career Institute', 'lat': 21.1610, 'lon': 79.0805, 'cat': 'Science', 'rating': 4.8, 'address': 'Sadar, Nagpur'},
    {'name': 'Aakash Institute', 'lat': 21.1542, 'lon': 79.0868, 'cat': 'Science', 'rating': 4.7, 'address': 'Kingsway, Nagpur'},
    {'name': 'ICAD Academy', 'lat': 21.1448, 'lon': 79.0620, 'cat': 'Science', 'rating': 4.9, 'address': 'Tilak Nagar, Nagpur'},
    {'name': 'Resonance Nagpur', 'lat': 21.1520, 'lon': 79.0740, 'cat': 'Science', 'rating': 4.6, 'address': 'Sita Nagar, Nagpur'},
    {'name': 'IIT-Home Coaching', 'lat': 21.1390, 'lon': 79.0710, 'cat': 'Science', 'rating': 5.0, 'address': 'Ambazari Road, Nagpur'},
    {'name': 'Professional Commerce Academy', 'lat': 21.1280, 'lon': 79.0650, 'cat': 'Commerce', 'rating': 4.5, 'address': 'Laxmi Nagar, Nagpur'},
    {'name': 'Caps Learning Center', 'lat': 21.1380, 'lon': 79.0750, 'cat': 'Commerce', 'rating': 4.8, 'address': 'Ramdaspeth, Nagpur'},
    {'name': 'Career Launcher', 'lat': 21.1410, 'lon': 79.0640, 'cat': 'Competitive Exam', 'rating': 4.4, 'address': 'Dharampeth, Nagpur'},
    {'name': 'Mahendras Educational Pvt Ltd', 'lat': 21.1510, 'lon': 79.0850, 'cat': 'Competitive Exam', 'rating': 4.3, 'address': 'Dhantoli, Nagpur'},
    {'name': 'Success Arts Academy', 'lat': 21.1350, 'lon': 79.0800, 'cat': 'Arts', 'rating': 4.2, 'address': 'Dhantoli, Nagpur'},
    {'name': 'Fine Arts Institute', 'lat': 21.1450, 'lon': 79.0900, 'cat': 'Arts', 'rating': 4.6, 'address': 'Civil Lines, Nagpur'},
  ];

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.filterStream ?? "All";
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  void _jumpToCoachingHub() {
    _mapController.move(_nagpurHub, 14.5);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];

    // User Location Dot (Red Pulsing)
    if (_currentPosition != null) {
      markers.add(Marker(
        point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        width: 60, height: 60,
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) => Stack(alignment: Alignment.center, children: [
            Container(width: 15 + (20 * _pulseController.value), height: 15 + (20 * _pulseController.value), decoration: BoxDecoration(color: Colors.red.withOpacity(0.3), shape: BoxShape.circle)),
            Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)])),
          ]),
        ),
      ));
    }

    // Coaching Center Markers (Indigo Blue)
    for (var center in _allCenters) {
      bool shouldShow = _selectedCategory == "All" || center['cat'] == _selectedCategory;
      if (shouldShow) {
        markers.add(Marker(
          point: LatLng(center['lat'], center['lon']),
          width: 90, height: 90,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => _showCenterInfo(center),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF1A237E), width: 2), boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)]),
                  child: Text("${center['rating']} ★", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                ),
                const Icon(Icons.location_on, color: Color(0xFF1A237E), size: 48),
              ],
            ),
          ),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verified Experts', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        backgroundColor: Colors.white, elevation: 0, centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.center_focus_strong, color: Color(0xFF1A237E), size: 28),
            onPressed: _jumpToCoachingHub,
            tooltip: "Center to Coaching Hub",
          )
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _nagpurHub, 
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.aimhigher.app',
              ),
              MarkerLayer(markers: markers),
            ],
          ),
          Positioned(
            top: 10, left: 0, right: 0,
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  bool isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (val) => setState(() => _selectedCategory = cat),
                      selectedColor: const Color(0xFF1A237E),
                      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
                      backgroundColor: Colors.white,
                      elevation: 4,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            right: 16, bottom: 40,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: 'zIn',
                  onPressed: () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 1),
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.add, color: Color(0xFF1A237E)),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.small(
                  heroTag: 'zOut',
                  onPressed: () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 1),
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.remove, color: Color(0xFF1A237E)),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: 'myLoc',
                  onPressed: () {
                    if (_currentPosition != null) {
                      _mapController.move(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 15.0);
                    }
                  },
                  backgroundColor: const Color(0xFF1A237E),
                  child: const Icon(Icons.my_location, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCenterInfo(Map<String, dynamic> c) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(c['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 28),
                const SizedBox(width: 8),
                Text("${c['rating']} Stars • ${c['cat']} Expert", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            Text("Address: ${c['address']}", style: TextStyle(color: Colors.grey[700], fontSize: 16)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity, height: 60,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final String googleMapsUrl = "https://www.google.com/maps/dir/?api=1&destination=${c['lat']},${c['lon']}&travelmode=driving";
                  if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                    await launchUrl(Uri.parse(googleMapsUrl), mode: LaunchMode.externalApplication);
                  }
                },
                icon: const Icon(Icons.directions, color: Colors.white),
                label: const Text("Get Directions", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A237E), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
