import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:idec_face/custom_widgets/custom_selection.dart';
import 'package:idec_face/screens/stores/single_store_view.dart';

import '../../constants.dart';
import '../../custom_widgets/drawer/drawer.dart';
import '../../utility/app_info.dart';

class StoresPage extends StatefulWidget {
  const StoresPage({Key? key}) : super(key: key);

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  final TextEditingController _storeController = TextEditingController();
  final TextEditingController _storeSearchController = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAppName(),
        builder: (context, snapshot) {
          return Scaffold(
              drawer: const MyDrawer(),
              appBar: AppBar(
                backgroundColor: AppConstants.primaryColor,
                title: Text("${snapshot.data}"),
              ),
              body: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: CustomSelectionBar(
                        isConfigreceived: false,
                        controller: _storeController,
                        searchController: _storeSearchController,
                        width: screenWidth(context),
                        isSvg: false,
                        isCircleSuffixIcon: true,
                        svgAsset: "",
                        hinttext: "Search Stores",
                        searchhinttext: "Search Store",
                        sheetTitle: "Stores",
                        list: _listOfStores),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.sort)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.add_circle)),
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                      thickness: 5,
                      interactive: true,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 30,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SingleStoreView()));
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: SizedBox(
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
                                            Text('Hudson Square'),
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
              ));
        });
  }
}
