# CODES

## Using Rows Widget - Good for components tha doesn't dissapear

```dart

@override
Widget build(BuildContext context) {
return Scaffold(
    body: Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
            'You clicked:',
            style: _changeYouClickedTextStyle(),
            ),
        ),
        Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
            '$_counter',
            style: _changeYouClickedTextStyle(),
            ),
        ),
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Visibility(
                visible: _counter != 0,
                child: FloatingActionButton(
                    onPressed: _resetCounter,
                    tooltip: 'Reset',
                    child: const Icon(Icons.adjust_rounded),
                    mini: true,
                    backgroundColor: _changeFloatIconColor(),
                ),
                ),
                Visibility(
                visible: _counter != -5,
                child: FloatingActionButton(
                    onPressed: _decrementCounter,
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                    mini: true,
                    backgroundColor: _changeFloatIconColor(),
                ),
                ),
                Visibility(
                visible: _counter != 5,
                child: FloatingActionButton(
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                    mini: true,
                    backgroundColor: _changeFloatIconColor(),
                ),
                ),
            ],
            ),
        ),
        ],
    ),
    ),
);
}


```