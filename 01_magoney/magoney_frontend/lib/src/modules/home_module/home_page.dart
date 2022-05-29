// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magoney_frontend/src/constants/route_constants.dart';
import 'package:magoney_frontend/src/modules/home_module/home_state.dart';
import 'package:magoney_frontend/src/modules/home_module/home_store.dart';

import '../fc_info_module/fc_info_entity.dart';

class Kv {
  int key;
  String value;

  Kv({
    required this.key,
    required this.value,
  });

  @override
  String toString() => 'Kv(key: $key, value: $value)';
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FcInfoEntity fcInfoEntity = FcInfoEntity.stub();
  final HomeStore _homeStore = HomeStore();

  final mesesDoAno = <String>[
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
  ];

  late String mesDoAno;
  late List<Kv> kvMesesDoAno;

  @override
  void initState() {
    super.initState();

    mesDoAno = mesesDoAno[0];
    kvMesesDoAno = mesesDoAno
        .asMap()
        .entries
        .map((mapEntry) => Kv(key: mapEntry.key, value: mapEntry.value))
        .toList();
  }

  @override
  void dispose() {
    _homeStore.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Início'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                ),
                child: const Center(
                    child: Text(
                  'MAGONE',
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                )),
              ),
              ListTile(
                title: const Text(
                  'Folhas de Contas',
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Registros',
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: ValueListenableBuilder<HomeState>(
          valueListenable: _homeStore,
          builder: (_, state, __) {
            if (state is HomeLoadingState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.label,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeErrorState) {
              Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (state is HomeSuccessState) {
              final payload = state.payload;

              if (payload == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // * Nome da congregação
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          initialValue: fcInfoEntity.congregationName,
                          decoration: const InputDecoration(
                            hintMaxLines: 1,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: "Nome da congregação",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 3.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            errorMaxLines: 1,
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              fcInfoEntity.congregationName = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),

                      //* Nome da cidade
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          initialValue: fcInfoEntity.cityName,
                          decoration: const InputDecoration(
                            hintMaxLines: 1,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: "Cidade",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 3.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            errorMaxLines: 1,
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              fcInfoEntity.cityName = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),

                      //* Node do estado
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintMaxLines: 1,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: "Estado",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 3.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            errorMaxLines: 1,
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              fcInfoEntity.stateName = newValue!;
                            });
                          },
                        ),
                      ),

                      //* Mês
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 200,
                        child: InputDecorator(
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
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
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
                                color: Colors.deepOrange,
                                width: 2.0,
                              ),
                            ),
                          ),
                          child: DropdownButton<String>(
                            value: mesDoAno,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.deepOrange,
                            ),
                            focusColor: Colors.transparent,
                            isDense: true,
                            isExpanded: true,
                            elevation: 2,
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                            underline: Container(
                              height: 0,
                              color: Colors.transparent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                mesDoAno = newValue!;
                                fcInfoEntity.indexMonth =
                                    mesesDoAno.indexOf(newValue) + 1;
                              });
                            },
                            items: mesesDoAno
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      //* Ano
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          initialValue: fcInfoEntity.year.toString(),
                          decoration: const InputDecoration(
                            hintMaxLines: 1,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: "Ano",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 3.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            errorMaxLines: 1,
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                                width: 2.0,
                              ),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              fcInfoEntity.year = int.parse(newValue!);
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 10),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                        ),
                        child: const Text(
                          "Adicionar Folha de Contas",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          // log(fcInfoEntity.toString());

                          _homeStore
                              .createFc(payload: fcInfoEntity)
                              .whenComplete(
                                () async => await Navigator.of(context)
                                    .pushReplacementNamed(fcRecordsRoute),
                              );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context)
                      .pushReplacementNamed(fcPapersAccountsRoute);
                });
              }
            }

            return Container();
          },
        ));
  }
}
