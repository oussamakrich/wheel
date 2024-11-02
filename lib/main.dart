import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';
import 'dart:math';

import 'package:whellspiner/banner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spin Wheel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: EnterWordsScreen(),
    );
  }
}

class EnterWordsScreen extends StatefulWidget {
  @override
  _EnterWordsScreenState createState() => _EnterWordsScreenState();
}

class _EnterWordsScreenState extends State<EnterWordsScreen> {
  List<String> words = [];
  TextEditingController controller = TextEditingController();

  // InterstitialAd? _interstitialAd;
  // int _numInterstitialLoadAttempts = 0;
  // static const int maxFailedLoadAttempts = 3;

  // void _showInterstitialAd() {
  //   if (_interstitialAd == null) {
  //     print('Warning: attempt to show interstitial before loaded.');
  //     _navigateToSpinWheel();
  //     return;
  //   }
  //   _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //         print('ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       _createInterstitialAd();
  //       _navigateToSpinWheel();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       _createInterstitialAd();
  //       _navigateToSpinWheel();
  //     },
  //   );
  //   _interstitialAd!.show();
  //   _interstitialAd = null;
  // }

  void _navigateToSpinWheel() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpinWheelScreen(words: words),
      ),
    );
  }

  // void _createInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId:
  //         'ca-app-pub-3242400441111907/2494052030', // Your Android ad unit ID
  //     request: const AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (InterstitialAd ad) {
  //         print('$ad loaded');
  //         _interstitialAd = ad;
  //         _numInterstitialLoadAttempts = 0;
  //         _interstitialAd!.setImmersiveMode(true);
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         print('InterstitialAd failed to load: $error.');
  //         _numInterstitialLoadAttempts += 1;
  //         _interstitialAd = null;
  //         if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
  //           _createInterstitialAd();
  //         }
  //       },
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // _createInterstitialAd();
  }

  @override
  void dispose() {
    // _interstitialAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enter Words',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Enter a word',
                  labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                style: const TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    words.add(controller.text);
                    controller.clear();
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Add Word',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: words.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          words[index],
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              words.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // onPressed: words.isNotEmpty ? _showInterstitialAd : null,
              onPressed: words.isNotEmpty ? _navigateToSpinWheel : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: words.isNotEmpty ? Colors.teal : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Go to Spin the Wheel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(),
    );
  }
}

class SpinWheelScreen extends StatefulWidget {
  final List<String> words;

  SpinWheelScreen({required this.words});

  @override
  _SpinWheelScreenState createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen> {
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void spinWheel() {
    int selectedIndex = Random().nextInt(widget.words.length);
    selected.add(selectedIndex);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spin the Wheel',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: widget.words.length > 1
                  ? Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: FortuneWheel(
                          items: [
                            for (var word in widget.words)
                              FortuneItem(
                                child: Text(
                                  word,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: FortuneItemStyle(
                                  color: getRandomColor(),
                                  borderColor: Colors.white,
                                  borderWidth: 2,
                                ),
                              ),
                          ],
                          onFling: spinWheel,
                          selected: selected.stream,
                          indicators: const <FortuneIndicator>[
                            FortuneIndicator(
                              alignment: Alignment.topCenter,
                              child: TriangleIndicator(
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Not enough words to spin the wheel.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: widget.words.length > 1 ? spinWheel : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Spin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
