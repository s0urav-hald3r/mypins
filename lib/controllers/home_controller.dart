// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypins/models/collection_model.dart';
import 'package:mypins/services/local_storage.dart';
import 'package:mypins/services/navigator_key.dart';

enum Plan { WEEKLY, MONTHLY, LIFETIME }

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final pageController = PageController();

  final pinUrl = TextEditingController();
  final createCollection = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    restoreCollections();
  }

  Future<void> restoreCollections() async {
    final jsonList = LocalStorage.getData('collections', KeyType.STR);

    if ((jsonList ?? '').isNotEmpty) {
      _collections.clear();

      for (var json in jsonDecode(jsonList)) {
        _collections.add(CollectionModel.fromJson(json));
      }
    }
  }

  // Private variables
  final RxInt _onboardingIndex = 0.obs;
  final RxInt _homeIndex = 0.obs;
  final Rx<Plan> _selectedPlan = Plan.LIFETIME.obs;
  final RxList<CollectionModel> _collections = <CollectionModel>[].obs;
  // Getters
  int get onboardingIndex => _onboardingIndex.value;
  int get homeIndex => _homeIndex.value;
  Plan get selectedPlan => _selectedPlan.value;
  List<CollectionModel> get collections => _collections;

  // Setters
  set onboardingIndex(value) => _onboardingIndex.value = value;
  set homeIndex(value) => _homeIndex.value = value;
  set selectedPlan(value) => _selectedPlan.value = value;
  set collections(value) => _collections.value = value;

  Future<void> createCollectionModel() async {
    final name = createCollection.text.trim();
    final newCollection = CollectionModel(name: name, images: []);

    _collections.add(newCollection);
    createCollection.clear();
    await addCollectionsToLocal();
    NavigatorKey.pop();
  }

  Future<void> addCollectionsToLocal() async {
    String jsonString =
        jsonEncode(collections.map((model) => model.toJson()).toList());

    LocalStorage.addData('collections', jsonString);
  }
}
