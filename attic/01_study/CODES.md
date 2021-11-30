# CODES

## Datepicke example
```dart

TextField(
    keyboardType: TextInputType.datetime,
    decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Mês",
    ),
    onChanged: (value) {
        setState(() {
        monthReport = value;
        });
    },
    onTap: () {
        showDatePicker(
        context: context,

        initialDate: actualDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now(),
        currentDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.year,
        // locale: const Locale("pt", "BR"),
        ).then((date) {
        setState(() {
            actualDate = date!;
            ignore: todo
            TODO: Remove exclamation mark
            String dateIso = date.toIso8601String();
            print(dateIso);
            monthReport = dateIso;
        });
        });
    },
),

```

## Fetch render using FutureBuilder
```dart

late Future<List<Report>> futureReports;

@override
void initState() {
    super.initState();
    futureReports = fetchReports();
}


return MaterialApp(
    title: 'Fetch Data Example',
    theme: ThemeData(
        primarySwatch: Colors.blue,
    ),
    home: Scaffold(
        appBar: AppBar(
        title: const Text('Fetch Data Example'),
        ),
        body: Center(
        child: FutureBuilder<List<Report>>(
            future: futureReports,
            builder: (context, snapshot) {
            if (snapshot.hasData) {
                return Text(snapshot.data![0].name);
            } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
            }

            //  By default, show a loading spinner.
            return const CircularProgressIndicator();
            },
        ),
        ),
    ),
);
   

```