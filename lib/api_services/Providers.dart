import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/model/bannar_model.dart';
import 'package:quick_home/model/booking_options_model.dart';
import 'package:quick_home/model/cart_model.dart';
import 'package:quick_home/model/category_model.dart';
import 'package:quick_home/model/home_model.dart';
import 'package:quick_home/model/offers_model.dart';
import 'package:quick_home/model/profile_model.dart';
import 'package:quick_home/model/serviceModel.dart';
import 'package:quick_home/model/service_details_model.dart';
import 'package:quick_home/model/wishlist_model.dart';
import 'package:quick_home/provide/address_provider.dart';


final bannarProvider = StateProvider<List<BannerModel>>((ref) => []);
final categoryProvider = StateProvider<List<CategoryModel>>((ref) => []);
final serviceModelProvider = StateProvider<List<ServicesModel>>((ref) => []);
final productProvider = StateProvider<List<ServicesModel>>((ref) => []);
final addressProvider = StateProvider<List<Address>>((ref) => []);
final offerProvider = StateProvider<List<HomeModel>>((ref) => []);
final wishlistProvider = StateProvider<List<WishlistModel>>((ref) => []);
final cartProvider = StateProvider<List<CartModel>>((ref) => []);

final serviceDetailsProvider = StateProvider<ServiceDetailsModel?>((ref) => null);
final bookingDateProvider =  StateProvider<List<BookingDate>>((ref) => []);
final bookingTimeProvider =  StateProvider<List<BookingTime>>((ref) => []);
final serviceProvider =  StateProvider<List<ServiceProvider>>((ref) => []);

final profileProvider = StateProvider<ProfileModel?>((ref) => null);
final addressDeleteProvider = Provider((ref) => AddressService());
// final serviceDetailsProvider = StateProvider<ServiceDetailsModel?>((ref) => null);


