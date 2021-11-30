import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsc/entities/report.dart';
import 'package:rsc/extensions/intstd.dart';
import 'package:rsc/extensions/stringstd.dart';
import 'package:rsc/pages/thanks_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String nameReport = "";
  String qtdePublicationsReport = "";
  String qtdeVideosReport = "";
  String qtdeHoursReport = "";
  String qtdeRevisitsReport = "";
  String qtdeStudyBiblesReport = "";
  String observationsReport = "";

  bool showMsgSendAgain = false;
  String msgSendAgain = "Por favor envie o relatório novamente.";

  // * Controllers

  // * qtdePublications.
  final TextEditingController qtdePublicationsReportController =
      TextEditingController(text: "0");

  // * qtdeVideos.
  final TextEditingController qtdeVideosReportController =
      TextEditingController(text: "0");

  // * Input focus
  final _focusNodeQtdePublicacoes = FocusNode();
  final _focusNodeQtdeVideos = FocusNode();

  @override
  void initState() {
    qtdePublicationsReportController.addListener(() {
      qtdePublicationsReport = qtdePublicationsReportController.text;
    });

    qtdeVideosReportController.addListener(() {
      qtdeVideosReport = qtdeVideosReportController.text;
    });

    _focusNodeQtdePublicacoes.addListener(
      () {
        if (_focusNodeQtdePublicacoes.hasFocus == false) {
          if (qtdePublicationsReportController.text.isEmpty) {
            qtdePublicationsReportController.text = "0";
          }
        }
      },
    );

    _focusNodeQtdeVideos.addListener(
      () {
        if (_focusNodeQtdeVideos.hasFocus == false) {
          if (qtdeVideosReportController.text.isEmpty) {
            qtdeVideosReportController.text = "0";
          }
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    qtdePublicationsReportController.dispose();
    qtdeVideosReportController.dispose();

    _focusNodeQtdePublicacoes.dispose();
    _focusNodeQtdeVideos.dispose();
    super.dispose();
  }

  bool canSendReport() {
    return
        //* Validate name
        nameReport.isNotEmpty &&
            //* Validate publications
            qtdePublicationsReportController.text.isNotEmpty &&
            //* Validate videos
            qtdeVideosReportController.text.isNotEmpty &&
            //* Validate hours
            qtdeHoursReport.isNotEmpty &&
            //* Validate revisits
            qtdeRevisitsReport.isNotEmpty &&
            //* Validate Study Bibles
            qtdeStudyBiblesReport.isNotEmpty;
  }

  void _updateNameReport(String newValue) =>
      setState(() => {nameReport = newValue});

  int qtdePublicationsOldCursorPosition = 0;
  void _updateQtdePublicationsReport(String newValue) => setState(() => {
        qtdePublicationsOldCursorPosition =
            qtdePublicationsReportController.selection.base.offset,

        qtdePublicationsReportController.text = newValue.removeZerosFromStart(),

        // * Doesn't chanage cursor position to the beginning or end.
        if (qtdePublicationsReportController.text.length == 1)
          {
            qtdePublicationsReportController.selection =
                TextSelection.fromPosition(
              TextPosition(
                offset: qtdePublicationsReportController.text.length,
              ),
            )
          }
        else
          {
            qtdePublicationsReportController.selection =
                TextSelection.fromPosition(
              TextPosition(
                offset: qtdePublicationsOldCursorPosition,
              ),
            ),
          }
      });

  void _incrementQtdePublicationsReport() => setState(
        () => {
          if (qtdePublicationsReportController.text.isNotEmpty)
            {
              qtdePublicationsReportController.text =
                  (int.parse(qtdePublicationsReportController.text).plus(1))
                      .toString()
            }
        },
      );

  void _decrementQtdePublicationsReport() => setState(
        () => {
          if (qtdePublicationsReportController.text.isNotEmpty)
            {
              qtdePublicationsReportController.text =
                  (int.parse(qtdePublicationsReportController.text) - 1)
                      .toString()
            }
        },
      );

  int qtdeVideosOldCursorPosition = 0;
  void _updateQtdeVideosReport(String newValue) => setState(
        () => {
          qtdeVideosOldCursorPosition =
              qtdeVideosReportController.selection.base.offset,

          qtdeVideosReportController.text = newValue.removeZerosFromStart(),

          // * Doesn't chanage cursor position to the beginning or end.
          if (qtdeVideosReportController.text.length == 1)
            {
              qtdeVideosReportController.selection = TextSelection.fromPosition(
                TextPosition(
                  offset: qtdeVideosReportController.text.length,
                ),
              )
            }
          else
            {
              qtdeVideosReportController.selection = TextSelection.fromPosition(
                TextPosition(
                  offset: qtdeVideosOldCursorPosition,
                ),
              ),
            }
        },
      );

  void _incrementQtdeVideosReport() => setState(
        () => {
          if (qtdeVideosReportController.text.isNotEmpty)
            {
              qtdeVideosReportController.text =
                  (int.parse(qtdeVideosReportController.text).plus(1))
                      .toString()
            }
        },
      );

  void _decrementQtdeVideosReport() => setState(
        () => {
          if (qtdeVideosReportController.text.isNotEmpty)
            {
              qtdeVideosReportController.text =
                  (int.parse(qtdeVideosReportController.text) - 1).toString()
            }
        },
      );

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
                if (kDebugMode) {
                  print("[ERROR]" + error.toString());
                }

                setState(() {
                  showMsgSendAgain = !showMsgSendAgain;
                });
              }).then((_) => {
                    Future.delayed(const Duration(milliseconds: 3000), () {
                      setState(() {
                        showMsgSendAgain = !showMsgSendAgain;
                      });
                    })
                  })
            });
  }

  bool canDoAction(String inputText) {
    return (int.tryParse(inputText, radix: 10) != null &&
            (int.parse(inputText) > 0))
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // * Test for controllers.
            // Text(
            //   qtdePublicationsReport, // * Change this.
            //   style: TextStyle(
            //     color: Colors.red,
            //     fontSize: 48,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nome",
              ),
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Zçãáéíú\s]+'),
                ),
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (value) => _updateNameReport(value),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                FloatingActionButton.small(
                  child: const Icon(Icons.add),
                  heroTag: "IncrementPublications",
                  onPressed: _incrementQtdePublicationsReport,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Listener(
                    child: TextFormField(
                      controller: qtdePublicationsReportController,
                      focusNode: _focusNodeQtdePublicacoes,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Publicações",
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      // onTap: () => qtdePublicationsReportController.text = "0",
                      onChanged: (value) =>
                          _updateQtdePublicationsReport(value),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton.small(
                  child: const Icon(
                    Icons.remove,
                  ),
                  elevation: canDoAction(qtdePublicationsReportController.text)
                      ? 10
                      : 0,
                  backgroundColor:
                      canDoAction(qtdePublicationsReportController.text)
                          ? Colors.blue
                          : Colors.transparent,
                  heroTag: "DecrementPublications",
                  onPressed: canDoAction(qtdePublicationsReportController.text)
                      ? () => _decrementQtdePublicationsReport()
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                FloatingActionButton.small(
                  child: const Icon(Icons.add),
                  heroTag: "IncrementVideos",
                  onPressed: _incrementQtdeVideosReport,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: qtdeVideosReportController,
                    focusNode: _focusNodeQtdeVideos,
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
                ),
                const SizedBox(width: 10),
                FloatingActionButton.small(
                  child: const Icon(
                    Icons.remove,
                  ),
                  elevation:
                      canDoAction(qtdeVideosReportController.text) ? 10 : 0,
                  backgroundColor: canDoAction(qtdeVideosReportController.text)
                      ? Colors.blue
                      : Colors.transparent,
                  heroTag: "DecrementVideos",
                  onPressed: canDoAction(qtdeVideosReportController.text)
                      ? () => _decrementQtdeVideosReport()
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const FloatingActionButton.small(
                  child: Icon(Icons.add),
                  heroTag: "IncrementHours",
                  onPressed: null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
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
                ),
                const SizedBox(width: 10),
                const FloatingActionButton.small(
                  child: Icon(Icons.remove),
                  heroTag: "DecrementHours",
                  onPressed: null,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const FloatingActionButton.small(
                  child: Icon(Icons.add),
                  heroTag: "IncrementRevisits",
                  onPressed: null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
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
                ),
                const SizedBox(width: 10),
                const FloatingActionButton.small(
                  child: Icon(Icons.remove),
                  heroTag: "DecrementRevisits",
                  onPressed: null,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const FloatingActionButton.small(
                  child: Icon(Icons.add),
                  heroTag: "IncrementStudyBiles",
                  onPressed: null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
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
                ),
                const SizedBox(width: 10),
                const FloatingActionButton.small(
                  child: Icon(Icons.remove),
                  heroTag: "DecrementStudyBiles",
                  onPressed: null,
                ),
              ],
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
                  RegExp(r'[a-zA-Zçãáéíú\s]+'),
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
    );
  }
}
