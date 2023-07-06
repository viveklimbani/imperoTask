import 'package:flutter/material.dart';
import 'package:impero_task/provider/product_screen_provider.dart';
import 'package:provider/provider.dart';

import '../../common/utils/constants.dart';
import '../../common/widget/common_widget.dart';

class CeramicScreen extends StatefulWidget {
  const CeramicScreen({Key? key}) : super(key: key);

  @override
  _CeramicScreenState createState() => _CeramicScreenState();
}

class _CeramicScreenState extends State<CeramicScreen> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item?.name ?? "",
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
