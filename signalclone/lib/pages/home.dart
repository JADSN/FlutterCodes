import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchUserInputText = '';

  final List<String> entries = <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //* TopBar
          Container(
            color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: const Text(
                      "File",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text(
                      "Edit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text(
                      "View",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text(
                      "Window",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    "Help",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // * Icon - SearchBar - Edit
                      Container(
                        color: Colors.blue,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Text('AZ'),
                            ),
                            Flexible(
                              child: TextField(
                                onChanged: (text) {
                                  print('SearcText $text');
                                },
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.purple,
                                    labelStyle: TextStyle(fontSize: 48)),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            const FloatingActionButton.small(
                              onPressed: null,
                              child: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                      //* List of users
                      Expanded(
                        child: Container(
                          color: Colors.blueGrey,
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              height: 20,
                            ),
                            padding: const EdgeInsets.all(8),
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Text('AZ'),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text("Name"),
                                          Text("Last Message"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Text("Today")
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //* Messages
                Expanded(
                  flex: 7,
                  child: Container(
                    color: Colors.red,
                    child: Column(
                      children: [
                        //* TopBar
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Text('AZ'),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("Name Current User"),
                                            Icon(Icons.account_circle_outlined),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.access_alarm),
                                            Text("Name Current User"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(Icons.video_call),
                                Icon(Icons.phone),
                                Icon(Icons.search),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),

                        //* Messages
                        Expanded(
                          flex: 8,
                          child: Container(
                            width: double.infinity,
                            color: Colors.greenAccent,
                            child: Text("asdf"),
                          ),
                        ),

                        //* BottomBar
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.face),
                                  Flexible(
                                    child: TextField(
                                      onChanged: (text) {
                                        print('SearcText $text');
                                      },
                                      decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.purple,
                                          labelStyle: TextStyle(fontSize: 48)),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  Icon(Icons.note_add),
                                  Icon(Icons.mic),
                                  Icon(Icons.add),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
