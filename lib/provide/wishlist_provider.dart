import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/model/wishlist_model.dart';

final wishlistProvider = StateProvider<List<WishlistModel>>((ref) => []);
