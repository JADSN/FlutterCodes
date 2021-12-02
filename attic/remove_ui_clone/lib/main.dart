// import 'package:flutter/material.dart';

// void main() => runApp(const HomePage());

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           body: Column(
//         children: [
//           Flexible(
//             flex: 3,
//             child: Container(
//               color: Colors.blue,
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   //* Sites and Notes.
//                   Flexible(
//                       flex: 1,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           //* Sites
//                           Flexible(
//                             flex: 1,
//                             child: Container(
//                               color: Colors.pinkAccent,
//                             ),
//                           ),
//                           //* Notes
//                           Flexible(
//                             flex: 1,
//                             child: Container(
//                               color: Colors.orangeAccent,
//                             ),
//                           ),
//                         ],
//                       )),
//                   //* Request and Response bodies.
//                   Flexible(
//                     flex: 5,
//                     // child: Container(
//                     //   color: Colors.greenAccent,
//                     // ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Flexible(
//                           flex: 1,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Flexible(
//                                 flex: 1,
//                                 child: Container(
//                                   color: Colors.purpleAccent,
//                                 ),
//                               ),
//                               Flexible(
//                                 flex: 1,
//                                 child: Container(
//                                   color: Colors.deepPurple,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Flexible(
//                           flex: 1,
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Flexible(
//                                 flex: 1,
//                                 child: Container(
//                                   color: Colors.cyan,
//                                 ),
//                               ),
//                               Flexible(
//                                 flex: 1,
//                                 child: Container(
//                                   color: Colors.cyanAccent,
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           //* Tabs and Events
//           Flexible(
//             flex: 1,
//             // child: Container(
//             //   color: Colors.red,
//             // ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Flexible(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.red,
//                   ),
//                 ),
//                 Flexible(
//                   flex: 6,
//                   child: Container(
//                     color: Colors.black38,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//  SplitView(
//         viewMode: SplitViewMode.Vertical,
//         indicator: const SplitIndicator(viewMode: SplitViewMode.Vertical),
//         activeIndicator: const SplitIndicator(
//           viewMode: SplitViewMode.Vertical,
//           isActive: true,
//         ),
//         children: [],
//       ),

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplitView(
        viewMode: SplitViewMode.Vertical,
        indicator: const SplitIndicator(viewMode: SplitViewMode.Vertical),
        activeIndicator: const SplitIndicator(
          viewMode: SplitViewMode.Vertical,
          isActive: true,
        ),
        controller: SplitViewController(weights: [0.8]),
        children: [
          SplitView(
            viewMode: SplitViewMode.Horizontal,
            indicator: const SplitIndicator(viewMode: SplitViewMode.Horizontal),
            controller: SplitViewController(weights: [0.2]),
            children: [
              SplitView(
                viewMode: SplitViewMode.Vertical,
                indicator:
                    const SplitIndicator(viewMode: SplitViewMode.Vertical),
                activeIndicator: const SplitIndicator(
                  viewMode: SplitViewMode.Vertical,
                  isActive: true,
                ),
                controller: SplitViewController(weights: [0.5]),
                children: [
                  Container(
                    color: Colors.orangeAccent,
                  ),
                  Container(
                    color: Colors.blueAccent,
                  )
                ],
              ),
              SplitView(
                viewMode: SplitViewMode.Vertical,
                indicator:
                    const SplitIndicator(viewMode: SplitViewMode.Vertical),
                activeIndicator: const SplitIndicator(
                  viewMode: SplitViewMode.Vertical,
                  isActive: true,
                ),
                controller: SplitViewController(weights: [0.5]),
                children: [
                  Container(
                    color: Colors.greenAccent,
                  ),
                  Container(
                    color: Colors.yellowAccent,
                  )
                ],
              ),
              SplitView(
                viewMode: SplitViewMode.Vertical,
                indicator:
                    const SplitIndicator(viewMode: SplitViewMode.Vertical),
                activeIndicator: const SplitIndicator(
                  viewMode: SplitViewMode.Vertical,
                  isActive: true,
                ),
                controller: SplitViewController(weights: [0.5]),
                children: [
                  Container(
                    color: Colors.pinkAccent,
                  ),
                  Container(
                    color: Colors.purpleAccent,
                  )
                ],
              ),
            ],
          ),
          Container(
            color: Colors.brown,
            child: SplitView(
              viewMode: SplitViewMode.Horizontal,
              indicator:
                  const SplitIndicator(viewMode: SplitViewMode.Horizontal),
              activeIndicator: const SplitIndicator(
                viewMode: SplitViewMode.Horizontal,
                isActive: true,
              ),
              controller: SplitViewController(weights: [0.2]),
              children: [
                Container(
                  color: Colors.black87,
                ),
                Container(
                  color: Colors.cyanAccent,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
