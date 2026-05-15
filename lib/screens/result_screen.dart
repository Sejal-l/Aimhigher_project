import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'roadmap_screen.dart';

class ResultScreen extends StatefulWidget {
  final String stream;
  final String career;
  final List<String> alternatives;
  final int matchPercentage;
  final String whyReason;
  final Map<String, int> scores;
  final String userDream;
  final List<String> strengths;
  final List<String> weaknesses;

  const ResultScreen({
    super.key,
    required this.stream,
    required this.career,
    required this.alternatives,
    required this.matchPercentage,
    required this.whyReason,
    required this.scores,
    required this.userDream,
    required this.strengths,
    required this.weaknesses,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    _saveResult();
  }

  Future<void> _saveResult() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recommended_stream', widget.career);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF8FAFF), Colors.white],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1A237E), size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Analysis Result', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1A237E), fontSize: 18)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Score Section
              Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1A237E).withOpacity(0.05),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: CircularProgressIndicator(
                          value: widget.matchPercentage / 100,
                          strokeWidth: 10,
                          backgroundColor: const Color(0xFFF0F2F8),
                          color: const Color(0xFF1A237E),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${widget.matchPercentage}%',
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF1A237E), letterSpacing: -1),
                          ),
                          Text(
                            'Match',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Recommendation Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EAF6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.auto_awesome_rounded, color: Color(0xFF1A237E), size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Text('Top Recommendation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1A237E))),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.career,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF1A237E), letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Part of the ${widget.stream} path',
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500),
                    ),
                    const Divider(height: 40),
                    Text(
                      widget.whyReason,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.6, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              const Text('Profile Insights', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1A237E), letterSpacing: -0.5)),
              const SizedBox(height: 16),
              
              // Strengths & Weaknesses
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.bolt, color: Colors.green, size: 24),
                          const SizedBox(height: 12),
                          const Text('Strengths', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.green)),
                          const SizedBox(height: 8),
                          ...widget.strengths.take(2).map((s) => Text('• $s', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.auto_fix_high_rounded, color: Colors.orange, size: 24),
                          const SizedBox(height: 12),
                          const Text('Focus Area', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.orange)),
                          const SizedBox(height: 8),
                          ...widget.weaknesses.take(2).map((w) => Text('• $w', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              const Text('Industry Breakdown', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1A237E), letterSpacing: -0.5)),
              const SizedBox(height: 16),
              
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _buildScoreBar('Science', widget.scores['science']! / 100, Colors.blue),
                    const SizedBox(height: 16),
                    _buildScoreBar('Commerce', widget.scores['commerce']! / 100, Colors.green),
                    const SizedBox(height: 16),
                    _buildScoreBar('Arts', widget.scores['arts']! / 100, Colors.orange),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoadmapScreen(
                          career: widget.career,
                          stream: widget.stream,
                          userDream: widget.userDream,
                          strengths: widget.strengths,
                          weaknesses: widget.weaknesses,
                        ),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('View Detailed Roadmap', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      SizedBox(width: 8),
                      Icon(Icons.map_outlined, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreBar(String label, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF2D3142))),
            Text('${(progress * 100).toInt()}%', style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: color.withOpacity(0.05),
            color: color,
          ),
        ),
      ],
    );
  }
}
