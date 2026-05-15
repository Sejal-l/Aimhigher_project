import 'package:flutter/material.dart';
import '../services/assessment_logic.dart';
import 'result_screen.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentQuestionIndex = 0;
  final List<String> _answers = [];
  final _questions = StreamAssessmentLogic.questions;
  final TextEditingController _writingController = TextEditingController();

  void _handleAnswer(String answer) {
    _answers.add(answer);
    _writingController.clear();

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      final result = StreamAssessmentLogic.calculateResult(_answers);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              stream: result['stream'] ?? 'Science',
              career: result['career'] ?? 'Generalist',
              alternatives: [result['alt'] ?? 'Commerce'],
              matchPercentage: result['confidence'] ?? 85,
              whyReason: result['reason'] ?? 'Based on your profile, this path matches your strengths.',
              scores: Map<String, int>.from(result['scores'] ?? {}),
              userDream: result['dream'] ?? 'Not specified',
              strengths: List<String>.from(result['strengths'] ?? []),
              weaknesses: List<String>.from(result['weaknesses'] ?? []),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _writingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / _questions.length;
    final bool isWriting = question['type'] == 'writing';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'CAREER ANALYSIS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Progress',
                              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                            ),
                            Text(
                              '${_currentQuestionIndex + 1} / ${_questions.length}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    question['q'] ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 40),
                  isWriting ? _buildWritingInput() : _buildChoiceList(question),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWritingInput() {
    return Column(
      children: [
        TextField(
          controller: _writingController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Share your thoughts here...",
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF3949AB), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              String val = _writingController.text.trim();
              _handleAnswer(val.isEmpty ? "Not specified" : val);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A237E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
            ),
            child: const Text(
              "CONTINUE",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceList(Map<String, dynamic> question) {
    final options = question['options'] as List;
    return Column(
      children: List.generate(options.length, (index) {
        final option = options[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => _handleAnswer(option),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: const Color(0xFF3949AB),
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      option,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2D3142)),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Color(0xFF3949AB)),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
