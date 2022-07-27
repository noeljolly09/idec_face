import 'package:drop_down_list/drop_down_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:idec_face/screens/stores/single_area_view.dart';

import '../../constants.dart';
import '../../custom_widgets/chart/indicator.dart';
import '../../custom_widgets/chart/pie_chart.dart';
import '../../custom_widgets/custom_selection_old.dart';
import '../../custom_widgets/drawer/drawer.dart';

import '../../utility/app_info.dart';

class SingleStoreView extends StatefulWidget {
  const SingleStoreView({Key? key}) : super(key: key);

  @override
  State<SingleStoreView> createState() => _SingleStoreViewState();
}

class _SingleStoreViewState extends State<SingleStoreView> {
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
  final List<SelectedListItem> _listOfScores = [
    SelectedListItem(true, "1"),
    SelectedListItem(false, "2"),
    SelectedListItem(false, "3"),
    SelectedListItem(false, "4"),
    SelectedListItem(false, "5"),
    SelectedListItem(false, "6"),
  ];
  int touchedIndex = -1;

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _scoreTextController = TextEditingController();
  final TextEditingController _storeSearchController = TextEditingController();
  final TextEditingController _scoreSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAppName(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: AppConstants.inColor,
            drawer: const MyDrawer(),
            appBar: AppBar(
              backgroundColor: AppConstants.primaryColor,
              title: Text("${snapshot.data}"),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: CustomSelectionBar(
                          isConfigreceived: false,
                          circleSuffixIcon: true,
                          isSvg: false,
                          svgAsset: "",
                          width: MediaQuery.of(context).size.width,
                          list: _listOfStores,
                          hinttext: "Search Stores",
                          searchhinttext: "Search Store",
                          sheetTitle: "Stores",
                          controller: _textController,
                          searchController: _storeSearchController,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                child: PieChart(
                                  PieChartData(
                                      pieTouchData: PieTouchData(touchCallback:
                                          (FlTouchEvent event,
                                              pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      }),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 30,
                                      sections: showingSections(touchedIndex)),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Indicator(
                                    numbertext: "100",
                                    size: 20,
                                    fontsize: 20,
                                    color: Color(0xff2ae729),
                                    text: 'Normal :',
                                  ),
                                  SizedBox(height: 4),
                                  Indicator(
                                    numbertext: "100",
                                    size: 20,
                                    fontsize: 20,
                                    color: Color(0xffe6a320),
                                    text: 'Warning :',
                                  ),
                                  SizedBox(height: 4),
                                  Indicator(
                                    numbertext: "100",
                                    size: 20,
                                    color: Color(0xff8b0000),
                                    fontsize: 20,
                                    text: 'Faulty :',
                                  ),
                                  SizedBox(height: 18),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.map_sharp)),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.view_comfortable_outlined)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.thermostat)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.contact_page)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: CustomSelectionBar(
                              isConfigreceived: false,
                              circleSuffixIcon: true,
                              isSvg: false,
                              svgAsset: "",
                              width: MediaQuery.of(context).size.width / 1.4,
                              list: _listOfScores,
                              hinttext: "Sort by criticality score",
                              searchhinttext: "Sort by criticality score",
                              sheetTitle: "Score",
                              controller: _scoreTextController,
                              searchController: _scoreSearchController,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Ink(
                              child: const Icon(Icons.sort),
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SingleAreaView()));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
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
                                                Text('Beverages'),
                                                Text('5.5')
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
        });
  }
}
