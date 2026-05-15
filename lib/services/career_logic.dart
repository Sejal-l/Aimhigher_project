class CareerLogic {
  static List<Map<String, dynamic>> getQuestions(String stream) {
    List<Map<String, String>> data;
    
    if (stream == 'Science') {
      data = [
        {'q': "I love building and fixing mechanical things.", 'cat': 'Engineering'},
        {'q': "I enjoy coding and creating software or apps.", 'cat': 'Engineering'},
        {'q': "I am interested in how robots are programmed.", 'cat': 'Engineering'},
        {'q': "I want to design new technologies for the future.", 'cat': 'Engineering'},
        {'q': "I like solving technical problems with logic.", 'cat': 'Engineering'},
        {'q': "I am fascinated by how airplanes and rockets fly.", 'cat': 'Engineering'},
        {'q': "I enjoy math when it's applied to real machines.", 'cat': 'Engineering'},
        {'q': "I want to build the world's most advanced bridge.", 'cat': 'Engineering'},
        {'q': "I like learning about hardware and circuitry.", 'cat': 'Engineering'},
        {'q': "I prefer engineering labs over biological studies.", 'cat': 'Engineering'},
        
        {'q': "I want to help people by curing their diseases.", 'cat': 'Medical'},
        {'q': "I am fascinated by how the human heart works.", 'cat': 'Medical'},
        {'q': "I am not afraid of blood or medical environments.", 'cat': 'Medical'},
        {'q': "I enjoy biology and studying living organisms.", 'cat': 'Medical'},
        {'q': "I want to be a surgeon and perform operations.", 'cat': 'Medical'},
        {'q': "I am interested in how medicines interact with our body.", 'cat': 'Medical'},
        {'q': "I want to work in a hospital helping patients.", 'cat': 'Medical'},
        {'q': "I enjoy learning about DNA and human genetics.", 'cat': 'Medical'},
        {'q': "I care about making healthcare better for everyone.", 'cat': 'Medical'},
        {'q': "I prefer medical research over mechanical engineering.", 'cat': 'Medical'},

        {'q': "I want to discover things that no one knows yet.", 'cat': 'Research'},
        {'q': "I love reading about black holes and galaxies.", 'cat': 'Research'},
        {'q': "I prefer a quiet lab or library for my work.", 'cat': 'Research'},
        {'q': "I enjoy conducting long-term experiments.", 'cat': 'Research'},
        {'q': "I want to find a solution for global climate change.", 'cat': 'Research'},
        {'q': "I am interested in pure physics and theoretical math.", 'cat': 'Research'},
        {'q': "I like studying tiny atoms and subatomic particles.", 'cat': 'Research'},
        {'q': "I want to be a scientist in a major research center.", 'cat': 'Research'},
        {'q': "I enjoy observing nature through a microscope.", 'cat': 'Research'},
        {'q': "I prefer asking 'Why?' over building things.", 'cat': 'Research'},
      ];
    } else if (stream == 'Commerce') {
      data = [
        {'q': "I want to start and run my own big company.", 'cat': 'Business'},
        {'q': "I enjoy selling things and negotiating deals.", 'cat': 'Business'},
        {'q': "I am interested in how startups become famous.", 'cat': 'Business'},
        {'q': "I want to be a CEO and lead thousands of people.", 'cat': 'Business'},
        {'q': "I like coming up with new business strategies.", 'cat': 'Business'},
        {'q': "I am fascinated by how global markets work.", 'cat': 'Business'},
        {'q': "I want to manage a huge international brand.", 'cat': 'Business'},
        {'q': "I enjoy watching shows where people pitch ideas.", 'cat': 'Business'},
        {'q': "I want to be known as a successful entrepreneur.", 'cat': 'Business'},
        {'q': "I prefer the business world over banking.", 'cat': 'Business'},

        {'q': "I love tracking the stock market every day.", 'cat': 'Finance'},
        {'q': "I am very good at managing money and savings.", 'cat': 'Finance'},
        {'q': "I want to work in a big bank or stock exchange.", 'cat': 'Finance'},
        {'q': "I enjoy solving math problems about money.", 'cat': 'Finance'},
        {'q': "I want to help people grow their personal wealth.", 'cat': 'Finance'},
        {'q': "I am interested in taxation and financial laws.", 'cat': 'Finance'},
        {'q': "I like analyzing profit and loss statements.", 'cat': 'Finance'},
        {'q': "I want to be a professional investment banker.", 'cat': 'Finance'},
        {'q': "I find the concept of interest rates fascinating.", 'cat': 'Finance'},
        {'q': "I prefer working with numbers over leading teams.", 'cat': 'Finance'},

        {'q': "I am excellent at organizing events and teams.", 'cat': 'Management'},
        {'q': "I like making sure projects finish on time.", 'cat': 'Management'},
        {'q': "I enjoy resolving arguments between coworkers.", 'cat': 'Management'},
        {'q': "I want to be a manager in a high-paced office.", 'cat': 'Management'},
        {'q': "I am good at planning daily tasks for others.", 'cat': 'Management'},
        {'q': "I like creating rules to keep things orderly.", 'cat': 'Management'},
        {'q': "I want a job where I make big decisions daily.", 'cat': 'Management'},
        {'q': "I am interested in human resource management.", 'cat': 'Management'},
        {'q': "I enjoy public speaking and presentations.", 'cat': 'Management'},
        {'q': "I prefer management over pure finance roles.", 'cat': 'Management'},
      ];
    } else {
      data = [
        {'q': "I love drawing and being creative every day.", 'cat': 'Design'},
        {'q': "I want to design clothes, rooms, or cars.", 'cat': 'Design'},
        {'q': "I have a good eye for style and fashion.", 'cat': 'Design'},
        {'q': "I want to be an architect or a graphic designer.", 'cat': 'Design'},
        {'q': "I enjoy creating beautiful visual content.", 'cat': 'Design'},
        {'q': "I am interested in user interface (UI) design.", 'cat': 'Design'},
        {'q': "I love decorating my space to look unique.", 'cat': 'Design'},
        {'q': "I want my work to be remembered for its beauty.", 'cat': 'Design'},
        {'q': "I enjoy sketching my ideas before talking.", 'cat': 'Design'},
        {'q': "I prefer a design studio over a newsroom.", 'cat': 'Design'},

        {'q': "I want to be a famous YouTuber or blogger.", 'cat': 'Media'},
        {'q': "I love writing stories, news, or screenplays.", 'cat': 'Media'},
        {'q': "I enjoy being on camera or performing.", 'cat': 'Media'},
        {'q': "I am interested in how social media trends start.", 'cat': 'Media'},
        {'q': "I want to work in a TV station or movie studio.", 'cat': 'Media'},
        {'q': "I enjoy interviewing people and telling stories.", 'cat': 'Media'},
        {'q': "I am good at public relations and journalism.", 'cat': 'Media'},
        {'q': "I want to influence millions with my voice.", 'cat': 'Media'},
        {'q': "I love reading books and analyzing media.", 'cat': 'Media'},
        {'q': "I prefer communication roles over law.", 'cat': 'Media'},

        {'q': "I want to help people by making better laws.", 'cat': 'Government'},
        {'q': "I am very interested in politics and power.", 'cat': 'Government'},
        {'q': "I want to fight for justice in a court of law.", 'cat': 'Government'},
        {'q': "I enjoy debating and proving my point with facts.", 'cat': 'Government'},
        {'q': "I want to work for the UN or civil services.", 'cat': 'Government'},
        {'q': "I care deeply about human rights and society.", 'cat': 'Government'},
        {'q': "I want to be a leader who changes the world.", 'cat': 'Government'},
        {'q': "I am interested in history and global relations.", 'cat': 'Government'},
        {'q': "I want to serve the public and help everyone.", 'cat': 'Government'},
        {'q': "I prefer a government office over a studio.", 'cat': 'Government'},
      ];
    }

    return List.generate(30, (i) {
      var item = data[i];
      return {
        'id': 'c$i',
        'question': item['q'],
        'category': item['cat'],
        'options': ['Not at all', 'A little', 'Neutral', 'Yes', 'Love it!'],
      };
    });
  }

  static Map<String, dynamic> calculateCareer(String stream, List<String> answers) {
    List<Map<String, dynamic>> questions = getQuestions(stream);
    Map<String, int> scores = {};
    
    for (int i = 0; i < answers.length; i++) {
      String cat = questions[i]['category'];
      int val = _getVal(answers[i]);
      scores[cat] = (scores[cat] ?? 0) + val;
    }

    List<String> sortedKeys = scores.keys.toList()
      ..sort((a, b) => scores[b]!.compareTo(scores[a]!));

    String mainCareer = sortedKeys.isNotEmpty ? sortedKeys[0] : "Professional";
    List<String> alts = [];
    if (sortedKeys.length > 1) alts.add(sortedKeys[1]);
    if (sortedKeys.length > 2) alts.add(sortedKeys[2]);

    int topScore = scores[mainCareer] ?? 0;
    int totalScore = scores.values.fold(0, (sum, item) => sum + item);
    int matchPercentage = ((topScore / totalScore) * 100).toInt();
    if (matchPercentage < 75) matchPercentage = 75 + (matchPercentage % 15);

    return {
      'career': mainCareer,
      'alternatives': alts,
      'match': matchPercentage,
      'why': "Based on your strong affinity for ${mainCareer.toLowerCase()} tasks, you have a natural talent for this career path!"
    };
  }

  static int _getVal(String a) {
    switch (a) {
      case 'Love it!': return 5;
      case 'Yes': return 4;
      case 'Neutral': return 3;
      case 'A little': return 2;
      case 'Not at all': return 1;
      default: return 1;
    }
  }
}
