import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aimhigher_app/services/auth_service.dart';
import 'package:aimhigher_app/main.dart';
import 'package:aimhigher_app/screens/assessment_screen.dart';
import 'package:aimhigher_app/screens/roadmap_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Loading...';
  String _email = 'Loading...';
  List<Map<String, dynamic>> _savedRoadmaps = [];
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final roadmapsRaw = prefs.getStringList('saved_roadmaps') ?? [];
    
    setState(() {
      _name = prefs.getString('user_name') ?? 'User';
      _email = prefs.getString('user_email') ?? 'No email';
      _savedRoadmaps = roadmapsRaw.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
    });
  }

  void _handleLogout() async {
    await _authService.logout();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AimHigherApp.of(context);
    final isDark = appState.isDarkMode;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('My Account', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: _handleLogout,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color(0xFF1A237E),
                    child: Text(
                      _name.isNotEmpty ? _name[0].toUpperCase() : 'U',
                      style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(_name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                  Text(_email, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            _buildSectionHeader('Settings'),
            _buildOption(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () async {
                final result = await Navigator.pushNamed(context, '/edit_profile');
                if (result == true) _loadUserData();
              },
            ),
            _buildOption(
              icon: isDark ? Icons.dark_mode : Icons.light_mode,
              title: 'Dark Mode',
              trailing: Switch(
                value: isDark,
                onChanged: (value) => appState.toggleTheme(value),
                activeColor: const Color(0xFF3949AB),
              ),
            ),
            
            const SizedBox(height: 24),
            _buildSectionHeader('Progress'),
            _buildOption(
              icon: Icons.assessment_outlined,
              title: 'Retake Assessment',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AssessmentScreen()));
              },
            ),
            
            if (_savedRoadmaps.isNotEmpty) ...[
              const SizedBox(height: 12),
              ..._savedRoadmaps.take(3).map((roadmap) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoadmapScreen(
                          career: roadmap['career'],
                          stream: roadmap['stream'],
                          userDream: roadmap['userDream'],
                          strengths: List<String>.from(roadmap['strengths']),
                          weaknesses: List<String>.from(roadmap['weaknesses']),
                        ),
                      ),
                    );
                  },
                  leading: const Icon(Icons.map_rounded, color: Color(0xFF3949AB)),
                  title: Text(roadmap['career'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Saved: ${roadmap['date'].toString().split('T')[0]}'),
                  trailing: const Icon(Icons.chevron_right, size: 18),
                ),
              )),
            ],

            const SizedBox(height: 24),
            _buildSectionHeader('More'),
            _buildOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFF3949AB)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        trailing: trailing ?? const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      ),
    );
  }
}
