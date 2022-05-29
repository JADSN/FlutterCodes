// ignore_for_file: public_member_api_docs, sort_constructors_first
class FcInfoEntity {
  String congregationName;
  String cityName;
  String stateName;
  int indexMonth;
  int year;

  FcInfoEntity({
    required this.congregationName,
    required this.cityName,
    required this.stateName,
    required this.indexMonth,
    required this.year,
  });

  static FcInfoEntity stub() => FcInfoEntity(
        cityName: "",
        congregationName: "",
        stateName: "",
        indexMonth: 1,
        year: DateTime.now().year,
      );

  @override
  String toString() {
    return 'FcInfoEntity(congregationName: $congregationName, cityName: $cityName, stateName: $stateName, indexMonth: $indexMonth, year: $year)';
  }
}
