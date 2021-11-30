import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsc/entities/report.dart';
import 'package:rsc/pages/thanks.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime actualDate = DateTime.now();
  String previousMonth = "";

  String nameReport = "";
  String qtdePublicationsReport = "";
  String qtdeVideosReport = "";
  String qtdeHoursReport = "";
  String qtdeRevisitsReport = "";
  String qtdeStudyBiblesReport = "";
  String observationsReport = "";

  bool showMsgSendAgain = false;
  String msgSendAgain = "Por favor envie o relatório novamente.";

  bool canSendReport() {
    return
        //* Validate name
        nameReport.isNotEmpty &&
            //* Validate publications
            qtdePublicationsReport.toString().isNotEmpty &&
            //* Validate videos
            qtdeVideosReport.isNotEmpty &&
            //* Validate hours
            qtdeHoursReport.isNotEmpty &&
            //* Validate revisits
            qtdeRevisitsReport.isNotEmpty &&
            //* Validate Study Bibles
            qtdeStudyBiblesReport.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    DateTime newDate = DateTime(date.year, date.month - 1, date.day);
    // print("[NEW DATE]" + newDate.toIso8601String());
    switch (newDate.month) {
      case 1:
        previousMonth = "JANEIRO";
        break;
      case 2:
        previousMonth = "FEVEREIRO";
        break;
      case 3:
        previousMonth = "MARÇO";
        break;
      case 4:
        previousMonth = "ABRIL";
        break;
      case 5:
        previousMonth = "MAIO";
        break;
      case 6:
        previousMonth = "JUNHO";
        break;
      case 7:
        previousMonth = "JULHO";
        break;
      case 8:
        previousMonth = "AGOSTO";
        break;
      case 9:
        previousMonth = "SETEMBRO";
        break;
      case 10:
        previousMonth = "OUTUBRO";
        break;
      case 11:
        previousMonth = "NOVEMBRO";
        break;
      case 12:
        previousMonth = "DEZEMBRO";
        break;
      default:
        previousMonth = "ANOTHER";
        break;
    }
  }

  void _updateNameReport(String newValue) =>
      setState(() => nameReport = newValue);

  void _updateQtdePublicationsReport(String newValue) =>
      setState(() => qtdePublicationsReport = newValue);

  void _updateQtdeVideosReport(String newValue) =>
      setState(() => qtdeVideosReport = newValue);

  void _updateQtdeHoursReport(String newValue) =>
      setState(() => qtdeHoursReport = newValue);

  void _updateQtdeRevisitsReport(String newValue) =>
      setState(() => qtdeRevisitsReport = newValue);

  void _updateQtdeStudyBiblesReport(String newValue) =>
      setState(() => qtdeStudyBiblesReport = newValue);

  void _updateObservationsReport(String newValue) =>
      setState(() => observationsReport = newValue);

  void _sendReport() {
    Report newReport = Report(
      id: 0,
      name: nameReport,
      publications: int.parse(qtdePublicationsReport),
      videos: int.parse(qtdeVideosReport),
      hours: int.parse(qtdeHoursReport),
      revisits: int.parse(qtdeRevisitsReport),
      studyBibles: int.parse(qtdeStudyBiblesReport),
      observations: observationsReport,
    );
    createOneReport(newReport)
        .then(
          (_) => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ThanksPage()),
            )
          },
        )
        .catchError((error) => {
              Future.delayed(const Duration(milliseconds: 100), () {
                print("[ERROR]" + error.toString());
                setState(() {
                  showMsgSendAgain = true;
                });
              }).then((_) => {
                    Future.delayed(const Duration(milliseconds: 3000), () {
                      setState(() {
                        showMsgSendAgain = false;
                      });
                    })
                  })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "RELATÓRIO DE SERVIÇO DE CAMPO - $previousMonth",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome",
                ),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Zçãáéíóú\s]+'),
                  ),
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                onChanged: (value) => _updateNameReport(value),
              ),
              const SizedBox(height: 10),
              TextFormField(
                // initialValue: qtdePublicationsReport.toString(),
                // controller: TextEditingController(
                //     text: qtdePublicationsReport.toString()),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Publicações",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                onChanged: (value) => _updateQtdePublicationsReport(value),
              ),
              const SizedBox(height: 10),
              TextFormField(
                // initialValue: qtdeVideosReport.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Vídeos',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                onChanged: (value) => _updateQtdeVideosReport(value),
              ),
              const SizedBox(height: 10),
              TextFormField(
                // initialValue: qtdeHoursReport.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Horas',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                onChanged: (value) => _updateQtdeHoursReport(value),
              ),
              const SizedBox(height: 10),
              TextFormField(
                // initialValue: qtdeRevisitsReport.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Revisitas',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                onChanged: (value) => _updateQtdeRevisitsReport(value),
              ),
              const SizedBox(height: 10),
              TextFormField(
                // initialValue: qtdeStudyBiblesReport.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Estudos Bíblicos',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                onChanged: (value) => _updateQtdeStudyBiblesReport(value),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Observações',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Zçãáéíóú\s]+'),
                  ),
                ],
                onChanged: (value) => _updateObservationsReport(value),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: canSendReport(),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.yellow[900],
                    backgroundColor: Colors.yellow[400],
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _sendReport,
                  child: const Text('Enviar Relatório'),
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: showMsgSendAgain,
                child: Text(
                  msgSendAgain,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
