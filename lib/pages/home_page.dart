import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/collection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _kwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(controller: _kwController),
        FilledButton(
          onPressed: () {
            save();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void save() {
    String id = Timestamp.now().millisecondsSinceEpoch.toString();
    Collection.blockKeywords.doc(id).set({
      'id': id,
      'name': _kwController.text.trim(),
    }).whenComplete(() {
      final kw = _kwController.text;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('keyword $kw successfully blocked'),
      ));
    });
  }
}
