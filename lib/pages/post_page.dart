import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/collection.dart';
import '../utils/helper.dart';
import 'post_edit_page.dart';
import 'post_save_page.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Map<String, dynamic>> postList = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    QuerySnapshot querySnapshot = await Collection.posts.get();
    postList = querySnapshot.docs
        .map((e) => e.data() as Map<String, dynamic>)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostSavePage(initData: initData),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(postList[index]['name']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    deletePost(postList[index]['id']);
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PostEditPage(
                          postMap: postList[index],
                          initData: initData,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deletePost(String id) {
    Collection.posts.doc(id).delete();
    initData();
    Helper.showMessage(context, 'Post $id successfully deleted');
  }
}
