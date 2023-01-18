import 'abstract_node_type.dart';
import 'tree_type.dart';

///! IMPORTANT: This function can be used for update all unavailable nodes!
/// It is **NECESSARY** to call this at the first time tree was `INITIATED`!
///
/// Function returns a boolean, [true] if current tree is chosenable, else [false]
bool updateAllUnavailableNodes<T extends AbsNodeType>(TreeType<T> tree) {
  if (tree.isLeaf) return !tree.data.isDisabled;

  bool isThisTreeAvailable = false;
  for (var child in tree.childrenNodes) {
    if (updateAllUnavailableNodes(child)) isThisTreeAvailable = true;
  }

  if (isThisTreeAvailable) {
    return true;
  } else {
    tree.data.isDisabled = true;
    return false;
  }
}

/// This enum support functions [isChosenAll]
enum EChosenAllValues { chosenAll, unchosenAll, chosenAHalf, notChosenable }

/// Check if the rest of the tree is chosen all
EChosenAllValues isChosenAll<T extends AbsNodeType>(TreeType<T> tree) {
  if (tree.isLeaf) {
    if (tree.data.isDisabled) {
      return EChosenAllValues.notChosenable;
    } else {
      return tree.data.isChosen == true
          ? EChosenAllValues.chosenAll
          : EChosenAllValues.unchosenAll;
    }
  }

  /// Means one of it children has been chosen all
  bool hasChosenAll = false;

  /// Means one of it children has been unchosen all
  bool hasUnchosenAll = false;

  /**
   * - If one of its child is [EChosenAllValues.chosenAHalf] just return & exit
   * 
   * - Case chosen a half: [hasChosenAll && hasUnchosenAll]
   * 
   * - Case all of children are chosen: [hasChosenAll && !hasUnchosenAll]
   * 
   * - Case all of children are not chosen: [!hasChosenAll && hasUnchosenAll]
   * 
   * - Else, return default value [EChosenAllValues.notChosenable]
   */

  for (var child in tree.childrenNodes) {
    var temp = isChosenAll(child);
    switch (temp) {
      case EChosenAllValues.chosenAHalf:
        return EChosenAllValues.chosenAHalf;
      case EChosenAllValues.chosenAll:
        hasChosenAll = true;
        break;
      case EChosenAllValues.unchosenAll:
        hasUnchosenAll = true;
        break;
      default:
        break;
    }
  }

  if (hasChosenAll && hasUnchosenAll) {
    return EChosenAllValues.chosenAHalf;
  } else if (hasChosenAll && !hasUnchosenAll) {
    return EChosenAllValues.chosenAll;
  } else if (!hasChosenAll && hasUnchosenAll) {
    return EChosenAllValues.unchosenAll;
  } else {
    // return default
    return EChosenAllValues.notChosenable;
  }
}

/// [checkAll] for this tree (from current node to bottom)
bool checkAll<T extends AbsNodeType>(TreeType<T> tree) {
  tree.data.isChosen = true;

  // need to use index, if not, it could create another instance of [TreeType]
  for (int i = 0; i < tree.childrenNodes.length; i++) {
    checkAll(tree.childrenNodes[i]);
  }

  return true;
}

/// [uncheckAll] for this tree (from current node to bottom)
bool uncheckALl<T extends AbsNodeType>(TreeType<T> tree) {
  tree.data.isChosen = false;

  // need to use index, if not, it could create another instance of [TreeType]
  for (int i = 0; i < tree.childrenNodes.length; i++) {
    uncheckALl(tree.childrenNodes[i]);
  }

  return true;
}

/// updateTree
bool updateTree<T extends AbsNodeType>(TreeType<T> tree, bool? chosenValue,
    {bool isUpdatingParentRecursion = false}) {
  // Step 1. update current node
  tree.data.isChosen = chosenValue;

  // Step 2. update its children
  if (!tree.isLeaf && !isUpdatingParentRecursion) {
    // if not isUpdatingParentRecursion, means this is the first time call
    // function [updateTree], [chosenValue] is not nullable for now
    if (chosenValue == true) {
      checkAll(tree);
    } else {
      uncheckALl(tree);
    }
  }

  // Step 3. update parent
  if (!tree.isRoot) {
    var parent = tree.parent!;
    var parentChosenValue = isChosenAll(parent);

    switch (parentChosenValue) {
      case EChosenAllValues.chosenAHalf:
        updateTree(parent, null, isUpdatingParentRecursion: true);
        break;
      case EChosenAllValues.chosenAll:
        updateTree(parent, true, isUpdatingParentRecursion: true);
        break;
      case EChosenAllValues.unchosenAll:
        updateTree(parent, false, isUpdatingParentRecursion: true);
        break;
      default:
        throw Exception(
            "File: tree_function.dart\nFunction: updateTree()\nException: EChosenAllValues.notChosenable\nMessage: Some logic error happen");
    }
  }

  return true;
}

// /// This function help find **A TREE**, which contains its whole children
// TreeType<T>? findTreeWithId<T extends AbsNodeType>(
//     TreeType<T> tree, dynamic id) {
//   if (tree.data.id == id) {
//     return tree;
//   } else {
//     for (var innerTree in tree.childrenNodes) {
//       TreeType<T>? recursionResult = findTreeWithId(innerTree, id);
//       if (recursionResult != null) return recursionResult;
//     }
//   }
//   return null;
// }

// /// This function help find **A NODE**
// /// (only a node, not contains its whole children)
// T? findNodeWithId<T extends AbsNodeType>(TreeType<T> tree, dynamic id) {
//   if (tree.data.id == id) {
//     return tree.data;
//   } else {
//     for (var innerNode in tree.childrenNodes) {
//       T? recursionResult = findNodeWithId(innerNode, id);
//       if (recursionResult != null) return recursionResult;
//     }
//   }
//   return null;
// }

// /// Is there any leaf on this tree is available for choosing?
// bool isTreeChosenable<T extends AbsNodeType>(TreeType<T> tree) {
//   print("[isTreeChosenable] ${tree.data.title}");
//   if (tree.isLeaf) return !tree.data.isDisabled;

//   // if one of it children is chosenable, then tree is chosenable
//   for (var child in tree.childrenNodes) {
//     if (isTreeChosenable(child)) return true;
//   }

//   return false;
// }
