import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../custom_widgets/custom_selection_old.dart';
import '../../custom_widgets/ticket/ticket_text.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
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
  final List<SelectedListItem> _listOfAssets = [
    SelectedListItem(true, "Freezer"),
    SelectedListItem(false, "Node"),
    SelectedListItem(false, "sensors"),
    SelectedListItem(false, "gateways"),
  ];

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _assetTextController = TextEditingController();
  final TextEditingController _storeSearchController = TextEditingController();
  final TextEditingController _assetSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.inColor,
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
                    isConfigreceived: false
                    ,
                    circleSuffixIcon: true,
                    isSvg: false,
                    svgAsset: "",
                    width: MediaQuery.of(context).size.width,
                    list: _listOfStores,
                    hinttext: "Search Store",
                    searchhinttext: "Search Store",
                    sheetTitle: "Stores",
                    controller: _textController,
                    searchController: _storeSearchController,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: CustomSelectionBar(
                        isConfigreceived: false,
                        circleSuffixIcon: true,
                        isSvg: false,
                        svgAsset: "",
                        width: MediaQuery.of(context).size.width / 1.5,
                        list: _listOfAssets,
                        hinttext: "Assets/Devices",
                        searchhinttext: "Assets/Devices",
                        sheetTitle: "Score",
                        controller: _assetTextController,
                        searchController: _assetSearchController,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.add_circle)),
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    thickness: 10,
                    interactive: true,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // itemCount:_addCard,
                        // itemCount: items.length,
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            child: Text("${index + 1}",
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                            backgroundColor:
                                                AppConstants.primaryColor,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 4),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          TicketText(
                                            islabelrequired: true,
                                            label: "Asset ID ",
                                            value: "VC24FGSD",
                                          ),
                                          TicketText(
                                            islabelrequired: true,
                                            label: "Type ",
                                            value: "Vertical Chiller",
                                          ),
                                          TicketText(
                                            islabelrequired: true,
                                            label: "Area",
                                            value: "Ground Floor",
                                          ),
                                          TicketText(
                                            islabelrequired: true,
                                            label: "Store",
                                            value: "Green Garden",
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.map)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.edit))
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon:
                                                  const Icon(Icons.thermostat)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.contact_page))
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
