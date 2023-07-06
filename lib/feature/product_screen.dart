import 'package:flutter/material.dart';
import 'package:impero_task/common/resource/colors.dart';
import 'package:impero_task/common/resource/dimen.dart';
import 'package:impero_task/common/utils/constants.dart';
import 'package:impero_task/common/widget/common_widget.dart';
import 'package:impero_task/feature/tab_screen/bathroom_tiles_screen.dart';
import 'package:impero_task/feature/tab_screen/ceramic_screen.dart';
import 'package:impero_task/feature/tab_screen/end_of_line_screen.dart';
import 'package:impero_task/provider/product_screen_provider.dart';
import 'package:provider/provider.dart';

import '../di/di_service.dart';
import '../session/session.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Session _session;

  late ProductScreenProvider _productScreenProvider;

  bool? selectedFeature;

  late Widget currentLayout;

  @override
  void initState() {
    super.initState();

    _session = getIt.get<Session>();
  }

  @override
  Widget build(BuildContext context) {
    _productScreenProvider = Provider.of<ProductScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tiles"),
        centerTitle: true,
        backgroundColor: ITColors.textColor,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  Icons.filter_alt_outlined,
                  color: ITColors.whiteColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.search,
                  color: ITColors.whiteColor,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: getMainLayout,
      ),
    );
  }

  get getMainLayout => FutureBuilder(
      future: _productScreenProvider.categoryList({
        PAGE_CATEGORY_ID: _productScreenProvider.categoryId,
        PAGE_DEVICE_MANUFACTURE: "Google",
        PAGE_DEVICE_MODEL: "",
        PAGE_DEVICE_TOKEN: "",
        PARAM_PAGE_INDEX: 1,
      }),
      builder: (context, snap) {
        if (snap.hasData && (snap.data?.status ?? false)) {
          return Column(
            children: [
              getCategoryList,
              Expanded(
                child: getCurrentSelectedTab(),
              ),
            ],
          );
        }
        return circularScreenLoader();
      });

  get getCategoryList => SizedBox(
        height: Spacing.jumbo30,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _productScreenProvider
                .categoryListModel.result?.category?.length,
            itemBuilder: (context, index) {
              return getSingleCategoryList(index);
            }),
      );

  Widget getSingleCategoryList(int index) {
    var item =
        _productScreenProvider.categoryListModel.result?.category?[index];
    return Container(
      color: ITColors.textColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            InkWell(
              onTap: () => onMenuNameClick(index),
              child: Text(
                item?.name ?? "",
                style: _session.selectedProductScreen == index
                    ? const TextStyle(
                        color: ITColors.whiteColor,
                        fontSize: TextSize.large,
                      )
                    : const TextStyle(
                        color: ITColors.alertRedColor,
                        fontSize: TextSize.normal,
                      ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget getCurrentSelectedTab() {
    if (_session.selectedProductScreen == BATHROOM_TILES) {
      _productScreenProvider.categoryList({}, force: true);
      currentLayout = const BathroomTilesScreen();
    } else if (_session.selectedProductScreen == CERAMIC) {
      _productScreenProvider.categoryList({}, force: true);
      currentLayout = CeramicScreen();
    } else if (_session.selectedProductScreen == END_OF_LINE) {
      currentLayout = EndOfLineScreen();
    } else if (_session.selectedProductScreen == MOSAICS) {
      currentLayout = Container();
    } else if (_session.selectedProductScreen == NEW_RANGES) {
      currentLayout = Container();
    } else if (_session.selectedProductScreen == NON_SLIPS) {
      currentLayout = Container();
    } else if (_session.selectedProductScreen == OUTDOOR) {
      currentLayout = Container();
    } else if (_session.selectedProductScreen == PATTERNS) {
      currentLayout = Container();
    } else if (_session.selectedProductScreen == PORCELAIN) {
      currentLayout = Container();
    } else if (_session.selectedProductScreen == WABI_SABI) {
      currentLayout = Container();
    } else if (_session.selectedProductScreen == WOOD_EFFECT) {
      currentLayout = Container();
    } else {
      currentLayout = Container();
    }

    return currentLayout;
  }

  onMenuNameClick(int index) {
    setState(() {
      _session.selectedProductScreen = index;
    });
  }
}
