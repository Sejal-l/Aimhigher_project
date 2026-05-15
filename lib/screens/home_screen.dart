import 'package:flutter/material.dart';
import 'package:aimhigher_app/services/auth_service.dart';
import 'package:aimhigher_app/services/discover_service.dart';
import 'stream_assessment_screen.dart';
import 'profile_screen.dart';
import 'location_screen.dart';
import 'saved_roadmaps_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeBody(),
    const DiscoverScreen(), 
    const LocationScreen(),
  ];

  void updateIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: updateIndex,
        selectedItemColor: const Color(0xFF1A237E),
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: 'Nearby'),
        ],
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String _userName = 'User';
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    try {
      final name = await _authService.getUserName();
      if (mounted) {
        setState(() => _userName = name);
      }
    } catch (e) {
      debugPrint("Error loading user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF1A237E),
            child: const Icon(Icons.rocket_launch, color: Colors.white, size: 20),
          ),
        ),
        title: const Text(
          'AimHigher',
          style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF1A237E),
                child: Text(
                  _userName.isNotEmpty ? _userName[0].toUpperCase() : 'U',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6366F1), Color(0xFF1E1B4B)],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back, $_userName 👋', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16)),
                    const SizedBox(height: 8),
                    const Text('Your Future Starts Here', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StreamAssessmentScreen())),
                      icon: const Icon(Icons.auto_awesome, size: 18),
                      label: const Text('Start Career Test', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF1E1B4B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Market Trends', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildTrendCard('Generative AI', 'Engineering', Icons.bolt, const Color(0xFFEEF2FF), const Color(0xFF4F46E5), 'HOT', 'LLMs are redefining software engineering.'),
                  _buildTrendCard('Robotic Surgery', 'Medical', Icons.biotech, const Color(0xFFFDF2F8), const Color(0xFFDB2777), 'NEW', 'AI-assisted precision in healthcare.'),
                  _buildTrendCard('Sustainable Fintech', 'Commerce', Icons.account_balance, const Color(0xFFF0FDF4), const Color(0xFF16A34A), 'GROWING', 'Green banking is the new frontier.'),
                  _buildTrendCard('Legal Tech', 'Law', Icons.gavel, const Color(0xFFFFF7ED), const Color(0xFFEA580C), null, 'Smart contracts and digital forensics.'),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Quick Tools', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: _buildToolCard(Icons.map_outlined, 'Roadmaps', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SavedRoadmapsScreen())))),
                  const SizedBox(width: 16),
                  Expanded(child: _buildToolCard(Icons.people_outline, 'Experts', () {
                     final homeState = context.findAncestorStateOfType<HomeScreenState>();
                     homeState?.updateIndex(2);
                  })),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendCard(String title, String category, IconData icon, Color bgColor, Color iconColor, String? tag, String description) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(24), border: Border.all(color: iconColor.withOpacity(0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: iconColor)),
              if (tag != null) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.red.shade400, borderRadius: BorderRadius.circular(12)), child: Text(tag, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white))),
            ],
          ),
          const SizedBox(height: 16),
          Icon(icon, color: iconColor, size: 32),
          const Spacer(),
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
          const SizedBox(height: 6),
          Text(description, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildToolCard(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
        child: Column(children: [Icon(icon, color: const Color(0xFF1A237E), size: 28), const SizedBox(height: 12), Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),
      ),
    );
  }
}

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _discoverService = DiscoverService();
  late Future<Map<String, dynamic>> _discoverData;

  @override
  void initState() {
    super.initState();
    _discoverData = _discoverService.getDiscoverData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Discover Careers', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF1A237E)),
            onPressed: () => setState(() => _discoverData = _discoverService.getDiscoverData()),
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _discoverData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF6366F1)));
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading data: ${snapshot.error}"));
          }

          final data = snapshot.data!;
          final streams = data['streams'] as List;
          final skills = data['skills'] as List;
          final scholarships = data['scholarships'] as List;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildDiscoverSection('Future Streams', streams.map((s) => _buildDiscoverCard(
                s['title'], 
                _getIconData(s['icon']), 
                _getColor(s['color']), 
                s['subtitle']
              )).toList()),
              const SizedBox(height: 30),
              _buildDiscoverSection('Top Skills 2024', skills.map((s) => _buildInsightItem(
                s['title'], 
                s['tag'], 
                _getIconData(s['icon'])
              )).toList()),
              const SizedBox(height: 30),
              _buildDiscoverSection('Scholarships', scholarships.map((s) => _buildScholarshipCard(
                s['name'], 
                s['amount'], 
                s['deadline']
              )).toList()),
            ],
          );
        },
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'smart_toy': return Icons.smart_toy_outlined;
      case 'account_balance': return Icons.account_balance_outlined;
      case 'palette': return Icons.palette_outlined;
      case 'trending_up': return Icons.trending_up;
      case 'psychology': return Icons.psychology;
      case 'cloud': return Icons.cloud_outlined;
      case 'bolt': return Icons.bolt;
      case 'security': return Icons.security;
      case 'link': return Icons.link;
      default: return Icons.star_outline;
    }
  }

  Color _getColor(String name) {
    switch (name) {
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'orange': return Colors.orange;
      case 'red': return Colors.red;
      default: return Colors.grey;
    }
  }

  Widget _buildDiscoverSection(String title, List<Widget> children) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))), const SizedBox(height: 16), ...children]);
  }

  Widget _buildDiscoverCard(String title, IconData icon, Color color, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color)),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 13))])),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String tag, IconData icon) {
    return ListTile(contentPadding: EdgeInsets.zero, leading: Icon(icon, color: const Color(0xFF6366F1)), title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)), subtitle: Text(tag, style: const TextStyle(fontSize: 12)), trailing: const Icon(Icons.chevron_right));
  }

  Widget _buildScholarshipCard(String name, String amount, String deadline) {
    return Card(margin: const EdgeInsets.only(bottom: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: ListTile(title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(deadline), trailing: Text(amount, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))));
  }
}
