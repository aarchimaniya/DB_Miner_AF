import 'dart:io';
import 'dart:ui' as ui;

import 'package:db_miner/controller/json_data_controller.dart';
import 'package:db_miner/utilies/fonts_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> bgImages = [
    "https://i.pinimg.com/736x/2e/e0/ea/2ee0ea42affcac77909b80ff57466e27.jpg",
    "https://i.pinimg.com/564x/f4/fa/1d/f4fa1df8a41f3d159a04e1347426072f.jpg",
    "https://i.pinimg.com/564x/00/76/36/00763629efb5f4581059f741d98d6fbd.jpg",
    "https://i.pinimg.com/564x/70/b7/ab/70b7ab92a4d3344e1e17e0f55487e43f.jpg",
    "https://i.pinimg.com/564x/d3/a5/8d/d3a58d95fca8c4ef928438e41b25e6cb.jpg",
    "https://i.pinimg.com/564x/47/92/3e/47923e1d58d6606a605c42f13f356563.jpg",
  ];
  Color color = Colors.white;
  double opacity = 1;
  String fonts = AppFonts.dancingScript.name;

  GlobalKey widgetKey = GlobalKey();

  Future<File> getFileFromWidget() async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 2,
    );
    ByteData? data = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List list = data!.buffer.asUint8List();

    Directory directory = await getTemporaryDirectory();
    File file = await File(
            "${directory.path}/QA${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(list);

    return file;
  }

  bool image = false;

  String? selectedimage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String category = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "lib/assets/image/category/sunset.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              ...List.generate(
                Provider.of<MyQuotes>(context).allData.length,
                (index) => Provider.of<MyQuotes>(context).allData[index]
                            ['category'] ==
                        category
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...Provider.of<MyQuotes>(context)
                                .allData[index]['data']
                                .map(
                                  (e) => SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: Card(
                                      color: Colors.black12,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              e['quote'],
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FontStyle.italic,
                                                fontFamily: fonts,
                                                color: color,
                                              ),
                                            ),
                                            Text(
                                              e['author'],
                                              style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                fontFamily: fonts,
                                                color: color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: AppFonts.values
                    .map(
                      (e) => TextButton(
                        onPressed: () {
                          fonts = e.name;
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black54,
                          child: Text(
                            "Abc",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: e.name,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    18,
                    (index) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          color = Colors.primaries[index];
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.primaries[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black12),
                        ),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: "${category.length}\n\n-${category.length}",
                            ),
                          ).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.black12,
                                content: Text("Quote copied to clipboard !!"),
                              ),
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.copy,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () async {
                          ImageGallerySaver.saveFile(
                            (await getFileFromWidget()).path,
                            isReturnPathOfIOS: true,
                          ).then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Saved to gallery !!"),
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black45)),
                        icon: const Icon(
                          Icons.save_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () async {
                          ShareExtend.share(
                            (await getFileFromWidget()).path,
                            "image",
                          );
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black45)),
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black12),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
