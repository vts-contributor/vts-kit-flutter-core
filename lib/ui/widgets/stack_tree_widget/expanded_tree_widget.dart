import 'package:flutter/material.dart';
import 'package:flutter_core/bases/rx_data.dart';
import 'package:get/get.dart';

import 'abstract_node_type.dart';
import 'tree_functions.dart';
import 'tree_type.dart';
import 'error_page.dart';

class ExpandedTreeWidget<T extends AbsNodeType> {
  Rx<RxData> statusLoading;
  TreeType<T> rootTree;

  /// if current tree is already root (level 0),
  /// the top title will be a default message, ex: "SELECT SOMETHING..."
  String titleRootFree;

  /// empty page -> asset image [String]
  String assetImageEmpty;

  /// error page -> asset image [String]
  String assetImageError;

  /// empty screen message
  String emptyMessage;

  /// error screen message
  String errorMessage;

  String textCloseButton;
  String textSelectButton;

  Widget? leafLeadingWidget;

  ExpandedTreeWidget({
    required this.rootTree,
    required this.statusLoading,
    required this.titleRootFree,
    required this.assetImageEmpty,
    required this.assetImageError,
    required this.emptyMessage,
    required this.errorMessage,
    required this.textCloseButton,
    required this.textSelectButton,
    this.leafLeadingWidget,
  });

  Future<dynamic> showTree(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => StatefulBuilder(builder: (ctx, setModalState) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              /// this `SizedBox` defines how tall bottom sheet is -> it spreads
              /// entire screen except bottom padding, includes status bar
              /// padding -> so it will be able to drag down on top padding
              SizedBox(height: Get.height),

              /// the drag symbol
              Positioned(
                top: Get.statusBarHeight,
                child: Container(
                  width: 60,
                  height: 7,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                ),
              ),

              /// main part
              Container(
                height: Get.height - Get.statusBarHeight - 15,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24)),
                ),
                child: Obx(() {
                  if (statusLoading.value.status == Status.LOADING) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    return buildRoot(context, setModalState);
                  }
                }),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildRoot(BuildContext context, StateSetter setModalState) {
    return Column(
      children: [
        /// 1. top title
        ListTile(
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          leading: const SizedBox(),
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              titleRootFree,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        /// 2. the expanded tree
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Obx(() {
                switch (statusLoading.value.status) {
                  case Status.LOADING:
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: const CircularProgressIndicator(),
                    );
                  case Status.SUCCEED:
                    return buildInnerNodeWidget(
                      rootTree,
                      context,
                      setModalState,
                    );
                  case Status.FAILED:
                    return ErrorPage(
                      assetImage: assetImageError,
                      message: errorMessage,
                    );
                  default:
                    return Container();
                }
              }),
            ),
          ),
        ),

        SizedBox(height: 10 + MediaQuery.of(context).padding.bottom),
      ],
    );
  }

  Widget buildLeafNodeWidget(
      TreeType<T> leafTree, BuildContext context, StateSetter setModalState) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {},
      title: Text(leafTree.data.title),
      subtitle:
          leafTree.data.subtitle != null ? Text(leafTree.data.subtitle!) : null,
      leading: leafLeadingWidget,
      trailing: Checkbox(
        tristate: true,
        side: leafTree.data.isDisabled
            ? const BorderSide(color: Colors.grey, width: 1.0)
            : BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
        value: leafTree.data.isChosen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        //! leaf [isChosen] is always true or false, cannot be null
        onChanged: leafTree.data.isDisabled
            ? null
            : (_) => setModalState(
                  () => updateTree(leafTree, !leafTree.data.isChosen!),
                ),
      ),
    );
  }

  buildInnerNodeWidget(
      TreeType<T> innerNode, BuildContext context, StateSetter setModalState) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        title:
            Text(innerNode.data.title + ' (${innerNode.childrenNodes.length})'),
        subtitle: innerNode.data.subtitle != null
            ? Text(innerNode.data.subtitle!)
            : null,
        trailing: Checkbox(
          tristate: true,
          side: innerNode.data.isDisabled
              ? const BorderSide(color: Colors.grey, width: 1.0)
              : BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
          value: innerNode.data.isDisabled ? false : innerNode.data.isChosen,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          activeColor: innerNode.data.isDisabled
              ? Colors.grey
              : Theme.of(context).primaryColor,
          onChanged: innerNode.data.isDisabled
              ? null
              : (value) => setModalState(() => updateTree(innerNode, value)),
        ),
        childrenPadding: EdgeInsets.only(left: 15),
        children: List.generate(
          innerNode.childrenNodes.length,
          (index) {
            var currentChildTree = innerNode.childrenNodes[index];
            if (currentChildTree.isLeaf) {
              return buildLeafNodeWidget(
                currentChildTree,
                context,
                setModalState,
              );
            } else {
              return buildInnerNodeWidget(
                innerNode.childrenNodes[index],
                context,
                setModalState,
              );
            }
          },
        ),
      ),
    );
  }
}
