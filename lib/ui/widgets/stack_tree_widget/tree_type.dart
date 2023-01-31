import 'abstract_node_type.dart';

class TreeType<T extends AbsNodeType> {
  T data;
  List<TreeType<T>> childrenNodes;

  /// If `parent == null`, it is root of the tree
  TreeType<T>? parent;

  TreeType({
    required this.data,
    required this.childrenNodes,
    required this.parent,
  });

  /// Check if this tree is a leaf
  bool get isLeaf => !data.isInner;

  bool get isRoot => parent == null;
}
