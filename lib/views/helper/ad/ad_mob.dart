import 'package:emeal_app/settings/settings_info.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMob extends StatelessWidget {
  const AdMob({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerAd = BannerAd(
        adUnitId: SettingsInfo().ad.unitId,
        listener: BannerAdListener(
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        size: AdSize.fullBanner);

    return SizedBox(
        width: double.infinity,
        height: bannerAd.size.height.toDouble(),
        child: FutureBuilder(
            future: bannerAd.load(),
            builder: ((context, snapshot) {
              return AdWidget(ad: bannerAd);
            })));
  }
}
