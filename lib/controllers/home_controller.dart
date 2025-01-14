// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypins/config/constants.dart';
import 'package:mypins/models/collection_model.dart';
import 'package:mypins/models/pin_model.dart';
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
    restoreSavedPins();
    restoreSavedPinsCount();
    restoreCollections();
  }

  Future<void> restoreSavedPins() async {
    final jsonList = LocalStorage.getData(savedPinsCon, KeyType.STR);

    if ((jsonList ?? '').isNotEmpty) {
      _savedPins.clear();

      final jsonBody = jsonDecode(jsonList);

      for (var json in jsonBody) {
        _savedPins.add(PinModel.fromJson(json));
      }
    }
  }

  Future<void> restoreSavedPinsCount() async {
    savedPinsCount = LocalStorage.getData(savedPinsCountCon, KeyType.INT);
  }

  Future<void> restoreCollections() async {
    final jsonList = LocalStorage.getData(collectionsCon, KeyType.STR);

    if ((jsonList ?? '').isNotEmpty) {
      _collections.clear();

      final jsonBody = jsonDecode(jsonList);

      for (var json in jsonBody) {
        _collections.add(CollectionModel.fromJson(json));
      }
    }
  }

  // Private variables
  final RxInt _onboardingIndex = 0.obs;
  final RxInt _homeIndex = 0.obs;
  final RxInt _savedPinsCount = 0.obs;
  final Rx<Plan> _selectedPlan = Plan.LIFETIME.obs;
  final RxList<PinModel> _savedPins = <PinModel>[].obs;
  final RxList<PinModel> _selectedPins = <PinModel>[].obs;
  final RxList<CollectionModel> _collections = <CollectionModel>[].obs;
  // Getters
  int get onboardingIndex => _onboardingIndex.value;
  int get homeIndex => _homeIndex.value;
  int get savedPinsCount => _savedPinsCount.value;
  Plan get selectedPlan => _selectedPlan.value;
  List<PinModel> get savedPins => _savedPins;
  List<PinModel> get selectedPins => _selectedPins;
  List<CollectionModel> get collections => _collections;

  // Setters
  set onboardingIndex(value) => _onboardingIndex.value = value;
  set homeIndex(value) => _homeIndex.value = value;
  set savedPinsCount(value) => _savedPinsCount.value = value;
  set selectedPlan(value) => _selectedPlan.value = value;
  set savedPins(value) => _savedPins.value = value;
  set selectedPins(value) => _selectedPins.value = value;
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

    LocalStorage.addData(collectionsCon, jsonString);
  }

  Future<void> addPin() async {
    savedPinsCount += 1;
    await LocalStorage.addData(savedPinsCountCon, savedPinsCount);

    final url = pinUrl.text.trim();
    final newPin = PinModel(imageUrl: url, isSelected: false);

    _savedPins.add(newPin);
    pinUrl.clear();
    await addPinsToLocal();
    NavigatorKey.pop();
  }

  Future<void> addPinsToLocal() async {
    String jsonString =
        jsonEncode(savedPins.map((model) => model.toJson()).toList());

    await LocalStorage.addData(savedPinsCon, jsonString);
  }

  Future<void> pasteText() async {
    ClipboardData? clipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null) {
      pinUrl.text = clipboardData.text ?? '';
    }
  }

  void selectPin(PinModel pin) {
    int index = savedPins.indexWhere((ele) => pin.imageUrl == ele.imageUrl);
    if (index != -1) {
      selectedPins.add(pin);
      savedPins[index] = pin.copyWith(isSelected: true);
    }
  }

  void removePin(PinModel pin) {
    int index = savedPins.indexWhere((ele) => pin.imageUrl == ele.imageUrl);
    if (index != -1) {
      savedPins[index] = pin.copyWith(isSelected: false);
      selectedPins.removeWhere((ele) => pin.imageUrl == ele.imageUrl);
    }
  }

  Future<void> addPinsToCollection(String collectionTag) async {
    final index = collections.indexWhere((ele) => ele.name == collectionTag);

    if (index != -1) {
      collections[index] = collections[index].copyWith(images: [
        ...collections[index].images,
        ...selectedPins.map((pin) => pin.imageUrl!)
      ]);
    }
    await addCollectionsToLocal();
    NavigatorKey.pop();
  }

  Future<void> deleteCollection(String collectionTag) async {
    collections.removeWhere((ele) => ele.name == collectionTag);
    await addCollectionsToLocal();

    NavigatorKey.pop();
  }

  void resetSelectedPins() {
    selectedPins.clear();
    savedPins =
        savedPins.map((ele) => ele.copyWith(isSelected: false)).toList();
  }
}
