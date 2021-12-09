import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//* InheritedWidget - Recuperar e manipular dados que já estão na árvore.

//* Gerenciamento de estado: Definir o que deseja ser construído.
//* context -> Responsável por construir a tela (elemento construído).
//* Isso é possível pois tudo se torna um elemento só (paint).

void main() => runApp(const MyWidget());

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //*  Adicionar no widget no topo da árvore
    //* para todos os herdeiros possam obter as informações
    return CounterInherited(
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = context.findAncestorWidgetOfExactType<CounterInherited>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.increment();
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* Usando InheritedWidget
    //* final counter = context.findAncestorWidgetOfExactType<CounterInherited>()!;

    //* Usando InheritedNotifier<Listenable<T>>
    //? Irá encontrar ou depender do CounterInherited
    //* Encontrar: findAncestorWidgetOfExactType
    //* Depender: dependOnInheritedWidgetOfExactType

    // * Maneira 1 - SEM método estático.
    //* final counter =
    //*     context.dependOnInheritedWidgetOfExactType<CounterInherited>()!;

    // * Maneira 1 - COM método estático.
    // * Exemplos: MediaQuery.of(context), Theme.of(context),  Navigator.of(context) ...

    final counter = CounterInherited.of(context);

    return Center(
      child: Text("${counter.value}"),
    );
  }
}

//* InheritedWidget - É imutável
//* As informações somente podem ser recuperadas pelos herdeiros.
//* Movimentar dados via árvore.

//* class CounterInherited extends InheritedWidget {
//*   CounterInherited({required Widget child}) : super(child: child);

//*   var value = 1;

//*   @override
//*   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//*     return false;
//*   }
//* }

//? Quais widget vão depender das modifações do CounterInherited?
//* InheritedNotifier<algo que implmente Listnable> - É mutável
class CounterInherited extends InheritedNotifier<ValueNotifier<int>> {
  CounterInherited({required Widget child})
      : super(
          child: child,
          notifier: ValueNotifier(0),
        );

  static CounterInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInherited>()!;
  }

  int get value => notifier!.value;

  void increment() => notifier!.value++;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
