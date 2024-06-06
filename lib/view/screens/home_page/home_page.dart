import 'package:db_miner/Routes/quotesdb_routes.dart';
import 'package:db_miner/controller/json_data_controller.dart';
import 'package:db_miner/modal/theme_controller.dart';
import 'package:db_miner/view/screens/detail_page/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    MyQuotes listenable = Provider.of<MyQuotes>(context);
    MyQuotes unlistenable = Provider.of<MyQuotes>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Provider.of<ThemeController>(context).isDark
                    ? AssetImage("lib/assets/image/category/sunset.png")
                    : AssetImage("lib/assets/image/category/light.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Text(
                        "Quotes",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Provider.of<ThemeController>(context, listen: false)
                              .getTheme();
                        },
                        icon: Provider.of<ThemeController>(context).isDark
                            ? const Icon(
                                Icons.dark_mode,
                                color: Colors.white,
                                size: 30,
                              )
                            : const Icon(
                                Icons.light_mode_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                    itemCount: listenable.allData.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> category = listenable.allData[index];
                      String categoryName = category['category'];
                      return Card(
                        color: Colors.black12,
                        child: ListTile(
                          title: Text(
                            '- $categoryName',
                            style: const TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          // subtitle: Text('- $categoryName'),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.instance.detailPage,
                                arguments: categoryName);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
