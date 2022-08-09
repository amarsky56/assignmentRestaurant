import 'dart:convert';
import 'dart:async';
import 'package:assignment/app/data/CatModel.dart';
import 'package:assignment/app/data/CatModelCatLocal.dart';
import 'package:assignment/app/routes/app_pages.dart';
import 'package:assignment/services/storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt mPrice = 0.obs;

  RxList<CatModel> catModel = <CatModel>[].obs;

  RxInt viewIndexLocal = 0.obs;
  RxList<CatModelCatLocal> catModelLocal = <CatModelCatLocal>[].obs;
  RxBool isPopularView = true.obs;
  List<CatModelCatLocal> tempItem = <CatModelCatLocal>[];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getLocalData();
    getJson();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getJson() async {
    String jobsString = await rootBundle.loadString("assets/Menu.json");
    var mJson = await jsonDecode(jobsString);
    catModel.value = ((mJson as List).map((i) => CatModel.fromJson(i)).toList());
    isLoading.value = false;
  }



  void updateCount(int index, int catIndex, int count, int price) {
    isLoading.value = true;
    catModel[index].cat![catIndex].count = count;
    if (catModel[index].cat![catIndex].count == null) {
      mPrice.value = mPrice.value + price;
      tempItem.add(CatModelCatLocal(
          price: catModel[index].cat![catIndex].price,
          name: catModel[index].cat![catIndex].name,
          instock: catModel[index].cat![catIndex].instock,
          count: catModel[index].cat![catIndex].count,
          localCount: 0));
    } else {
      if (catModel[index].cat![catIndex].count! > count) {
        mPrice.value = mPrice.value - price;
        tempItem.remove(catModel[index].cat![catIndex]);
      } else {
        var contain = tempItem.where((element) => element.name == catModel[index].cat![catIndex].name);
        if (contain.isEmpty) {
          tempItem.add(CatModelCatLocal(
              price: catModel[index].cat![catIndex].price,
              name: catModel[index].cat![catIndex].name,
              instock: catModel[index].cat![catIndex].instock,
              count: catModel[index].cat![catIndex].count,
              localCount: 0));
        } else {
          tempItem[tempItem.indexWhere((element) => element.name == catModel[index].cat![catIndex].name)] = CatModelCatLocal(
              price: catModel[index].cat![catIndex].price,
              name: catModel[index].cat![catIndex].name,
              instock: catModel[index].cat![catIndex].instock,
              count: catModel[index].cat![catIndex].count,
              localCount: 0);
        }
        mPrice.value = mPrice.value + price;
      }
    }
    isLoading.value = false;
  }

  updateIndexLocal() {
    isLoading.value = true;
    isPopularView.value = !isPopularView.value;
    isLoading.value = false;
  }

  void updateCountLocal(int index, int count, int price) {
    isLoading.value = true;
    catModelLocal[index].count = count;
    if (catModelLocal[index].count == null) {
      mPrice.value = mPrice.value + price;
      tempItem.add(catModelLocal[index]);
    } else {
      if (catModelLocal[index].count! > count) {
        mPrice.value = mPrice.value - price;
        tempItem.remove(catModelLocal[index]);
      } else {
        var contain = tempItem.where((element) => element.name == catModelLocal[index].name);
        if (contain.isEmpty) {
          tempItem.add(catModelLocal[index]);
        } else {
          tempItem[tempItem.indexWhere((element) => element.name == catModelLocal[index].name)] = catModelLocal[index];
        }
        mPrice.value = mPrice.value + price;
      }
    }
    isLoading.value = false;
  }

  void saveOrder() {
    if (tempItem.isEmpty) {
      Get.snackbar("Please select", "at least one item");
    } else {
      isLoading(true);
      for (var mList in tempItem) {
        catModelLocal.add(CatModelCatLocal(localCount: mList.count, count: 0, name: mList.name, price: mList.price, instock: mList.instock));
      }
      Get.find<GetStorageService>().saveLocationList("storageKey", catModelLocal.value);
      Get.toNamed(Routes.SUCCESS)!.then((value) {
        getJson();
        mPrice.value = 0;
        final Map<String, CatModelCatLocal> profileMap = new Map();
        catModelLocal.value.forEach((item) {
          profileMap[item.name!] = item;
        });
        catModelLocal.value = profileMap.values.toList();
        catModelLocal.value.sort((a, b) => b.localCount!.compareTo(a.localCount!));
      });
      isLoading(false);
    }
  }

  Future<void> getLocalData() async {
    var loacalList = Get.find<GetStorageService>().getLocationList("storageKey");
    isLoading(true);

    if (loacalList != null) {
      for (var mList in loacalList) {
        catModelLocal.value.add(CatModelCatLocal(name: mList['name'], price: mList['price'], instock: mList['instock'], count: 0, localCount: mList['localCount']));
      }
    }
    final Map<String, CatModelCatLocal> profileMap = new Map();
    catModelLocal.value.forEach((item) {
      profileMap[item.name!] = item;
    });
    catModelLocal.value = profileMap.values.toList();
    catModelLocal.value.sort((a, b) => b.localCount!.compareTo(a.localCount!));
    isLoading(false);
  }
}
