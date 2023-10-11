import 'package:encure_test/helpers/constants.dart';
import 'package:encure_test/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationDisplayScreen extends HookConsumerWidget {
  const LocationDisplayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(locationProvider);
    final coordinates = position.hasValue ? position.value : null;


    return Scaffold(
      appBar: AppBar(
        title: const Text(locationTitle),
        centerTitle: true,
      ),
      body: FGBGNotifier(
        onEvent: (event) {
          if (event == FGBGType.foreground){
            FlutterBackgroundService().invoke("setAsForeground");
          }else if(event == FGBGType.background){
            FlutterBackgroundService().invoke("setAsBackground");
          }
        },
        child: Column(children: [
          Text("Longitude: ${coordinates?.longitude}"),
          Text("Latitude: ${coordinates?.latitude}"),
        ],),
      ),
    );
  }
}
