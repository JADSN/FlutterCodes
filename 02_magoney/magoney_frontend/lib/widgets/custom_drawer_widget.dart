import 'package:flutter/material.dart';
import 'package:magoney_frontend/constants/routes.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple[100],
            ),
            child: const Center(
              child: Text(
                'MAGONEY',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'HOME',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                Navigator.defaultRouteName,
              );
            },
          ),
          ListTile(
            title: const Text(
              'RECIBOS',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, receiptRoute);
            },
          ),
          ListTile(
            title: const Text(
              'REGISTROS',
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, recordsRoute);
            },
          ),
        ],
      ),
    );
  }
}
