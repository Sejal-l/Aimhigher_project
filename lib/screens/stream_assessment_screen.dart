import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/assessment_logic.dart';
import 'career_assessment_screen.dart';

class StreamAssessmentScreen extends StatefulWidget {
  const StreamAssessmentScreen({super.key});

  @override
  State<StreamAssessmentScreen> createState() => _StreamAssessmentScreenState();
}

class _StreamAssessmentScreenState extends State<StreamAssessmentScreen> {
  int _currentIndex = 0; 
  final List<String> _answers = List.filled(50, "");
  final _questions = StreamAssessmentLogic.questions;
  
  final _dreamController = TextEditingController();
  final _satisfactionController = TextEditingController();

  void _onAnswerSelected(String answer) {
    _answers[_currentIndex] = answer;
    if (_currentIndex < 48) {
      setState(() => _currentIndex++);
    } else {
      setState(() => _currentIndex = 49);
    }
  }

  void _submitAssessment() async {
    if (_satisfactionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the final question!')),
      );
      return;
    }
    _answers[49] = _satisfactionController.text.trim();
    
    final result = StreamAssessmentLogic.calculateResult(_answers);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recommended_stream', result['stream']);

    _showResultDialog(result);
  }

  void _showResultDialog(Map<String, dynamic> result) {
    final scores = result['scores'];
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Column(
          children: [
            const Text('Analysis Complete!', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 8),
            Text('Confidence Score: ${result['confidence']}%', 
              style: TextStyle(fontSize: 14, color: result['confidence'] > 70 ? Colors.green : Colors.orange, fontWeight: FontWeight.w600)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Recommended Path:', style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E).withAlpha(20),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(result['stream'], 
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            ),
            const SizedBox(height: 8),
            Text('Alt: ${result['alt']}', style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
            const SizedBox(height: 24),
            _buildScoreRow('Science', scores['science'], Colors.blue),
            _buildScoreRow('Commerce', scores['commerce'], Colors.green),
            _buildScoreRow('Arts', scores['arts'], Colors.orange),
            const SizedBox(height: 20),
            Text(result['reason'], textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.4)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CareerAssessmentScreen(
                        stream: result['stream'],
                        streamReason: result['reason'],
                        streamScores: Map<String, int>.from(scores),
                        userDream: result['dream'],
                        strengths: List<String>.from(result['strengths']),
                        weaknesses: List<String>.from(result['weaknesses']),
                      ),
                    ),
                  );
                },
                child: const Text('Start Career Deep-Dive →', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreRow(String label, int percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 85, child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percent / 100,
                backgroundColor: color.withAlpha(30),
                color: color,
                minHeight: 10,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text('$percent%', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / 50;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFFF5F7FA)],
          stops: [0.0, 0.2, 0.35],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Career Analysis', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Overall Progress', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('${_currentIndex + 1}/50', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: Colors.white.withAlpha(30),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (question['type'] == 'writing')
                          _buildWritingQuestion(question)
                        else
                          _buildChoiceQuestion(question),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWritingQuestion(Map<String, dynamic> q) {
    final bool isFirst = q['id'] == 'q1';
    final controller = isFirst ? _dreamController : _satisfactionController;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(q['q'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        const SizedBox(height: 12),
        const Text('(Write honestly — even if you\'re not fully sure)', style: TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 30),
        TextField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: isFirst ? 'e.g. Astronaut, Entrepreneur, Surgeon...' : 'What makes you feel fulfilled?',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: true,
            fillColor: Colors.grey.withAlpha(10),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A237E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () {
              if (controller.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please share your thoughts!')));
                return;
              }
              if (isFirst) {
                _answers[0] = controller.text.trim();
                setState(() => _currentIndex++);
              } else {
                _submitAssessment();
              }
            },
            child: Text(isFirst ? 'Next Step →' : 'Analyze My Results', 
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceQuestion(Map<String, dynamic> q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(q['q'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E), height: 1.3)),
        const SizedBox(height: 40),
        ...List.generate((q['options'] as List).length, (index) {
          final option = q['options'][index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => _onAnswerSelected(option),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FE),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1A237E).withAlpha(15)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: const Color(0xFF1A237E),
                      child: Text(String.fromCharCode(65 + index), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(option, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2D3142))),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: Color(0xFF1A237E)),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
