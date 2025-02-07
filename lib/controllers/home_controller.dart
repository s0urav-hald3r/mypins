// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:mypins/config/constants.dart';
import 'package:mypins/models/collection_model.dart';
import 'package:mypins/models/pin_model.dart';
import 'package:mypins/services/dio_client.dart';
import 'package:mypins/services/local_storage.dart';
import 'package:mypins/services/navigator_key.dart';
import 'package:mypins/services/overlay_loader.dart';
import 'package:mypins/utils/overlay_msg_loader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

enum Plan { WEEKLY, MONTHLY, LIFETIME }

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final _dioClient = DioClient();

  final pageController = PageController();

  final pinUrl = TextEditingController();
  final rename = TextEditingController();
  final createCollection = TextEditingController();
  final requestFeature = TextEditingController();

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
  final RxList<PinModel> _localSavedPins = <PinModel>[].obs;
  final RxList<PinModel> _selectedPins = <PinModel>[].obs;
  final RxList<CollectionModel> _collections = <CollectionModel>[].obs;
  final RxList<CollectionModel> _localCollections = <CollectionModel>[].obs;
  // Getters
  int get onboardingIndex => _onboardingIndex.value;
  int get homeIndex => _homeIndex.value;
  int get savedPinsCount => _savedPinsCount.value;
  Plan get selectedPlan => _selectedPlan.value;
  List<PinModel> get savedPins => _savedPins;
  List<PinModel> get localSavedPins => _localSavedPins;
  List<PinModel> get selectedPins => _selectedPins;
  List<CollectionModel> get collections => _collections;
  List<CollectionModel> get localCollections => _localCollections;

  // Setters
  set onboardingIndex(value) => _onboardingIndex.value = value;
  set homeIndex(value) => _homeIndex.value = value;
  set savedPinsCount(value) => _savedPinsCount.value = value;
  set selectedPlan(value) => _selectedPlan.value = value;
  set savedPins(value) => _savedPins.value = value;
  set localSavedPins(value) => _localSavedPins.value = value;
  set selectedPins(value) => _selectedPins.value = value;
  set collections(value) => _collections.value = value;
  set localCollections(value) => _localCollections.value = value;

  Future<void> createCollectionModel() async {
    final name = createCollection.text.trim();
    final newCollection = CollectionModel(name: name, pins: []);

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
    OverlayLoader.show();
    try {
      final url = pinUrl.text.trim();
      final response = await getPinImageUrl(url);
      final newPin = PinModel(
        title: response['title'],
        description: response['description'],
        imageUrl: response['imageUrl'],
        pinterestLink: url,
        isSelected: false,
        userName: response['userName'],
        userFullName: response['userFullName'],
        userImage: response['userImage'],
        isPinned: false,
      );

      _savedPins.add(newPin);
      pinUrl.clear();

      OverlayLoader.hide();
      savedPinsCount += 1;
      await LocalStorage.addData(savedPinsCountCon, savedPinsCount);
      await addPinsToLocal();
      NavigatorKey.pop();
    } catch (e) {
      pinUrl.clear();
      OverlayLoader.hide();
      NavigatorKey.pop();

      await Future.delayed(const Duration(milliseconds: 250));
      OverlayMsgLoader.show('Only Pinterest Link is supported at this time.');
      Future.delayed(const Duration(milliseconds: 2000), () {
        OverlayMsgLoader.hide();
      });
    }
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
      int sIn = selectedPins.indexWhere((ele) => pin.imageUrl == ele.imageUrl);
      if (sIn == -1) {
        selectedPins.add(pin);
        savedPins[index] = pin.copyWith(isSelected: true);
      }
    }
  }

  void removePin(PinModel pin) {
    int index = savedPins.indexWhere((ele) => pin.imageUrl == ele.imageUrl);
    if (index != -1) {
      savedPins[index] = pin.copyWith(isSelected: false);
      selectedPins.removeWhere((ele) => pin.imageUrl == ele.imageUrl);
    }
  }

  Future<void> addPinsToCollection(String collectionTag,
      {PinModel? pin}) async {
    final index = collections.indexWhere((ele) => ele.name == collectionTag);

    if (index != -1) {
      if (pin != null) {
        collections[index] = collections[index]
            .copyWith(pins: [...collections[index].pins, pin]);
      } else {
        collections[index] = collections[index]
            .copyWith(pins: [...collections[index].pins, ...selectedPins]);
      }
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

  Future<void> unSavePin(PinModel pin, String? route) async {
    if (route == null) {
      savedPins.removeWhere((ele) => ele.imageUrl == pin.imageUrl);

      await addPinsToLocal();
      NavigatorKey.pop();
      return;
    }

    if (route == '/pins') {
      savedPins.removeWhere((ele) => ele.imageUrl == pin.imageUrl);

      await addPinsToLocal();
      NavigatorKey.pop();
      return;
    }

    int cIndex = collections.indexWhere((c) => c.name == route);
    if (cIndex != -1) {
      collections[cIndex].pins.removeWhere((p) => p.imageUrl == pin.imageUrl);
    }

    localCollections = collections;

    await addCollectionsToLocal();
    NavigatorKey.pop();
  }

  Future<Map> getPinImageUrl(String pinLink) async {
    try {
      final url = FlutterConfig.get('RAPID_API_URL');
      const path = '/api/pins';

      final response = await _dioClient.get('$url$path?url=$pinLink');

      String? title = response.data['title'];
      String? description = response.data['description'];
      String? imageUrl = response.data['thumbnails']['orig']['url'];

      String? userName = response.data['pinner']['username'];
      String? userFullName = response.data['pinner']['full_name'];
      String? userImage = response.data['pinner']['image_medium_url'];

      return {
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'userName': userName,
        'userFullName': userFullName,
        'userImage': userImage,
      };
    } on DioException catch (e) {
      debugPrint('DioException Error: $e');
      rethrow;
    } catch (e) {
      debugPrint('Unknown Error: $e');
      rethrow;
    }
  }

  void renamePin(PinModel pin) async {
    final newName = rename.text.trim();

    int index = savedPins.indexWhere((ele) => ele.imageUrl == pin.imageUrl);
    if (index != -1) {
      savedPins[index] = savedPins[index].copyWith(title: newName);
    }

    for (var ele in collections) {
      int index = ele.pins.indexWhere((t) => t.imageUrl == pin.imageUrl);

      if (index != -1) {
        ele.pins[index] = ele.pins[index].copyWith(title: newName);
      }
    }

    rename.clear();
    await addPinsToLocal();
    await addCollectionsToLocal();
    NavigatorKey.pop();
  }

  Future<void> shareImage(PinModel pin) async {
    final tempDir = await getTemporaryDirectory();
    OverlayLoader.show();

    try {
      final response = await _dioClient.download(
          pin.imageUrl!, '${tempDir.path}/${pin.title}.jpg');
      if (response.statusCode == 200) {
        final file = File('${tempDir.path}/${pin.title}.jpg');

        OverlayLoader.hide();
        Share.shareXFiles([XFile(file.path)]);
      } else {
        throw Exception('Failed to load image');
      }
    } on DioException catch (e) {
      OverlayLoader.hide();
      debugPrint('DioException Error: $e');
    } catch (e) {
      OverlayLoader.hide();
      debugPrint('Unknown Error: $e');
    }
  }

  void togglePinStatus(PinModel pin, String route) async {
    if (route == '/pins') {
      int index = savedPins.indexWhere((ele) => ele.imageUrl == pin.imageUrl);
      if (index != -1) {
        savedPins[index] = savedPins[index]
            .copyWith(isPinned: !(savedPins[index].isPinned ?? false));
      }

      await addPinsToLocal();
      return;
    }

    int cIndex = collections.indexWhere((c) => c.name == route);
    if (cIndex != -1) {
      int pIndex = collections[cIndex]
          .pins
          .indexWhere((t) => t.imageUrl == pin.imageUrl);

      if (pIndex != -1) {
        collections[cIndex].pins[pIndex] = collections[cIndex]
            .pins[pIndex]
            .copyWith(
                isPinned:
                    !(collections[cIndex].pins[pIndex].isPinned ?? false));
      }
    }

    await addCollectionsToLocal();
  }

  void sendMailForRequestFeature() async {
    String featureDescription = requestFeature.text;

    final Uri params = Uri(
      scheme: 'mailto',
      path: supportMail,
      query: 'subject=Request for a new Feature&body=$featureDescription',
    );

    try {
      if (!await launchUrl(params, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $params');
      }

      requestFeature.clear();
      NavigatorKey.pop();
    } catch (e) {
      debugPrint('error while launching url: $e');
    }
  }
}
