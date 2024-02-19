import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();
  final ImagePicker _picker = ImagePicker();
  late Timer timer;

  final List<XFile>? images = [];

  void onMultiImagePressed() async {
    // final image = await ImagePicker().pickImage(
    //   source: ImageSource.gallery,
    // );
    final image = await _picker.pickMultiImage();

    if (image.isNotEmpty) {
      setState(() {
        this.images!.addAll(image);
      });
    }
    ;
  }

  void onRotateTick(int itemCount){
    int? nextPage = pageController.page?.toInt();

    if (nextPage == null) {
      return;
    }

    if (nextPage == itemCount) {
      nextPage = 0;
    } else {
      nextPage++;
    }
    pageController.animateToPage(
      nextPage,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void onTimerTick(Timer timer){
    onRotateTick(5);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds: 3), onTimerTick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
        actions: [
          IconButton(
            onPressed: onMultiImagePressed,
            icon: Icon(Icons.image_outlined),
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        children: images!.isNotEmpty
            ? imageRotate(images).toList()
            : [1, 2, 3, 4, 5, 6]
                .map(
                  (e) => Image.network(
                    //Image.asset(
                    'https://raw.githubusercontent.com/1day1/flutter-practice-pageview/main/assets/pageview$e.png',
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
      ),
    );
  }

  Iterable<Image> imageRotate(List<XFile>? images) {
    timer.cancel();
    timer = Timer.periodic(Duration(seconds: 3), (timer){
      onRotateTick(images!.length-1);
    });

    return images!
        .map(
          (image) => Image.file(
            File(image.path),
            fit: BoxFit.cover,
          ),
        );
  }
}
