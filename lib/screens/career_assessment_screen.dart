import 'package:flutter/material.dart';
import '../services/career_logic.dart';
import 'result_screen.dart';

class CareerAssessmentScreen extends StatefulWidget {
  final String stream;
  final String streamReason;
  final Map<String, int> streamScores;
  final String userDream;
  final List<String> strengths;
  final List<String> weaknesses;

  const CareerAssessmentScreen({
    super.key,
    required this.stream,
    required this.streamReason,
    required this.streamScores,
    required this.userDream,
    required this.strengths,
    required this.weaknesses,
  });

  @override
  State<CareerAssessmentScreen> createState() => _CareerAssessmentScreenState();
}

class _CareerAssessmentScreenState extends State<CareerAssessmentScreen> {
  int _currentIndex = 0;
  final List<String> _answers = [];
  late List<Map<String, dynamic>> _questions;

  @override
  void initState() {
    super.initState();
    _questions = CareerLogic.getQuestions(widget.stream);
  }

  void _nextQuestion(String answer) {
    _answers.add(answer);
    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      final careerResult = CareerLogic.calculateCareer(widget.stream, _answers);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            stream: widget.stream,
            career: careerResult['career'],
            alternatives: List<String>.from(careerResult['alternatives']),
            matchPercentage: careerResult['match'],
            whyReason: careerResult['why'],
            scores: widget.streamScores,
            userDream: widget.userDream,
            strengths: widget.strengths,
            weaknesses: widget.weaknesses,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF5F7FA), Colors.white],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('${widget.stream} Path'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: const Color(0xFF1A237E),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Career Deep-Dive', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
                  Text('${(_currentIndex + 1)}/30', style: const TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: const Color(0xFF1A237E).withAlpha(20),
                  color: const Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                question['question'],
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E), height: 1.3),
              ),
              const Spacer(),
              ...List.generate(question['options'].length, (index) {
                final option = question['options'][index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1A237E),
                        elevation: 0,
                        side: BorderSide(color: const Color(0xFF1A237E).withAlpha(40), width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => _nextQuestion(option),
                      child: Text(option, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
