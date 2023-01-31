import 'package:flutter/material.dart';
import 'package:flutter_core/bases/rx_data.dart';
import 'package:get/get.dart';

import 'abstract_node_type.dart';
import 'tree_functions.dart';
import 'tree_type.dart';
import 'error_page.dart';

///! NOTE 1: When access this sheet for the first time,
/// it could open a child, not root of the tree. Therefore we need
/// a variable to know where is its parent
///
///! NOTE 2: There is only 1 entire a tree: `listTrees = [root]`
///
///! NOTE 3: All of data (entire data of tree) is got only 1 time
class StackTreeWidget<T extends AbsNodeType> {
  Rx<RxData> statusLoading;
  List<TreeType<T>> listTrees;

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

  StackTreeWidget({
    required this.listTrees,
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
                    if (listTrees.isEmpty) {
                      return ErrorPage(
                        assetImage: assetImageEmpty,
                        message: emptyMessage,
                      );
                    } else if (listTrees[0].parent == null) {
                      return buildRootsOfTrees(context, setModalState);
                    } else {
                      return buildChildrenOfTrees(context, setModalState);
                    }
                  }
                }),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildRootsOfTrees(BuildContext context, StateSetter setModalState) {
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

        /// 2. the tree stack
        Expanded(
          child: Obx(() {
            switch (statusLoading.value.status) {
              case Status.LOADING:
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: const CircularProgressIndicator(),
                );
              case Status.SUCCEED:
                if (listTrees.isEmpty) {
                  return ErrorPage(
                    assetImage: assetImageEmpty,
                    message: emptyMessage,
                  );
                }
                return ListView.separated(
                  itemCount: listTrees.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (listTrees[index].data.isInner) {
                      return buildInnerNodeWidget(
                        listTrees[index],
                        context,
                        setModalState,
                      );
                    } else {
                      return buildLeafNodeWidget(
                          listTrees[index], context, setModalState);
                    }
                  },
                  separatorBuilder: (_, __) => Divider(),
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

        // _build2BottomButton(context),
      ],
    );
  }

  Widget buildChildrenOfTrees(BuildContext context, StateSetter setModalState) {
    return Column(
      children: [
        // build title (like an app bar)
        ListTile(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              setModalState(() {
                var parentOfCurrentTrees = listTrees[0].parent!;
                // is this parent already root?
                if (parentOfCurrentTrees.isRoot) {
                  listTrees = [parentOfCurrentTrees];
                } else {
                  var parentOfParentOfCurrentTree =
                      parentOfCurrentTrees.parent!;
                  listTrees = parentOfParentOfCurrentTree.childrenNodes;
                }
              });
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            listTrees[0].parent!.data.title,
            style: TextStyle(
              fontSize: 22,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),

        // build body
        Expanded(
          child: Obx(() {
            if (statusLoading.value.status == Status.LOADING) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: const CircularProgressIndicator(),
              );
            } else {
              return ListView.separated(
                itemCount: listTrees.length,
                itemBuilder: (BuildContext context, int index) {
                  var currentTree = listTrees[index];

                  if (currentTree.data.isInner) {
                    return buildInnerNodeWidget(
                        currentTree, context, setModalState);
                  } else {
                    return buildLeafNodeWidget(
                        listTrees[index], context, setModalState);
                  }
                },
                separatorBuilder: (_, __) => const Divider(),
              );
            }
          }),
        ),

        // _build2BottomButton(context),
      ],
    );
  }

  Widget buildLeafNodeWidget(
      TreeType<T> leafTree, BuildContext context, StateSetter setModalState) {
    return ListTile(
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
                  // leaf always has bool value (not null).
                  () => updateTree(leafTree, !leafTree.data.isChosen!),
                ),
      ),
    );
  }

  buildInnerNodeWidget(
      TreeType<T> innerNode, BuildContext context, StateSetter setModalState) {
    return ListTile(
      onTap: () {
        if (innerNode.childrenNodes.length == 0) return;
        setModalState(() => listTrees = innerNode.childrenNodes);
      },
      tileColor: null,
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
    );
  }

  // Widget _build2BottomButton(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(
  //         10, 10, 10, 10 + MediaQuery.of(context).padding.bottom),
  //     child: Center(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Obx(
  //             () => Visibility(
  //               visible:
  //                   statusLoading.value.status == Status.SUCCEED ? true : false,
  //               child: SizedBox(
  //                 width: 120,
  //                 height: 40,
  //                 child: OutlinedButton(
  //                   onPressed: () {
  //                     NavigationService.instance.pop();
  //                   },
  //                   style: ButtonStyle(
  //                     side: MaterialStateProperty.resolveWith(
  //                       (states) => BorderSide(
  //                         color: Theme.of(context).primaryColor,
  //                       ),
  //                     ),
  //                   ),
  //                   child: Text(
  //                     textCloseButton,
  //                     style: TextStyle(color: Theme.of(context).primaryColor),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Obx(
  //             () => Visibility(
  //               visible:
  //                   statusLoading.value.status == Status.SUCCEED ? true : false,
  //               child: SizedBox(
  //                 width: 120,
  //                 height: 40,
  //                 child: OutlinedButton(
  //                   onPressed: () {
  //                     // onReturnModifiedDeptTree?.call(listDeptTree);
  //                     NavigationService.instance.pop();
  //                   },
  //                   style: ButtonStyle(
  //                     side: MaterialStateProperty.resolveWith(
  //                       (states) => BorderSide(
  //                         color: Theme.of(context).primaryColor,
  //                       ),
  //                     ),
  //                     backgroundColor: MaterialStateProperty.resolveWith(
  //                       (states) => Theme.of(context).primaryColor,
  //                     ),
  //                   ),
  //                   child: Text(
  //                     textSelectButton,
  //                     style: const TextStyle(color: Color(0xFFFAFBFC)),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}


