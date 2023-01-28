import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final scrollController = ScrollController();
  List posts = [];
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListiner);
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("home"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(12),
          controller: scrollController,
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final title = post['title'];
            final id = post['id'];
            final desc = post['body'];
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${id + 0}')),
                title: Text('$title'),
                subtitle: Text('$desc'),
              ),
            );
          }),
    );
  }

  Future<void> fetchPosts() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // expected response
      final json = jsonDecode(response.body) as List;
      setState(() {
        posts = posts + json;
      });
    } else {
      // unexpected response
    }
  }

  void _scrollListiner() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchPosts();
      const Center(child: CircularProgressIndicator());
    } else {
      debugPrint("scroll not  called");
    }
  }
}
