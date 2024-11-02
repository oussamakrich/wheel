import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyBottomBar extends StatefulWidget {
  MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: _bannerAd != null ? _bannerAd!.size.height.toDouble() : 0,
      child: _bannerAd != null ? AdWidget(ad: _bannerAd!) : const SizedBox(),
    );
  }

  void _loadAd() {
    BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3242400441111907/5521741876",
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    ).load();
  }
}
// ID APP : ca-app-pub-3242400441111907~2178772557
// ca-app-pub-3242400441111907/6667676317 banner
// ca-app-pub-3242400441111907/6531944944 inter


// ID APP : ca-app-pub-3242400441111907~3312633087
// ca-app-pub-3242400441111907/1504727394 banner
// ca-app-pub-3242400441111907/6531944944 inter



// app ca-app-pub-3242400441111907~9306469448
//banner ca-app-pub-3242400441111907/5521741876