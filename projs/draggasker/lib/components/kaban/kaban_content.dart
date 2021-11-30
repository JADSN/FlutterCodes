import 'dart:io';

import 'package:draggasker/components/kaban/kaban_header.dart';
import 'package:draggasker/globals.dart';
import 'package:draggasker/modules/kaban/kaban_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KabanContent extends StatefulWidget {
  final String statusName;

  const KabanContent({
    Key? key,
    required this.statusName,
  }) : super(key: key);

  @override
  State<KabanContent> createState() => _KabanContentState();
}

class _KabanContentState extends State<KabanContent> {
  @override
  Widget build(BuildContext context) {
    var kabanController = context.watch<KabanController>();
    var statusList = kabanController.listOfStatus(widget.statusName);

    return Flexible(
      child: DragTarget(
        builder: (BuildContext context, List<Object?> candidateData,
            List<dynamic> rejectedData) {
          return SizedBox(
            child: statusList.isEmpty
                ? const Center(
                    child: Text(
                      "EMPTY LIST.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ReorderableListView.builder(
                    scrollDirection: Axis.vertical,
                    scrollController: ScrollController(keepScrollOffset: false),
                    buildDefaultDragHandles: false,

                    itemCount: statusList.length,
                    onReorder: (int oldIndex, int newIndex) => kabanController
                        .reorderList(widget.statusName, oldIndex, newIndex),
                    // header: KabanHeader(
                    //   title: widget.statusName,
                    //   totalItems: statusList.length,
                    // ),
                    itemBuilder: (context, index) {
                      //* Reverse the list.
                      // int reverseIndex = statusList.length - 1 - index;

                      return LongPressDraggable(
                        key: ValueKey("$index"),
                        maxSimultaneousDrags: 1,
                        data: statusList[index],
                        feedback: Card(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              statusList[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        child: ListTile(
                          key: ValueKey("$index"),
                          title: Text(statusList[index]),
                          tileColor: kIsWeb || Platform.isLinux
                              ? (index % 2 == 0)
                                  ? Colors.white
                                  : Colors.grey[200]
                              : Colors.white,

                          // tileColor: Colors.white,
                          leading: Chip(
                            backgroundColor: Colors.black,
                            useDeleteButtonTooltip: false,
                            label: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                child: DropdownButton<String>(
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.black,
                                  ),
                                  iconSize: 24,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.transparent,
                                  ),
                                  items: kabanController.actions
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      var newValue = value
                                          .split(" ")
                                          .last
                                          .trim()
                                          .toLowerCase();

                                      var isSameTaskStatus =
                                          widget.statusName == newValue;

                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Visibility(
                                          visible: !isSameTaskStatus,
                                          replacement: Text(
                                            value,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          ),
                                          child: Text(value),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? newValue) {
                                    var newValueNormalized =
                                        newValue ?? ".....";

                                    var newValueLastWord = newValueNormalized
                                        .split(" ")
                                        .last
                                        .trim()
                                        .toLowerCase();

                                    debugPrint(
                                        "widget.statusName: ${widget.statusName}");

                                    if (newValueNormalized
                                        .startsWith(actionWordStart)) {
                                      kabanController.moveStausToAnother(
                                          widget.statusName,
                                          newValueLastWord,
                                          index);
                                    }

                                    if (newValueLastWord == "remove") {
                                      debugPrint(
                                          "widget.statusName: ${widget.statusName}");
                                      kabanController.removeListItemByStatus(
                                          widget.statusName, index);
                                    }

                                    if (newValueLastWord == "edit") {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Edit task"),
                                            content: TextField(
                                              onChanged: (newValue) {
                                                kabanController.setDescription =
                                                    newValue;
                                              },
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  elevation: 0,
                                                  side: const BorderSide(
                                                    color: Colors.redAccent,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  elevation: 0,
                                                  side: const BorderSide(
                                                    color: Colors.blueAccent,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  kabanController.editItem(
                                                    widget.statusName,
                                                    index,
                                                  );

                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                    color: Colors.blueAccent,
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
                              ),
                              Visibility(
                                visible: statusList.length >= 2,
                                child: ReorderableDragStartListener(
                                  index: index,
                                  child: const Icon(
                                    Icons.anchor,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // onDragEnd: (details) {},
                        onDragStarted: () {
                          kabanController.setStatusFrom = widget.statusName;
                        },
                        onDragCompleted: () {
                          // debugPrint("onDragCompleted");
                          // debugPrint(
                          //     "onDragCompleted ->  widget.statusName: ${kabanController.getStatusFrom}");

                          kabanController.setStatusFrom = widget.statusName;

                          if (kabanController.getStatusFrom !=
                              kabanController.getStatusTo) {
                            kabanController.removeListItemByStatus(
                                widget.statusName, index);
                          }
                        },
                      );
                    },
                  ),
          );
        },
        // onMove: (data) {},
        // onLeave: (data) {},
        onAccept: (data) {
          // debugPrint("onAccept widget.statusName: ${widget.statusName}");

          kabanController.setStatusTo = widget.statusName;

          if (kabanController.getStatusFrom != kabanController.getStatusTo) {
            kabanController.addItemToList(data!, widget.statusName);
          }
        },
      ),
    );
  }
}
