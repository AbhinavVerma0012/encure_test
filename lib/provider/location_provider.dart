import 'package:encure_test/provider/permission_provider.dart';
import 'package:encure_test/provider/position_update_service_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationProvider = StreamProvider<Position>((ref) async*{
  
  final hasPermission = ref.watch(permissionProvider);
  if (!hasPermission) return;

  final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  await Future.delayed(const Duration(seconds: 1));
  await ref.read(positionUpdateProvider.notifier).updatePosition(position);

  yield position;
},dependencies: [permissionProvider]);