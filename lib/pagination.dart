import 'package:flutter/material.dart';

class LazyLoading extends StatefulWidget {
  const LazyLoading({super.key});

  @override
  State<LazyLoading> createState() => _LazyLoadingState();
}

class _LazyLoadingState extends State<LazyLoading> {
  late List myList;
  ScrollController scrollController = ScrollController();
  int currentMax = 10;

  @override
  void initState() {
    super.initState();
    myList = List.generate(10, (index) => "Item : ${index + 1}");
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  getMoreData() {
    for (int i = currentMax; i < currentMax + 10; i++) {
      myList.add("Item :${i + 1}");
    }
    currentMax = currentMax + 10;
    setState(() {});
    print("get more data ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
        centerTitle: true,
      ),
      body: ListView.builder(
          controller: scrollController,
          itemExtent: 80,
          itemCount: myList.length + 1,
          itemBuilder: (context, index) {
            if (index == myList.length) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListTile(
              title: Text(myList[index]),
            );
          }),
    );
  }
}
