import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idec_face/constants.dart';
import 'package:idec_face/custom_widgets/custom_selection.dart';
import '../../custom_widgets/liquid_progress_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<SelectedListItem> _listOfStores = [
    SelectedListItem(true, "Abels"),
    SelectedListItem(false, "Ace cafe"),
    SelectedListItem(false, "Baking is fun"),
    SelectedListItem(false, "Big Bun Cafe"),
    SelectedListItem(false, "fort Shire"),
    SelectedListItem(false, "Homers"),
    SelectedListItem(false, "Hudson Square"),
    SelectedListItem(false, "Palm Avenue"),
  ];
  final List<SelectedListItem> _listOfSort = [
    SelectedListItem(true, "Criticality Score"),
    SelectedListItem(false, "Store"),
    SelectedListItem(false, ""),
    SelectedListItem(false, ""),
    SelectedListItem(false, ""),
    SelectedListItem(false, ""),
  ];
  int touchedIndex = -1;

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _scoreTextController = TextEditingController();
  final TextEditingController _storeSearchController = TextEditingController();
  final TextEditingController _scoreSearchController = TextEditingController();
  var percent = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: CustomSelectionBar(
                      controller: _textController,
                      searchController: _storeSearchController,
                      width: screenWidth(context),
                      isSvg: false,
                      hinttext: "Search Store",
                      searchhinttext: "Search Store",
                      sheetTitle: "All Stores",
                      isCircleSuffixIcon: false,
                      svgAsset: '',
                      list: _listOfStores,
                      isConfigreceived: false),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    CustomLiquidProgressIndicator(
                      percent: 80,
                      total: 100,
                      color: Colors.lightBlueAccent,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      qualityText: "Normal",
                    ),
                    CustomLiquidProgressIndicator(
                      percent: 60,
                      total: 100,
                      color: Colors.pinkAccent,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      qualityText: "Critical",
                    ),
                    CustomLiquidProgressIndicator(
                      percent: 30,
                      total: 100,
                      color: Colors.orangeAccent,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      qualityText: "Warning",
                    ),
                    CustomLiquidProgressIndicator(
                      percent: 10,
                      total: 100,
                      color: Colors.grey,
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      qualityText: "Not Working",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     bottom: BorderSide(width: 1.0, color: Colors.black),
                      //   ),
                      // ),
                      child: const Text(
                        "Sort by",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: CustomSelectionBar(
                          controller: _scoreTextController,
                          searchController: _scoreSearchController,
                          width: screenWidth(context, dividedBy: 1.6),
                          isSvg: false,
                          hinttext: "Criticality score",
                          searchhinttext: "Select one to Sort",
                          sheetTitle: "Sort",
                          isCircleSuffixIcon: false,
                          svgAsset: '',
                          list: _listOfSort,
                          isConfigreceived: false),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/svg/sort.svg",
                        height: 25,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    thickness: 5,
                    interactive: true,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                elevation: 0,
                                margin: const EdgeInsets.all(0),
                                child: Container(
                                  color: (index % 2 == 0)
                                      ? Colors.grey.shade300
                                      : Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Hudson Square',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            '5.5',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
