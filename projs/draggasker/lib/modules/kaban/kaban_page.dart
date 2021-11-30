import 'package:draggasker/components/kaban/kaban_content.dart';
import 'package:draggasker/modules/kaban/kaban_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';

import 'package:draggasker/components/floating_button_component.dart';
import 'package:draggasker/components/kaban/kaban_header.dart';

import 'package:draggasker/modules/kaban/kaban_controller.dart';

class KabanPage extends StatefulWidget {
  const KabanPage({Key? key}) : super(key: key);

  @override
  State<KabanPage> createState() => _KabanPageState();
}

class _KabanPageState extends State<KabanPage> {
  List<Widget> generateTaskStatusList(BuildContext context) {
    var kabanController = context.read<KabanController>();

    var result =
        kabanController.listOfKabanStatus().map((KabanModel kabanModel) {
      return Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KabanHeader(
              title: kabanModel.headerTitle,
              totalItems: kabanModel.sizeStatusList,
            ),
            KabanContent(
              statusName: kabanModel.headerTitle,
            ),
          ],
        ),
      );

      // return KabanContent(
      //   statusName: kabanModel.headerTitle,
      // );
    }).toList();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var kabanController = context.watch<KabanController>();

    var entrypoint = Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // var heigth = constraints.maxHeight;
          var width = constraints.maxWidth;

          // debugPrint("heigth? $heigth");
          // debugPrint("width? $width");

          var hasStatusLists = kabanController.mapTasksToList().isEmpty;

          return hasStatusLists
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Add at least two statuses",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        child: const Text(
                          "FROM TEMPLATE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        onPressed: () => kabanController.bootstrapTasks(),
                      ),
                    ],
                  ),
                )
              : width <= 840
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      children: generateTaskStatusList(context),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      children: generateTaskStatusList(context),
                    );
        },
      ),
      floatingActionButton: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: kabanController.mapTasksToList().length >= 2,
              child: FloatingButtonComponent(
                titleDialog: 'Add new task',
                color: Colors.white,
                icon: const Icon(
                  Icons.plus_one,
                  color: Colors.black,
                ),
                onChanged: (value) {
                  kabanController.description = value;
                },
                onPressed: () {
                  kabanController.addTasksInFirstStatus();

                  Navigator.pop(context);
                },
              ),
            ),
            FloatingButtonComponent(
              titleDialog: 'Add new status',
              color: Colors.white,
              icon: const Icon(
                Icons.task,
                color: Colors.black,
              ),
              onChanged: (value) {
                kabanController.description = value;
              },
              onPressed: () {
                if (!kabanController
                    .keysToList()
                    .contains(kabanController.description)) {
                  kabanController.addNewStatus();

                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);

                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Take easy'),
                        content: Text(
                          'The status ${kabanController.description} already exists.',
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              elevation: 0,
                              side: const BorderSide(
                                color: Colors.blueAccent,
                                width: 2.0,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              "Ok",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            Visibility(
              visible: kabanController.mapTasksToList().length >= 2,
              child: FloatingActionButton.small(
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.black,
                ),
                onPressed: () => kabanController.clearAll(),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.transparent,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "v0.0.14",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
    return !kIsWeb
        ? SafeArea(
            child: entrypoint,
          )
        : entrypoint;
  }
}
