class StreamAssessmentLogic {
  static List<Map<String, dynamic>> get questions {
    return [
      // SECTION 1: DREAM & CLARITY
      {'id': 'q1', 'q': "What do you want to become in the future?", 'type': 'writing'},
      {'id': 'q2', 'q': "Why do you want to become this?", 'type': 'choice', 'options': ['Passion', 'Money', 'Family pressure', 'Not sure', 'Other']},
      {'id': 'q3', 'q': "How sure are you about your goal?", 'type': 'choice', 'options': ['Very sure', 'Somewhat sure', 'Not sure']},
      
      // SECTION 2: ACADEMIC BACKGROUND
      {'id': 'q4', 'q': "Mathematics Mark (out of 100)", 'type': 'choice', 'options': ['90-100', '75-89', '60-74', 'Below 60'], 'cat': 'science'},
      {'id': 'q5', 'q': "Science Mark (out of 100)", 'type': 'choice', 'options': ['90-100', '75-89', '60-74', 'Below 60'], 'cat': 'science'},
      {'id': 'q6', 'q': "English Mark (out of 100)", 'type': 'choice', 'options': ['90-100', '75-89', '60-74', 'Below 60'], 'cat': 'arts'},
      {'id': 'q7', 'q': "Social Science Mark (out of 100)", 'type': 'choice', 'options': ['90-100', '75-89', '60-74', 'Below 60'], 'cat': 'arts'},
      {'id': 'q8', 'q': "Computer / Accounts Mark (out of 100)", 'type': 'choice', 'options': ['90-100', '75-89', '60-74', 'Below 60'], 'cat': 'commerce'},
      {'id': 'q9', 'q': "Which subject do you score highest in?", 'type': 'choice', 'options': ['Mathematics', 'Science', 'English', 'Social Science', 'Computer / Accounts', 'Other']},
      {'id': 'q10', 'q': "Which subject do you find most difficult?", 'type': 'choice', 'options': ['Mathematics', 'Science', 'English', 'Social Science', 'Computer / Accounts', 'Other']},
      {'id': 'q11', 'q': "If exams didn’t exist, which subject would you still study?", 'type': 'choice', 'options': ['Mathematics', 'Science', 'Business / Accounts', 'Arts / Creative subjects', 'Other']},
      {'id': 'q12', 'q': "How many hours do you study daily?", 'type': 'choice', 'options': ['Less than 1 hour', '1–2 hours', '2–4 hours', 'More than 4 hours']},

      // SECTION 3: INTEREST & PREFERENCE
      {'id': 'q13', 'q': "What would you enjoy more?", 'type': 'choice', 'options': ['Solving a difficult problem', 'Running a business idea', 'Creating something (art, writing, design)', 'Other']},
      {'id': 'q14', 'q': "Which content do you like the most?", 'type': 'choice', 'options': ['Tech / Science', 'Business / Finance', 'Stories / Creativity', 'Other']},
      {'id': 'q15', 'q': "Which type of school project excites you?", 'type': 'choice', 'options': ['Experiment or model', 'Business or planning', 'Creative presentation', 'Other']},
      {'id': 'q16', 'q': "In your free time, you usually:", 'type': 'choice', 'options': ['Learn or explore something new', 'Think of ways to earn or manage money', 'Express ideas (writing, drawing, etc.)', 'Other']},

      // SECTION 4: INTELLIGENCE (THINKING ABILITY)
      {'id': 'q17', 'q': "When you can’t solve a problem, you:", 'type': 'choice', 'options': ['Try different methods', 'Ask for help', 'Skip it']},
      {'id': 'q18', 'q': "You notice a pattern while studying. You:", 'type': 'choice', 'options': ['Try to understand it', 'Memorize it', 'Ignore it']},
      {'id': 'q19', 'q': "You prefer solving problems that are:", 'type': 'choice', 'options': ['Challenging', 'Moderate', 'Easy']},
      {'id': 'q20', 'q': "When you make mistakes, you:", 'type': 'choice', 'options': ['Analyze and improve', 'Repeat same method', 'Avoid that topic']},
      {'id': 'q21', 'q': "When learning something new, you:", 'type': 'choice', 'options': ['Break it into steps', 'Follow instructions', 'Feel confused']},

      // SECTION 5: REAL-WORLD APTITUDE
      {'id': 'q22', 'q': "Your project is not working. You:", 'type': 'choice', 'options': ['Try to fix it step by step', 'Ask someone', 'Leave it']},
      {'id': 'q23', 'q': "You start something new but face difficulty. You:", 'type': 'choice', 'options': ['Keep trying', 'Take help', 'Stop']},
      {'id': 'q24', 'q': "You have ₹1000. You:", 'type': 'choice', 'options': ['Invest in learning', 'Save it', 'Spend it']},
      {'id': 'q25', 'q': "In a group task, you:", 'type': 'choice', 'options': ['Solve technical problems', 'Manage team', 'Do creative work', 'Other']},
      {'id': 'q26', 'q': "Which type of thinking do you prefer?", 'type': 'choice', 'options': ['Logical', 'Practical', 'Creative', 'Other']},

      // SECTION 6: PERSONALITY & BEHAVIOR
      {'id': 'q27', 'q': "You prefer working:", 'type': 'choice', 'options': ['Alone', 'In a team', 'Both', 'Other']},
      {'id': 'q28', 'q': "When stressed, you:", 'type': 'choice', 'options': ['Think deeply', 'Talk to others', 'Express creatively', 'Other']},
      {'id': 'q29', 'q': "You enjoy:", 'type': 'choice', 'options': ['Accuracy', 'Results / money', 'Creativity', 'Other']},
      {'id': 'q30', 'q': "You are more:", 'type': 'choice', 'options': ['Logical', 'Practical', 'Emotional', 'Other']},

      // SECTION 7: REAL-LIFE SITUATIONS
      {'id': 'q31', 'q': "Your friend has a problem. You:", 'type': 'choice', 'options': ['Solve logically', 'Give practical advice', 'Support emotionally']},
      {'id': 'q32', 'q': "You get free time. You:", 'type': 'choice', 'options': ['Learn something', 'Plan something', 'Create something', 'Other']},
      {'id': 'q33', 'q': "You face failure. You:", 'type': 'choice', 'options': ['Try again', 'Change approach', 'Give up']},

      // SECTION 8: CONSISTENCY CHECK
      {'id': 'q34', 'q': "Do you like Mathematics?", 'type': 'choice', 'options': ['Yes', 'No']},
      {'id': 'q35', 'q': "Would you choose Mathematics if optional?", 'type': 'choice', 'options': ['Yes', 'No']},
      {'id': 'q36', 'q': "Do you enjoy studying?", 'type': 'choice', 'options': ['Yes', 'No']},
      {'id': 'q37', 'q': "Do you study even when not forced?", 'type': 'choice', 'options': ['Yes', 'No']},

      // SECTION 9: WEAKNESS IDENTIFICATION
      {'id': 'q38', 'q': "Your biggest challenge:", 'type': 'choice', 'options': ['Lack of focus', 'Fear of exams', 'Don’t understand concepts', 'Other']},
      {'id': 'q39', 'q': "What distracts you most?", 'type': 'choice', 'options': ['Phone', 'Laziness', 'No guidance', 'Other']},
      {'id': 'q40', 'q': "What do you need most right now?", 'type': 'choice', 'options': ['Discipline', 'Motivation', 'Proper guidance', 'Other']},

      // SECTION 10: CAREER AWARENESS
      {'id': 'q41', 'q': "Do you know how to achieve your goal?", 'type': 'choice', 'options': ['Yes', 'Little', 'No']},
      {'id': 'q42', 'q': "Do you have someone guiding you?", 'type': 'choice', 'options': ['Yes', 'No']},
      {'id': 'q43', 'q': "Are you ready to work hard for your goal?", 'type': 'choice', 'options': ['Yes', 'No', 'Not sure']},

      // SECTION 11: FINAL INTELLIGENCE & REFLECTION
      {'id': 'q44', 'q': "You learn best by:", 'type': 'choice', 'options': ['Solving problems', 'Discussing', 'Creating', 'Other']},
      {'id': 'q45', 'q': "You prefer:", 'type': 'choice', 'options': ['Theory', 'Practical', 'Creative', 'Other']},
      {'id': 'q46', 'q': "Do you complete what you start?", 'type': 'choice', 'options': ['Yes', 'No', 'Sometimes']},
      {'id': 'q47', 'q': "Do you take initiative?", 'type': 'choice', 'options': ['Yes', 'No', 'Sometimes']},
      {'id': 'q48', 'q': "Do you learn from mistakes?", 'type': 'choice', 'options': ['Yes', 'No', 'Sometimes']},
      {'id': 'q49', 'q': "Do you like challenges?", 'type': 'choice', 'options': ['Yes', 'No', 'Sometimes']},
      {'id': 'q50', 'q': "Which type of work makes you feel happy and satisfied?", 'type': 'writing'},
    ];
  }

