import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'roadmap_screen.dart';

class SavedRoadmapsScreen extends StatefulWidget {
  const SavedRoadmapsScreen({super.key});

  @override
  State<SavedRoadmapsScreen> createState() => _SavedRoadmapsScreenState();
}

class _SavedRoadmapsScreenState extends State<SavedRoadmapsScreen> {
  List<Map<String, dynamic>> _savedRoadmaps = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRoadmaps();
  }

  Future<void> _loadRoadmaps() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> saved = prefs.getStringList('saved_roadmaps') ?? [];
    
    setState(() {
      _savedRoadmaps = saved.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('My Career Roadmaps', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A237E)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedRoadmaps.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _savedRoadmaps.length,
                  itemBuilder: (context, index) {
                    final roadmap = _savedRoadmaps[index];
                    return _buildRoadmapCard(roadmap);
                  },
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('No roadmaps found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('Complete an assessment to generate one!', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildRoadmapCard(Map<String, dynamic> data) {
    final DateTime date = DateTime.parse(data['date'] ?? DateTime.now().toIso8601String());
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF3949AB).withOpacity(0.1), shape: BoxShape.circle),
          child: const Icon(Icons.auto_awesome, color: Color(0xFF3949AB)),
        ),
        title: Text(data['career'] ?? 'Unknown Path', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text('Stream: ${data['stream']} • ${date.day}/${date.month}/${date.year}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoadmapScreen(
                career: data['career'],
                stream: data['stream'],
                userDream: data['userDream'] ?? '',
                strengths: List<String>.from(data['strengths'] ?? []),
                weaknesses: List<String>.from(data['weaknesses'] ?? []),
              ),
            ),
          );
        },
      ),
    );
  }
}
