import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:impero_task/common/resource/colors.dart';
import 'package:impero_task/data/category_list_model.dart';
import 'package:provider/provider.dart';

import '../../common/utils/constants.dart';
import '../../common/widget/common_widget.dart';
import '../../provider/product_screen_provider.dart';

class BathroomTilesScreen extends StatefulWidget {
  const BathroomTilesScreen({Key? key}) : super(key: key);

  @override
  _BathroomTilesScreenState createState() => _BathroomTilesScreenState();
}

class _BathroomTilesScreenState extends State<BathroomTilesScreen> {
  late ProductScreenProvider _productScreenProvider;


  @override
  Widget build(BuildContext context) {
    _productScreenProvider = Provider.of<ProductScreenProvider>(context);
    return getMainLayout;
  }

  get getMainLayout => FutureBuilder<List<dynamic>>(
      future: Future.wait([
        _productScreenProvider.categoryList({
          PAGE_CATEGORY_ID: _productScreenProvider.categoryId,
          PARAM_PAGE_INDEX: 2,
        }),
        _productScreenProvider.productCategoryList({
          PARAM_PAGE_INDEX: 2,
          PAGE_SUB_CATEGORY_ID: _productScreenProvider.subCategoryId,
        })
      ]),
      builder: (context, snap) {
        if (snap.hasData && ((snap.data?.length ?? 0) > 1)) {
          return Column(
            children: [
              getSubCategoryList,
            ],
          );
        }
        return circularScreenLoader();
      });

  get getSubCategoryList => Expanded(
        child: ListView.builder(
            itemCount: _productScreenProvider.categoryListModel.result
                    ?.category?[0].subCategories?.length ??
                0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return getSingleCategoryList(index);
            }),
      );

  Widget getSingleCategoryList(int index) {
    var item = _productScreenProvider
        .categoryListModel.result?.category?[0].subCategories?[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item?.name ?? "",
          ),
          const SizedBox(
            height: 10,
          ),
          getProductList(index),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget getProductList(int index) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          itemCount: _productScreenProvider.categoryListModel.result
                  ?.category?[0].subCategories?[index].product?.length ??
              0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return getSingleProductList(index);
          }),
    );
  }

  Widget getSingleProductList(int index) {
    var item = _productScreenProvider.categoryListModel.result?.category?[0]
        .subCategories?[0].product?[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: '${item?.imageName}',
                fit: BoxFit.fill,
              )),
          const SizedBox(
            height: 05,
          ),
          Text(
            item?.name ?? "",style: const TextStyle(color: ITColors.textColor),
          ),
        ],
      ),
    );
  }
}
