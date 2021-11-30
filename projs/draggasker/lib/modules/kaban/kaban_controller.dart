import 'package:draggasker/globals.dart';
import 'package:draggasker/helpers/map_helpers.dart';
import 'package:draggasker/modules/kaban/kaban_model.dart';
import 'package:flutter/foundation.dart';

class KabanController extends ChangeNotifier {
  String description = "";

  String statusFrom = "";

  get getStatusFrom => statusFrom;

  set setStatusFrom(String newValue) {
    statusFrom = newValue;
    notifyListeners();
  }

  String statusTo = "";

  get getStatusTo => statusTo;

  set setStatusTo(String newValue) {
    statusTo = newValue;
    notifyListeners();
  }

  set setDescription(String newValue) {
    description = newValue;
    notifyListeners();
  }

  int qtdStatus = 0;

  void incrementQtdeStatus() {
    ++qtdStatus;
    notifyListeners();
  }

  List<String> actions = ["Remove", "Edit"];

  Map<String, dynamic> allTasks = {};

  KabanController() {
    // bootstrapTasks();
  }

  void addAction(String action) {
    actions.add(action);

    notifyListeners();
  }

  List<String> keysToList() => allTasks.keys.toList();

  List<MapEntry<String, dynamic>> mapTasksToList() => allTasks.entries.toList();

  List listOfStatus(String keyMap) => allTasks[keyMap] ?? [];

  void addTasksInFirstStatus() {
    var firstStatusKey = allTasks.entries.first.key.toLowerCase().trim();

    var list = allTasks[firstStatusKey] as List;
    list.add(description);

    notifyListeners();
  }

  void addNewStatus() {
    MapHelper.addItemToMap(allTasks, description, []);
    actions.add("$actionWordStart to $description");

    notifyListeners();
  }

  void bootstrapTasks() {
    var statesTaskList = <String>[
      "start",
      "undone",
      "done",
    ];

    for (var state in statesTaskList) {
      var map = <String, dynamic>{};
      // map[state] = List<String>.generate(3, (int index) => "$index");
      // map[state] = List<String>.generate(50, (int index) => getRandomString(5));
      map[state] = [];
      allTasks.addAll(map);
    }

    for (var element in statesTaskList) {
      actions.add("$actionWordStart to $element");
    }

    notifyListeners();
  }

  void moveStausToAnother(
    String oldStatus,
    String newStatus,
    int index,
  ) {
    var oldList = allTasks[oldStatus] as List;
    var itemOldListToAdd = oldList[index];

    var newList = allTasks[newStatus] as List;

    newList.add(itemOldListToAdd);

    removeListItemByStatus(oldStatus, index);

    notifyListeners();
  }

  void removeListItemByStatus(
    String status,
    int index,
  ) {
    listOfStatus(status).removeAt(index);

    notifyListeners();
  }

  void editItem(String titleList, int index) {
    listOfStatus(titleList)[index] = description;

    notifyListeners();
  }

  void addItemToList(Object data, String titleList) {
    listOfStatus(titleList).add(data.toString());

    notifyListeners();
  }

  List<KabanModel> listOfKabanStatus() {
    var list = mapTasksToList();
    var titles = keysToList();

    var result = list.map((element) {
      var index = list.indexOf(element);
      var headerTitle = titles.elementAt(index);
      var listOfKey = listOfStatus(headerTitle);

      return KabanModel(
        headerTitle: headerTitle,
        sizeStatusList: listOfKey.length,
      );
    }).toList();

    return result;
  }

  void reorderList(String titleList, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    var _list = listOfStatus(titleList);
    final item = _list.removeAt(oldIndex);
    _list.insert(newIndex, item);

    notifyListeners();
  }

  void clearAll() {
    allTasks.clear();
    notifyListeners();
  }
}
