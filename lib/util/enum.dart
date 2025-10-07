import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomTabProvider = StateProvider<BottomTab>((ref) => BottomTab.home);

enum BookingTab { inProgress, upcoming, completed, cancelled }

enum BottomTab { home, bookings, wishlist, profile }
