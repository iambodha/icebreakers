import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:csv/csv.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ice Breakers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004AAD),
          primary: const Color(0xFF004AAD),
          secondary: const Color(0xFF38B6FF),
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    final double maxScrollExtent = _scrollController.position.maxScrollExtent;
    final double t = (offset / maxScrollExtent).clamp(0.0, 1.0);
    setState(() {
      _backgroundColor = Color.lerp(Colors.white, Colors.white, t)!;
    });
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('App Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('This app is currently in beta.'),
              SizedBox(height: 10),
              Text('If you would like to help, please contact:'),
              Text('somanivibbodh@gmail.com'),
              SizedBox(height: 10),
              Text('Developed by: Vibbodh Somani'),
              Text('Question creation: Bhuvana Reddi'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _launchURL() async {
    const url =
        'https://github.com/your-repository'; // Replace with your GitHub repository URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final sections = ["Basic Ice Breakers", "Deep Thought", "Freaky Friends"];
    final icons = [Icons.ac_unit, Icons.lightbulb, Icons.people];
    final sampleQuestions = [
      "What's your favorite ice cream flavor?",
      "What is the meaning of life?",
      "If you could have any superpower, what would it be?"
    ];

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/app-bar.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 80.0),
                    child: const Text(
                      'Ice Breakers',
                      style: TextStyle(
                        fontFamily: 'TT-Bluescreens',
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 80.0),
                    child: IconButton(
                      icon: const Icon(Icons.info, color: Colors.white),
                      onPressed: _showInfoDialog,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                return Container(
                  color: _backgroundColor,
                  child: child,
                );
              },
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: sections.length +
                      1, // +1 for the "More Coming Soon" section
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < sections.length) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Hero(
                                tag: 'section_$index',
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              QuestionListPage(
                                            title: sections[index],
                                            icon: icons[index],
                                          ),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF004AAD),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Icon(icons[index],
                                              size: 48, color: Colors.white),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  sections[index],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  sampleQuestions[index],
                                                  style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 14,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Placeholder for "More Coming Soon" section
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'More content coming soon!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Feel free to contribute on GitHub:',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4),
                            TextButton.icon(
                              icon: Icon(Icons.code),
                              label: Text('GitHub'),
                              onPressed:
                                  _launchURL, // Call _launchURL method here
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionListPage extends StatefulWidget {
  final String title;
  final IconData icon;

  const QuestionListPage({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  _QuestionListPageState createState() => _QuestionListPageState();
}

class _QuestionListPageState extends State<QuestionListPage> {
  List<String> questions = [];
  List<String> filteredQuestions = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    searchController.addListener(_filterQuestions);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    try {
      final String csvString = await DefaultAssetBundle.of(context).loadString(
          'assets/${widget.title.toLowerCase().replaceAll(" ", "_")}_questions.csv');
      print('CSV String Loaded: $csvString');
      List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);
      print('CSV Table: $csvTable');

      setState(() {
        questions = csvTable.map((row) => row[0].toString()).toList();
        filteredQuestions = questions;
        print('Questions Loaded: $questions');
      });
    } catch (e) {
      print("Error loading questions: $e");
    }
  }

  void _filterQuestions() {
    String searchTerm = searchController.text.toLowerCase();
    setState(() {
      if (searchTerm.isEmpty) {
        filteredQuestions = questions;
      } else {
        filteredQuestions = questions
            .where((question) => question.toLowerCase().contains(searchTerm))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'TT-Bluescreens',
            fontSize: 30, // Adjust size as needed
          ),
        ),
        backgroundColor: const Color(0xFF004AAD),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search questions...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: filteredQuestions.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: FadeInAnimation(
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: index % 2 == 0
                                ? Colors.grey[200]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text(filteredQuestions[index]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
