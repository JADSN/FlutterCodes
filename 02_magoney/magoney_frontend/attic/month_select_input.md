# Month select input


```dart
    const Spacer(),
    InputDecorator(
        decoration: const InputDecoration(
        hintMaxLines: 1,
        hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
        ),
        hintText: 'Mês',
        label: Text(
            "Mês",
            style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            ),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 3.0,
            ),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2.0,
            ),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2.0,
            ),
        ),
        ),
        child: DropdownButton<String>(
        value: monthName,
        icon: const Icon(
            Icons.arrow_downward,
            color: Colors.deepPurple,
        ),
        focusColor: Colors.transparent,
        isDense: true,
        isExpanded: true,
        elevation: 2,
        style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
        ),
        underline: Container(
            height: 0,
            color: Colors.transparent,
        ),
        onChanged: (String? newValue) {
            setState(() {
            monthName = newValue!;
            });
        },
        items: <String>[
            'Janeiro',
            'Fevereiro',
            'Março',
            'Abril',
            "Maio",
            "Junho",
            "Julho",
            "Agosto",
            "Setembro",
            "Outubro",
            "Novembro",
            "Dezembro"
        ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
            );
        }).toList(),
        ),
    ),


```
