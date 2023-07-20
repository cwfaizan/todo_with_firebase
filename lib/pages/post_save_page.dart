import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/collection.dart';
import '../utils/helper.dart';

class PostSavePage extends StatelessWidget {
  PostSavePage({super.key, required this.initData});
  final Function initData;
  final _kwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(controller: _kwController),
            SizedBox(
              width: double.maxFinite,
              child: FilledButton(
                onPressed: () {
                  savePost(context);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void savePost(BuildContext context) {
    String id = Timestamp.now().millisecondsSinceEpoch.toString();
    Collection.posts.doc(id).set({
      'id': id,
      'name': _kwController.text.trim(),
    }).whenComplete(() {
      Helper.showMessage(
          context, 'Post ${_kwController.text} successfully added');
      _kwController.clear();
      initData();
    });
  }
}
