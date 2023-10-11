import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final permissionProvider = StateNotifierProvider<PermissionService,bool>((ref)=> PermissionService(ref));

class PermissionService extends StateNotifier<bool>{
  final Ref ref;
  PermissionService(this.ref,[bool? state]):super(false){
    handleLocationPermission();
  }

  Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Fluttertoast.showToast(msg: "Location services are disabled. Please enable the services");
    state = false;
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {   
      Fluttertoast.showToast(msg: "Location permissions are denied");
      state = false;
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(msg:"Location permissions are permanently denied, we cannot request permissions.");
    state = false;
    return false;
  }
  state = true;
  return true;
}
}