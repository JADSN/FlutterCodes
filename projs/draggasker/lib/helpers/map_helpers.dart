class MapHelper {
  MapHelper._();

  static void addItemToMap(
    Map argMap,
    String keyName,
    dynamic value,
  ) {
    var auxMap = <String, dynamic>{};
    auxMap[keyName] = value;
    argMap.addAll(auxMap);
  }
}
