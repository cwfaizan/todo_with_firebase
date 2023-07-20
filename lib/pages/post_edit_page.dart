import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/collection.dart';
import '../utils/helper.dart';

class PostEditPage extends StatelessWidget {
  PostEditPage({super.key, required this.postMap, required this.initData});
  final Function initData;
  final Map<String, dynamic> postMap;
  final _kwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _kwController..text = postMap['name'],
            ),
            SizedBox(
              width: double.maxFinite,
              child: FilledButton(
                onPressed: () {
                  updatePost(context, postMap['id']);
                },
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updatePost(BuildContext context, String id) {
    Collection.posts.doc(id).set({
      'id': id,
      'name': _kwController.text.trim(),
    }).whenComplete(() {
      Helper.showMessage(
          context, 'Post ${_kwController.text} successfully updated');
      _kwController.clear();
      initData();
    });
  }
}
