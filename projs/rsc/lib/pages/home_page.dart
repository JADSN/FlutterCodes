import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsc/extensions/intstd.dart';
import 'package:rsc/extensions/stringstd.dart';
import 'package:rsc/models/report.dart';
import 'package:rsc/pages/thanks_page.dart';

//* Theme
import '../report_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // * Themes
  final reportTheme = ReportTheme.light();

  // * ===================
  // * Controllers - START
  // * ===================

  // * name input.
  final TextEditingController _nameTextEditingController =
      TextEditingController(text: "");

  // * observations input
  final TextEditingController _observationsTextEditingController =
      TextEditingController(text: null);

  // * Publications.
  final TextEditingController qtdePublicationsReportController =
      TextEditingController(text: "0");

  // * Videos.
  final TextEditingController qtdeVideosReportController =
      TextEditingController(text: "0");

  // * Hours.
  final TextEditingController qtdeHoursReportController =
      TextEditingController(text: "0");

  // * Revisits.
  final TextEditingController qtdeRevisitsReportController =
      TextEditingController(text: "0");

  // * Study Bibles.
  final TextEditingController qtdeStudyBiblesReportController =
      TextEditingController(text: "0");

  // * ===================
  // * Controllers - END
  // * ===================

  // * ===================
  // * FOCUS INPUT- START
  // * ===================

  // * Name
  final _focusNodeNameInputReport = FocusNode();

  // * Publications
  final _focusNodeQtdePublicacoesReport = FocusNode();

  // * Videos
  final _focusNodeQtdeVideosReport = FocusNode();

  // * Hours
  final _focusNodeQtdeHoursReport = FocusNode();

  // * Hours
  final _focusNodeQtdeRevisitsReport = FocusNode();

  // * Hours
  final _focusNodeQtdeStudyBiblesReport = FocusNode();
  // * ===================
  // * FOCUS INPUT- END
  // * ===================

  DateTime date = DateTime.now();
  String previousMonth = "";

  String qtdePublicationsReport = "";
  String qtdeVideosReport = "";
  String qtdeHours = "";
  String qtdeRevisits = "";
  String qtdeStudyBibles = "";

  @override
  void initState() {
    // * Report title.
    DateTime newDate = DateTime(date.year, date.month.subtract(1), date.day);
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

    // * ===================================
    // * Controllers implementations - START
    // * ===================================

    // * Publications
    qtdePublicationsReportController.addListener(() {
      qtdePublicationsReport = qtdePublicationsReportController.text;
    });

    // * Videos
    qtdeVideosReportController.addListener(() {
      qtdeVideosReport = qtdeVideosReportController.text;
    });

    // * Hours
    qtdeHoursReportController.addListener(() {
      qtdeHours = qtdeHoursReportController.text;
    });

    // * Revisits
    qtdeRevisitsReportController.addListener(() {
      qtdeRevisits = qtdeRevisitsReportController.text;
    });

    // * Study Bibles
    qtdeStudyBiblesReportController.addListener(() {
      qtdeStudyBibles = qtdeStudyBiblesReportController.text;
    });

    // * ===================================
    // * Controllers implementations - END
    // * ===================================

    // * ===================================
    // *  FOCUS - START
    // * ===================================

    // * Publications
    _focusNodeNameInputReport.addListener(
      () {
        print(_focusNodeNameInputReport.hasFocus);
        if (!_focusNodeNameInputReport.hasFocus &&
            _nameTextEditingController.text.isEmpty) {
          _focusNodeNameInputReport.requestFocus();
        }
      },
    );

    // * Publications
    _focusNodeQtdePublicacoesReport.addListener(
      () {
        if (_focusNodeQtdePublicacoesReport.hasFocus == false) {
          if (qtdePublicationsReportController.text.isEmpty) {
            qtdePublicationsReportController.text = "0";
            _focusNodeQtdePublicacoesReport.unfocus();
          }
        }
      },
    );

    // * Videos
    _focusNodeQtdeVideosReport.addListener(
      () {
        if (_focusNodeQtdeVideosReport.hasFocus == false) {
          if (qtdeVideosReportController.text.isEmpty) {
            qtdeVideosReportController.text = "0";
            _focusNodeQtdeVideosReport.unfocus();
          }
        }
      },
    );

    // * Hours
    _focusNodeQtdeHoursReport.addListener(
      () {
        if (_focusNodeQtdeHoursReport.hasFocus == false) {
          if (qtdeHoursReportController.text.isEmpty) {
            qtdeHoursReportController.text = "0";
            _focusNodeQtdeHoursReport.unfocus();
          }
        }
      },
    );

    // * Revisits
    _focusNodeQtdeRevisitsReport.addListener(
      () {
        if (_focusNodeQtdeRevisitsReport.hasFocus == false) {
          if (qtdeRevisitsReportController.text.isEmpty) {
            qtdeRevisitsReportController.text = "0";
            _focusNodeQtdeRevisitsReport.unfocus();
          }
        }
      },
    );

    // * Study Bibles
    _focusNodeQtdeStudyBiblesReport.addListener(
      () {
        if (_focusNodeQtdeStudyBiblesReport.hasFocus == false) {
          if (qtdeStudyBiblesReportController.text.isEmpty) {
            qtdeStudyBiblesReportController.text = "0";
            _focusNodeQtdeStudyBiblesReport.unfocus();
          }
        }
      },
    );

    // * ===================================
    // *  FOCUS - END
    // * ===================================

    super.initState();
  }

  @override
  void dispose() {
    //* Name input
    _nameTextEditingController.dispose();

    //* Observations input
    _observationsTextEditingController.dispose();

    //* Publications input
    _focusNodeQtdePublicacoesReport.dispose();

    //* Videos input
    _focusNodeQtdeVideosReport.dispose();

    //* Revisits input
    _focusNodeQtdeRevisitsReport.dispose();

    //* Study Bibles input
    _focusNodeQtdeStudyBiblesReport.dispose();

    super.dispose();
  }

  // * ===================================
  // * HELPERS - START
  // * ===================================
  bool canDecrement(int number) {
    return (number > 0) ? true : false;
  }

  // * Disables the user, decrements counters when is igual to zero.
  bool canDoAction(String inputText) {
    return (int.tryParse(inputText, radix: 10) != null &&
            (int.parse(inputText) > 0))
        ? true
        : false;
  }

  // * ===================================
  // * HELPERS - END
  // * ===================================

  // * ===================================
  // * ACTIONS - START
  // * ===================================

  // * Name input
  int nameOldCursorPosition = 0;
  void _updateNameReport(String newValue) => setState(
        () => {
          nameOldCursorPosition =
              _nameTextEditingController.selection.base.offset,

          _nameTextEditingController.text = newValue,

          // * Doesn't chanage cursor position to the beginning or end.
          _nameTextEditingController.text.length == 1
              ? _nameTextEditingController.selection =
                  TextSelection.fromPosition(
                  TextPosition(
                    offset: _nameTextEditingController.text.length,
                  ),
                )
              : _nameTextEditingController.selection =
                  TextSelection.fromPosition(
                  TextPosition(
                    offset: nameOldCursorPosition,
                  ),
                ),
        },
      );

  // * Publications input.
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

  void _incrementQtdePulicationsReport() => setState(
        () {
          if (qtdePublicationsReportController.text.isNotEmpty) {
            qtdePublicationsReportController.text =
                (int.parse(qtdePublicationsReportController.text).plus(1))
                    .toString();
          }
        },
      );

  void _decrementQtdePulicationsReport() => setState(
        () {
          if (qtdePublicationsReportController.text.isNotEmpty) {
            qtdePublicationsReportController.text =
                (int.parse(qtdePublicationsReportController.text).subtract(1))
                    .toString();
          }
        },
      );

  // * Videos input.
  int qtdeVideosOldCursorPosition = 0;
  void _updateQtdeVideosReport(String newValue) => setState(() => {
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
      });

  void _incrementQtdeVideosReport() => setState(
        () {
          if (qtdeVideosReportController.text.isNotEmpty) {
            qtdeVideosReportController.text =
                (int.parse(qtdeVideosReportController.text).plus(1)).toString();
          }
        },
      );

  void _decrementQtdeVideosReport() => setState(
        () {
          if (qtdeVideosReportController.text.isNotEmpty) {
            qtdeVideosReportController.text =
                (int.parse(qtdeVideosReportController.text).subtract(1))
                    .toString();
          }
        },
      );

  // * Hours input.
  int qtdeHoursOldCursorPosition = 0;
  void _updateQtdeHoursReport(String newValue) => setState(() => {
        qtdeHoursOldCursorPosition =
            qtdeHoursReportController.selection.base.offset,

        qtdeHoursReportController.text = newValue.removeZerosFromStart(),

        // * Doesn't chanage cursor position to the beginning or end.
        if (qtdeHoursReportController.text.length == 1)
          {
            qtdeHoursReportController.selection = TextSelection.fromPosition(
              TextPosition(
                offset: qtdeHoursReportController.text.length,
              ),
            )
          }
        else
          {
            qtdeHoursReportController.selection = TextSelection.fromPosition(
              TextPosition(
                offset: qtdeHoursOldCursorPosition,
              ),
            ),
          }
      });

  void _incrementQtdeHoursReport() => setState(
        () {
          if (qtdeHoursReportController.text.isNotEmpty) {
            qtdeHoursReportController.text =
                (int.parse(qtdeHoursReportController.text).plus(1)).toString();
          }
        },
      );

  void _decrementQtdeHoursReport() => setState(
        () {
          if (qtdeHoursReportController.text.isNotEmpty) {
            qtdeHoursReportController.text =
                (int.parse(qtdeHoursReportController.text).subtract(1))
                    .toString();
          }
        },
      );

  // * Revisits input.
  int qtdeRevisitsOldCursorPosition = 0;
  void _updateQtdeRevisitsReport(String newValue) => setState(() => {
        qtdeRevisitsOldCursorPosition =
            qtdeRevisitsReportController.selection.base.offset,

        qtdeRevisitsReportController.text = newValue.removeZerosFromStart(),

        // * Doesn't chanage cursor position to the beginning or end.
        if (qtdeRevisitsReportController.text.length == 1)
          {
            qtdeRevisitsReportController.selection = TextSelection.fromPosition(
              TextPosition(
                offset: qtdeRevisitsReportController.text.length,
              ),
            )
          }
        else
          {
            qtdeRevisitsReportController.selection = TextSelection.fromPosition(
              TextPosition(
                offset: qtdeRevisitsOldCursorPosition,
              ),
            ),
          }
      });

  void _incrementQtdeRevisitsReport() => setState(
        () {
          if (qtdeRevisitsReportController.text.isNotEmpty) {
            qtdeRevisitsReportController.text =
                (int.parse(qtdeRevisitsReportController.text).plus(1))
                    .toString();
          }
        },
      );

  void _decrementQtdeRevisitsReport() => setState(
        () {
          if (qtdeRevisitsReportController.text.isNotEmpty) {
            qtdeRevisitsReportController.text =
                (int.parse(qtdeRevisitsReportController.text).subtract(1))
                    .toString();
          }
        },
      );

  // * Study Bibles input.
  int qtdeStudyBiblesOldCursorPosition = 0;
  void _updateQtdeStudyBiblesReport(String newValue) => setState(() => {
        qtdeStudyBiblesOldCursorPosition =
            qtdeStudyBiblesReportController.selection.base.offset,

        qtdeStudyBiblesReportController.text = newValue.removeZerosFromStart(),

        // * Doesn't chanage cursor position to the beginning or end.
        if (qtdeStudyBiblesReportController.text.length == 1)
          {
            qtdeStudyBiblesReportController.selection =
                TextSelection.fromPosition(
              TextPosition(
                offset: qtdeStudyBiblesReportController.text.length,
              ),
            )
          }
        else
          {
            qtdeStudyBiblesReportController.selection =
                TextSelection.fromPosition(
              TextPosition(
                offset: qtdeStudyBiblesOldCursorPosition,
              ),
            ),
          }
      });

  void _incrementQtdeStudyBiblesReport() => setState(
        () {
          if (qtdeStudyBiblesReportController.text.isNotEmpty) {
            qtdeStudyBiblesReportController.text =
                (int.parse(qtdeStudyBiblesReportController.text).plus(1))
                    .toString();
          }
        },
      );

  void _decrementQtdeStudyBiblesReport() => setState(
        () {
          if (qtdeStudyBiblesReportController.text.isNotEmpty) {
            qtdeStudyBiblesReportController.text =
                (int.parse(qtdeStudyBiblesReportController.text).subtract(1))
                    .toString();
          }
        },
      );

  // * ===================================
  // * ACTIONS - END
  // * ===================================

  bool _canSendReport() {
    return int.parse(qtdeHoursReportController.text) > 0 &&
        _nameTextEditingController.text.isNotEmpty;
  }

  int observationsOldCursorPosition = 0;
  void _updateObservationsReport(String newValue) => setState(
        () => {
          observationsOldCursorPosition =
              _observationsTextEditingController.selection.base.offset,

          _observationsTextEditingController.text = newValue,

          // * Doesn't chanage cursor position to the beginning or end.
          _observationsTextEditingController.text.length == 1
              ? _observationsTextEditingController.selection =
                  TextSelection.fromPosition(
                  TextPosition(
                    offset: _observationsTextEditingController.text.length,
                  ),
                )
              : _observationsTextEditingController.selection =
                  TextSelection.fromPosition(
                  TextPosition(
                    offset: observationsOldCursorPosition,
                  ),
                ),
        },
      );

  bool showMsgSendAgain = false;
  void _sendReport() {
    // if (_nameTextEditingController.text.isEmpty) {
    //   _nameTextEditingController.focus();
    // } else {
    Report newReport = Report(
      name: _nameTextEditingController.text,
      publications: int.parse(qtdePublicationsReportController.text),
      videos: int.parse(qtdeVideosReportController.text),
      hours: int.parse(qtdeHoursReportController.text),
      revisits: int.parse(qtdeRevisitsReportController.text),
      studyBibles: int.parse(qtdeStudyBiblesReportController.text),
      observations: _observationsTextEditingController.text,
    );
    createOneReport(newReport)
        .then(
          (_) => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ThanksPage(),
              ),
            ),
          },
        )
        .catchError(
          (error) => {
            Future.delayed(
              const Duration(milliseconds: 100),
              () {
                if (kDebugMode) {
                  print("[ERROR]" + error.toString());
                }

                setState(
                  () {
                    showMsgSendAgain = !showMsgSendAgain;
                  },
                );
              },
            ).then(
              (_) => {
                Future.delayed(
                  const Duration(milliseconds: 3000),
                  () {
                    setState(
                      () {
                        showMsgSendAgain = !showMsgSendAgain;
                      },
                    );
                  },
                )
              },
            )
          },
        );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "RELATÓRIO DO MÊS DE ",
                  style: reportTheme.textTheme.headline3,
                ),
                Text(
                  "$previousMonth / ${date.year}",
                  style: reportTheme.textTheme.headline4,
                ),
              ],
            ),
            TextField(
              controller: _nameTextEditingController,
              focusNode: _focusNodeNameInputReport,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nome",
              ),
              keyboardType: TextInputType.text,
              inputFormatters: [
                // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\sçáéí]')),
                // FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (value) => _updateNameReport(value),
            ),
            // * Publications
            Row(
              children: [
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Publicações",
                      style: reportTheme.textTheme.bodyText1,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor:
                            canDoAction(qtdePublicationsReportController.text)
                                ? reportTheme
                                    .floatingActionButtonTheme.backgroundColor
                                : reportTheme.disabledColor,
                        heroTag: "DecrementQtdePublications",
                        child: const Icon(
                          Icons.remove,
                        ),
                        onPressed:
                            canDoAction(qtdePublicationsReportController.text)
                                ? _decrementQtdePulicationsReport
                                : null,
                      ),
                      // TextField(
                      //   "$qtdePublications",
                      //   style: reportTheme.textTheme.bodyText1,
                      // ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: qtdePublicationsReportController,
                            focusNode: _focusNodeQtdePublicacoesReport,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
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
                      FloatingActionButton(
                        heroTag: "IncrementQtdePublications",
                        child: const Icon(
                          Icons.add,
                        ),
                        onPressed: _incrementQtdePulicationsReport,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // * Videos
            Row(
              children: [
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Vídeos",
                      style: reportTheme.textTheme.bodyText1,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor:
                            canDoAction(qtdeVideosReportController.text)
                                ? reportTheme
                                    .floatingActionButtonTheme.backgroundColor
                                : reportTheme.disabledColor,
                        heroTag: "DecrementQtdeVideos",
                        child: const Icon(
                          Icons.remove,
                        ),
                        onPressed: canDoAction(qtdeVideosReportController.text)
                            ? _decrementQtdeVideosReport
                            : null,
                      ),
                      // Text(
                      //   "$qtdeVideos",
                      //   style: reportTheme.textTheme.bodyText1,
                      // ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: qtdeVideosReportController,
                            focusNode: _focusNodeQtdeVideosReport,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            onChanged: (value) =>
                                _updateQtdeVideosReport(value),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "IncrementQtdeVideos",
                        child: const Icon(
                          Icons.add,
                        ),
                        onPressed: _incrementQtdeVideosReport,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // * Hours
            Row(
              children: [
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Horas",
                      style: reportTheme.textTheme.bodyText1,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor:
                            canDoAction(qtdeHoursReportController.text)
                                ? reportTheme
                                    .floatingActionButtonTheme.backgroundColor
                                : reportTheme.disabledColor,
                        heroTag: "DecrementQtdeHours",
                        child: const Icon(
                          Icons.remove,
                        ),
                        onPressed: canDoAction(qtdeHoursReportController.text)
                            ? _decrementQtdeHoursReport
                            : null,
                      ),
                      // Text(
                      //   "$qtdeHours",
                      //   style: reportTheme.textTheme.bodyText1,
                      // ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: qtdeHoursReportController,
                            focusNode: _focusNodeQtdeHoursReport,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            onChanged: (value) => _updateQtdeHoursReport(value),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "IncrementQtdeHours",
                        child: const Icon(
                          Icons.add,
                        ),
                        onPressed: _incrementQtdeHoursReport,
                      )
                    ],
                  ),
                ),
              ],
            ),
            // * Revisits
            Row(
              children: [
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Revisitas",
                      style: reportTheme.textTheme.bodyText1,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor:
                            canDoAction(qtdeRevisitsReportController.text)
                                ? reportTheme
                                    .floatingActionButtonTheme.backgroundColor
                                : reportTheme.disabledColor,
                        heroTag: "DecrementQtdeRevisits",
                        child: const Icon(
                          Icons.remove,
                        ),
                        onPressed:
                            canDoAction(qtdeRevisitsReportController.text)
                                ? _decrementQtdeRevisitsReport
                                : null,
                      ),
                      // Text(
                      //   "$qtdeRevisits",
                      //   style: reportTheme.textTheme.bodyText1,
                      // ),

                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: qtdeRevisitsReportController,
                            focusNode: _focusNodeQtdeRevisitsReport,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            onChanged: (value) =>
                                _updateQtdeRevisitsReport(value),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "IncrementQtdeRevisits",
                        child: const Icon(
                          Icons.add,
                        ),
                        onPressed: _incrementQtdeRevisitsReport,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // * Study Bibles
            Row(
              children: [
                Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Estudos",
                      style: reportTheme.textTheme.bodyText1,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor:
                            canDoAction(qtdeStudyBiblesReportController.text)
                                ? reportTheme
                                    .floatingActionButtonTheme.backgroundColor
                                : reportTheme.disabledColor,
                        heroTag: "DecrementStudyBibles",
                        child: const Icon(
                          Icons.remove,
                        ),
                        onPressed:
                            canDoAction(qtdeStudyBiblesReportController.text)
                                ? _decrementQtdeStudyBiblesReport
                                : null,
                      ),
                      // Text(
                      //   "$qtdeStudyBibles",
                      //   style: reportTheme.textTheme.bodyText1,
                      // ),

                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: qtdeStudyBiblesReportController,
                            focusNode: _focusNodeQtdeStudyBiblesReport,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            onChanged: (value) =>
                                _updateQtdeRevisitsReport(value),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: "IncrementQtdeQtdeStudyBibles",
                        child: const Icon(
                          Icons.add,
                        ),
                        onPressed: _incrementQtdeStudyBiblesReport,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextField(
              controller: _observationsTextEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Obseravções",
              ),
              keyboardType: TextInputType.text,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              onChanged: (value) => _updateObservationsReport(value),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: _canSendReport()
                    ? reportTheme.primaryColor
                    : reportTheme.disabledColor,
                backgroundColor: _canSendReport()
                    ? reportTheme.primaryColor
                    : reportTheme.disabledColor,
                // textStyle: TextStyle(color: Colors.red),
                minimumSize: Size(
                  MediaQuery.of(context).size.width,
                  50,
                ),
              ),
              // onPressed: _canSendReport() ? _sendReport : null,
              onPressed: _sendReport,
              child: const Text(
                "ENVIAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
