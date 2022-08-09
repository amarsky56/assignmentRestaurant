
import 'package:assignment/app/data/CatModelCatLocal.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

class GetStorageService extends GetxService {
  static final catModel = GetStorage('catModel');

  saveLocationList(String storageKey, List<CatModelCatLocal> storageValue) async => await catModel.write(storageKey, storageValue);

  /// read from storage
  getLocationList(String storageKey) => catModel.read(storageKey);

  void deleteLocation(CatModelCatLocal selectedLocation) {
    catModel.remove(selectedLocation.toString());
  }

  Future<GetStorageService> initState() async {
    await GetStorage.init('catModel');

    return this;
  }
}
