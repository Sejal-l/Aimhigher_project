import 'package:flutter/material.dart';
import 'location_screen.dart';

class TrendDetailScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String category;

  const TrendDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1A237E).withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Icon(icon, size: 80, color: const Color(0xFF3949AB)),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600, height: 1.5),
            ),
            const SizedBox(height: 40),
            const Text(
              'Why it\'s Trending',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
              ),
              child: const Text(
                'This field is seeing significant growth globally. Industry leaders are looking for skilled professionals who can adapt to new technologies and drive innovation in this sector.',
                style: TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF2D3142)),
              ),
            ),
            const SizedBox(height: 32),
            _buildInsightTile(Icons.trending_up, 'Market Growth', 'Highly positive outlook for 2024-25'),
            _buildInsightTile(Icons.school_outlined, 'Skill Requirement', 'Focus on practical application'),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationScreen(filterStream: category),
                    ),
                  );
                },
                icon: const Icon(Icons.location_on, color: Colors.white),
                label: Text('FIND $category COACHING', 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightTile(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFF3949AB).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: const Color(0xFF3949AB), size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A237E))),
              Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}
