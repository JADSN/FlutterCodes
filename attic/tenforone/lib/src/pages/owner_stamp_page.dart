import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OwnerStampPage extends StatefulWidget {
  const OwnerStampPage({Key? key}) : super(key: key);

  @override
  State<OwnerStampPage> createState() => _OwnerStampPageState();
}

class _OwnerStampPageState extends State<OwnerStampPage> {
  //* Controls the amount of active stamps.
  int qtdeCurrentStamps = 0;

  //* Controls the enable and disable when the owner click at stamp.
  int currentIndexStampDefinedByOwner = 0;

  Widget defineContent(int index) {
    if (index == 9 || index == 11) {
      return Container(
        color: Colors.white,
      );
    } else if (index > currentIndexStampDefinedByOwner) {
      return Container(
        color: Colors.black,
      );
    } else {
      return Center(
        child: SvgPicture.asset(
          "assets/stamp.svg",
          currentColor: Colors.black,
          height: 64,
          width: 64,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "$qtdeCurrentStamps",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const Text(
                      " /",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const Text(
                      " 10",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: defineContent(index),
                      onTap: index == 9 || index == 11
                          ? null
                          : () {
                              debugPrint("index: $index");
                              // debugPrint("newIndex: $newIndex");

                              setState(() {
                                currentIndexStampDefinedByOwner = index;

                                debugPrint(
                                    "currentIndexStampDefinedByOwner: $currentIndexStampDefinedByOwner");

                                var newIndex = ++index;
                                if (index == 11) {
                                  qtdeCurrentStamps = 10;
                                } else {
                                  qtdeCurrentStamps = newIndex;
                                }
                              });
                            },
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: const Text(
                    "BACK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
