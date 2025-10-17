import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/api_services/address_provi.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/model/bannar_model.dart';
import 'package:quick_home/model/category_model.dart';
import 'package:quick_home/model/home_model.dart';
import 'package:quick_home/model/profile_model.dart';
import 'package:quick_home/model/serviceModel.dart';

final bannarProvider = StateProvider<List<BannerModel>>((ref) => []);
final categoryProvider = StateProvider<List<CategoryModel>>((ref) => []);
final serviceModelProvider = StateProvider<List<ServicesModel>>((ref) => []);
final productProvider = StateProvider<List<ServicesModel>>((ref) => []);
final addressProvider = StateProvider<List<Address>>((ref) => []);
final offerProvider = StateProvider<List<HomeModel>>((ref) => []);
final profileProvider = StateProvider<ProfileModel?>((ref) => null);
final addressDeleteProvider = Provider((ref) => AddressService());
