import 'package:flutter/material.dart';
import 'package:tenforone/src/pages/arguments/client_arguments.dart';

class ListOfClientsPage extends StatefulWidget {
  // final String itemName;

  const ListOfClientsPage({Key? key}) : super(key: key);

  @override
  State<ListOfClientsPage> createState() => _ListOfClientsPageState();
}

class _ListOfClientsPageState extends State<ListOfClientsPage> {
  var items = List<String>.generate(10, (int index) => 'Item $index');

  var qtdeClientStamps = 10;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/client-detail',
                    arguments: ClientArguments(itemName: items[index]));
              },
              child: ListTile(
                title: Text(items[index]),
                subtitle: RichText(
                  text: TextSpan(
                    text: 'Stamps ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          // text: "${Random().nextInt(9)}",
                          text: "$qtdeClientStamps",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      const TextSpan(text: ' /'),
                      const TextSpan(text: ' 10'),
                    ],
                  ),
                ),
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                trailing:
                    qtdeClientStamps == 10 ? const Text("Give the gift") : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
