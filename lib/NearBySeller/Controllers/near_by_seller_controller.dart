import 'dart:math' show cos, sqrt, asin;
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unidoor_ecommerce/NearBySeller/Models/near_by_seller_models.dart';
import 'package:unidoor_ecommerce/NearBySeller/Services/near_by_sellers_api.dart';

class NearBySellerController extends GetxController {
  var sellerNearByPrimaryList = RxList<Datum>().obs;
  var sellerNearByList = RxList<Datum>().obs;
  var sellerNearBySearchList = RxList<Datum>().obs;
  var isLoading = true.obs;
  // var locationCoordinates = RxList<Location>().obs;
  double distances;
  List sortedDistances = [].obs;
  String currentLocationLat;
  String currentLocationLong;
  RxBool isSearchTapped = false.obs;
  RxString searchString = ''.obs;

  @override
  void onInit() {
    print("init called");
    super.onInit();
    fetchNearBySeller();
  }

  void clearSearchResult() {
    sellerNearBySearchList.value.clear();

    sellerNearByPrimaryList.value.forEach((element) {
      sellerNearByList.value.add(element);
    });
  }

  void fetchSearchResults(String value) {
    sellerNearByList.value.clear();
    //  Do Api call here and get
    // sellerNearByList.value = [];
    final String searchString = value.toLowerCase();

    if (sellerNearByPrimaryList.value != null) {
      final tempList = sellerNearByPrimaryList.value
          .where((value) => value.name.contains(searchString))
          .toList();
      tempList.forEach((element) => sellerNearByList.value.add(element));
    } else {}
  }

  void fetchNearBySeller() async {
    SharedPreferences currentLocationStorage =
        await SharedPreferences.getInstance();
    currentLocationLat = currentLocationStorage.getString('currentLocationLat');
    currentLocationLong =
        currentLocationStorage.getString('currentLocationLat');
    print("CurrentLatitude = $currentLocationLat");
    print("CurrentLongitude = $currentLocationLong");
    isLoading(true);
    print("fetch method called");
    var sellerNearByListJson = await NearBySellersApi.getNearBySeller();
    sellerNearByListJson.forEach((element) {
      // double lat = element.location.first; //12.54498;
      // double long = element.location.last; //74.9617935;
      double lat = 12.54498;
      double long = 74.9617935;
      print("lat = $lat");
      print("long = $long");
      distances = calculateDistance(lat, long);
      element.distance = distances;
    });

    sellerNearByListJson.sort((a, b) {
      return a.distance.compareTo(b.distance);
    });
    print("modified json = $sellerNearByListJson");
    int distanceIndex = sellerNearByListJson.length;
    for (Datum datum in sellerNearByListJson) {
      sellerNearByPrimaryList.value.add(datum);
    }

    sellerNearByPrimaryList.value.forEach((element) {
      sellerNearByList.value.add(element);
    });
    print("distances = $distances");
    isLoading(false);
  }

  double calculateDistance(lat1, lon1) {
    var p = 0.017453292519943295;
    var lat2 = double.parse("$currentLocationLat");
    var lon2 = double.parse("$currentLocationLong");
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // sortedDistance() {
  //   distances.forEach((element) {
  //     distances.sort();
  //   });
  //
  //   print("Sorted array = $distances");
  // }
}
