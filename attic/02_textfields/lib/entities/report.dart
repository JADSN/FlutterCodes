import 'package:http/http.dart' as http;
import 'dart:convert';

class Report {
  Report({
    this.id,
    required this.name,
    required this.publications,
    required this.videos,
    required this.hours,
    required this.revisits,
    required this.studyBibles,
    this.observations,
  });

  int? id;
  String name;
  int publications;
  int videos;
  int hours;
  int revisits;
  int studyBibles;
  String? observations;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "name": name,
        "publications": publications,
        "videos": videos,
        "hours": hours,
        "revisits": revisits,
        "studyBibles": studyBibles,
        "observations": observations,
      };

  // ignore: todo
  // TODO: Mudar para Report, se funcionar.
  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        name: json["name"],
        publications: json["publications"],
        videos: json["videos"],
        hours: json["hours"],
        revisits: json["revisits"],
        studyBibles: json["studyBibles"],
        observations: json["observations"],
      );

  @override
  String toString() {
    return '''Report {
      id: $id,
      name: $name, 
      publications: $publications, 
      videos: $videos, 
      hours: $hours, 
      revisits: $revisits,
      studyBibles: $studyBibles,
      observations: $observations
    }''';
  }
}

Future<List<Report>> fetchReports() async {
  final response = await http.get(Uri.parse('http://0.0.0.0:3000/reports'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Report.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load reports');
  }
}

Future<void> createOneReport(Report report) async {
  print("[REPORT" + report.toString());

  Report newReport = Report(
    name: report.name,
    publications: report.publications,
    videos: report.videos,
    hours: report.hours,
    revisits: report.revisits,
    studyBibles: report.studyBibles,
    observations: report.observations,
  );

  final Object objJson = newReport.toRawJson();

  final response = await http.post(
    Uri.parse(
      'http://0.0.0.0:3000/reports',
    ),
    headers: {'Content-type': 'application/json'},
    body: objJson,
  );

  if (response.statusCode == 201) {
    // print('CREATED');

    // return Report.fromJson(jsonDecode(response.body));
  } else {
    // print('Failed to create report');
    throw Exception('Failed to create report');
  }
}
