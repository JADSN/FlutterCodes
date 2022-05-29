# Year input

```dart

    const Spacer(),
    TextFormField(
        initialValue: DateTime.now().year.toString(),
        style: const TextStyle(
        color: Colors.deepPurple,
        fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
        LengthLimitingTextInputFormatter(
            4,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
        ),
        FilteringTextInputFormatter.digitsOnly
        ],
        cursorColor: Colors.deepPurple,
        autocorrect: false,
        decoration: const InputDecoration(
        hintMaxLines: 1,
        hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
        ),
        hintText: 'Ano',
        errorStyle: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
        ),
        label: Text(
            "Ano",
            style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            ),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
            width: 3.0,
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
        autovalidateMode: AutovalidateMode.always,
        validator: (String? value) {
        if (value != null) {
            var parsedValue = int.tryParse(value) ?? 0;
            if (parsedValue > DateTime.now().year) {
            return "O ano atual é: ${DateTime.now().year}";
            } else {
            return value.length < 4 ? 'Pelo menos 4 dígitos' : null;
            }
        } else {
            return "Não pode ser vazio";
        }
        },
        onChanged: (String newValue) => setState(
        () => year = int.tryParse(newValue) ?? DateTime.now().year,
        ),
    ),

```