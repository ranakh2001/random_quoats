import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:random_quoats/models/image_model.dart';
import 'package:random_quoats/models/quote_model.dart';
import 'package:random_quoats/services/network.dart';

import '../services/screenshot_and_share.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey globalKey = GlobalKey();
  Network network = Network();
  late QuoteModel quote;
  late ImageModel image;
  bool isloaded = false;
  ScreenshotAndShare screeenshotAndShare = ScreenshotAndShare();
  void getData() async {
    quote = await network.getQuote();
    image = await network.getImage();
    setState(() {
      isloaded = true;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:
          AppBar(elevation: 0, backgroundColor: Colors.transparent, actions: [
        IconButton(
            onPressed: () {
              setState(() {
                isloaded = false;
              });
              getData();
            },
            icon: const Icon(
              Icons.refresh,
              size: 32,
              color: Colors.green,
            ))
      ]),
      body: RepaintBoundary(
        key: globalKey,
        child: isloaded
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(image.url!),
                      fit: BoxFit.cover,
                      opacity: 0.7),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Stack(alignment: Alignment.centerLeft, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          "images/quote_icon.png",
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 48.0),
                            child: Text(
                              "${quote.content}",
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            color: Colors.green,
                            child: Text(
                              "${quote.author}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: isloaded
          ? FloatingActionButton.extended(
              backgroundColor: Colors.green,
              label: const Row(
                children: [
                  Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  Text("Take Screenshot")
                ],
              ),
              onPressed: () async{
               await screeenshotAndShare.capturePng(globalKey, context);
              },
            )
          : null,
    );
  }
}