  static Map<String, dynamic> calculateResult(List<String> answers) {
    double sci = 0, com = 0, art = 0;
    int lieScore = 0;
    List<String> strengths = [];
    List<String> weaknesses = [];

    for (int i = 0; i < answers.length; i++) {
      if (i >= questions.length) break;
      String ans = answers[i];
      var q = questions[i];

      if (q['type'] == 'writing') continue;

      // Scoring
      if (i >= 3 && i <= 7) { // Marks
        int val = ans == '90-100' ? 20 : (ans == '75-89' ? 15 : 10);
        if (q['cat'] == 'science') sci += val;
        else if (q['cat'] == 'commerce') com += val;
        else if (q['cat'] == 'arts') art += val;
      }

      // Logic for interest/aptitude
      if (ans.contains('Solve') || ans.contains('Tech') || ans.contains('Experiment') || ans.contains('Logical')) sci += 10;
      if (ans.contains('Business') || ans.contains('Money') || ans.contains('Manage') || ans.contains('Practical')) com += 10;
      if (ans.contains('Create') || ans.contains('Art') || ans.contains('Story') || ans.contains('Creative') || ans.contains('Emotional')) art += 10;

      // Consistency Check (Q34 vs Q35)
      if (i == 34) {
        if (answers.length > 33 && answers[33] == 'No' && ans == 'Yes') lieScore++;
      }
    }

    // Strengths analysis
    if (sci > com && sci > art) {
      strengths.addAll(["Logical thinking", "Good understanding of concepts"]);
    } else if (com > sci && com > art) {
      strengths.addAll(["Leadership potential", "Practical decision making"]);
    } else {
      strengths.addAll(["Creative expression", "Empathy"]);
    }
    if (answers.length > 45 && answers[45] == 'Yes') strengths.add("Consistent in studies");

    // Weaknesses analysis
    if (answers.length > 37) {
      if (answers[37].contains('focus')) weaknesses.add("Lack of focus");
      if (answers[37].contains('Fear')) weaknesses.add("Low confidence in exams");
    }
    if (answers.length > 39 && answers[39].contains('Other')) weaknesses.add("Needs specific mentorship");

    double total = sci + com + art;
    if (total <= 0) total = 1;

    int confidence = (95 - (lieScore * 15)).clamp(50, 98).toInt();

    String recommendation = 'Science';
    if (com > sci && com > art) recommendation = 'Commerce';
    if (art > sci && art > com) recommendation = 'Arts';

    // CAREER PATH DETECTION (New Logic to match Roadmap)
    String dream = (answers.isNotEmpty ? answers[0] : "").toLowerCase();
    String careerPath = recommendation; // Default to Stream name
    
    if (dream.contains("doctor") || dream.contains("mbbs") || dream.contains("medical") || dream.contains("nurse")) {
      careerPath = "Medical";
    } else if (dream.contains("engineer") || dream.contains("software") || dream.contains("tech") || dream.contains("computer")) {
      careerPath = "Engineering";
    } else if (dream.contains("ias") || dream.contains("ips") || dream.contains("upsc") || dream.contains("government") || dream.contains("civil")) {
      careerPath = "Government";
    } else if (dream.contains("business") || dream.contains("ca") || dream.contains("finance") || dream.contains("entrepreneur") || dream.contains("bank")) {
      careerPath = "Finance";
    }

    return {
      'stream': recommendation,
      'career': careerPath,
      'confidence': confidence,
      'strengths': strengths,
      'weaknesses': weaknesses,
      'dream': answers.isNotEmpty ? answers[0] : "Not specified",
      'scores': {
        'science': ((sci / total) * 100).toInt(),
        'commerce': ((com / total) * 100).toInt(),
        'arts': ((art / total) * 100).toInt(),
      },
      'reason': "Your analysis highlights a natural inclination towards $recommendation based on your interests and performance.",
      'alt': (recommendation == 'Science') ? 'Commerce' : (recommendation == 'Commerce' ? 'Arts' : 'Science')
    };
  }
}
