import 'dart:async';

import 'package:dio/dio.dart';
import 'package:encure_test/helpers/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final positionUpdateProvider = StateNotifierProvider((ref)=> PositionUpdateService(ref));

class PositionUpdateService extends StateNotifier {
  final Ref ref;
  Timer? timer;

  PositionUpdateService(this.ref,[String? state]):super([]);

  updatePosition(Position position)async{

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async{ 


      final dio = Dio();
    final requestURI = Uri.encodeFull(positionServiceURL);

    final data = FormData.fromMap({
      "latitude":"${position.latitude}",
      "longitude":"${position.longitude}"
    });

    final res = await dio.post(requestURI,data: data);

    if (res.statusCode == 200){
      Fluttertoast.showToast(msg: "Data Sent");
      debugPrint("Data Sent");
    }



    });

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}