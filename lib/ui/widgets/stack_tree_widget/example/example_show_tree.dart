import 'package:flutter/material.dart';
import 'package:flutter_core/bases/rx_data.dart';
import 'package:flutter_core/ui/widgets/stack_tree_widget/example/custom_node_type.dart';
import 'package:flutter_core/ui/widgets/stack_tree_widget/example/example_tree_type.dart';
import 'package:flutter_core/ui/widgets/stack_tree_widget/expanded_tree_widget.dart';
import 'package:flutter_core/ui/widgets/stack_tree_widget/stack_tree_widget.dart';
import 'package:get/get.dart';

onShowTree(BuildContext context) {
  Rx<RxData<bool?>> hihi = RxData<bool?>.init().obs;
  hihi.value = RxData.loading();
  print("1 secs changed loading");
  Future.delayed(Duration(seconds: 1)).then((_) {
    hihi.value = RxData.succeed(true);
  });

  var listTrees = sampleTreeType();

  StackTreeWidget<CustomNodeType>(
    listTrees: listTrees,
    statusLoading: hihi,
    titleRootFree: 'CHỌN CÁ NHÂN, ĐƠN VỊ',
    assetImageEmpty: "assets/img/empty.png",
    assetImageError: "assets/img/fix.png",
    emptyMessage: "Danh sách trống",
    errorMessage: "Đã có lỗi xảy ra",
    textCloseButton: "Đóng",
    textSelectButton: "Chọn",
    leafLeadingWidget: const Padding(
      padding: EdgeInsets.only(left: 30.0),
      child: SizedBox(
        height: 50.0,
        width: 50.0,
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
        ),
      ),
    ),
  ).showTree(context).whenComplete(() {
    /// `listTrees` will be update after close bottom sheet
    print(listTrees[0].data.title +
        " - isChosen = " +
        listTrees[0].data.isChosen.toString());
  });
}

onShowExpandedTree(BuildContext context) {
  Rx<RxData<bool?>> hihi = RxData<bool?>.init().obs;
  hihi.value = RxData.loading();
  print("1 secs changed loading");
  Future.delayed(Duration(seconds: 1)).then((_) {
    hihi.value = RxData.succeed(true);
  });

  var rootTree = sampleTreeType();

  ExpandedTreeWidget<CustomNodeType>(
    rootTree: rootTree[0].parent!,
    statusLoading: hihi,
    titleRootFree: 'CHỌN CÁ NHÂN, ĐƠN VỊ',
    assetImageEmpty: "assets/img/empty.png",
    assetImageError: "assets/img/fix.png",
    emptyMessage: "Danh sách trống",
    errorMessage: "Đã có lỗi xảy ra",
    textCloseButton: "Đóng",
    textSelectButton: "Chọn",
    leafLeadingWidget: SizedBox(
      height: 50.0,
      width: 50.0,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey,
      ),
    ),
  ).showTree(context).whenComplete(() {
    /// `listTrees` will be update after close bottom sheet
    print(rootTree[0].data.title +
        " - isChosen = " +
        rootTree[0].data.isChosen.toString());
  });
}

