import 'package:flutter/material.dart';

import 'package:magoney_frontend/src/modules/fc_papers_accounts/fc_dialogs/add_fc_dialog.dart';
import 'package:magoney_frontend/src/modules/fc_papers_accounts/fc_papers_accounts_state.dart';
import 'package:magoney_frontend/src/modules/fc_papers_accounts/fc_papers_accounts_store.dart';

class FcPapersAccountsPage extends StatelessWidget {
  FcPapersAccountsPage({Key? key}) : super(key: key);

  final FcPapersAccountsStore _fcStore = FcPapersAccountsStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Folhas de Contas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ValueListenableBuilder<FcPapersAccountsState>(
        valueListenable: _fcStore,
        builder: (_, state, __) {
          if (state is FcPapersAccountsLoadingState) {
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

          if (state is FcPapersAccountsErrorState) {
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

          if (state is FcPapersAccountsSuccessState) {
            final list = state.payload;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list.elementAt(index);
                return ListTile(
                  title: Text(item.toString()),
                );
              },
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () async {
          return showDialog<void>(
            context: context,
            builder: (_) => const AddFcDialog(),
          );
        },
      ),
    );
  }
}
