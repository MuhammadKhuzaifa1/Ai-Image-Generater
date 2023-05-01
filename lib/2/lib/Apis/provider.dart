
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../MobileAds.dart';
import '../constants/Utils.dart';

class DownloadingImageController extends ChangeNotifier {

  bool _loading = false;
  int _progressData = 5;

  int get progressData => _progressData;
  bool get loading => _loading;

  setValue(int value){
    _progressData = value;
    notifyListeners();
  }

  setLoadingValue(bool value){
    _loading = value;
    notifyListeners();
  }

  saveimage(String? Downloads,BuildContext context) async {
    setLoadingValue(true);
    var response = await Dio().get(
      Downloads.toString(),
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (count, total) {
        _progressData = int.parse(((count / total) * 100).toStringAsFixed(0));
        setValue(_progressData);
        print("${((count / total) * 100).toStringAsFixed(0)}");
      },
    );

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "ai_${(15)}");
    setLoadingValue(false);
    // MobileAdsContrell().loadInterstitialAd();
    Utils.flushBarMessage("Image Save Gallery?", context);

    print(result);
  }
}
