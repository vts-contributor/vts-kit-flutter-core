/// There're 2 kinds of node: inner node (including root) & leaf node:
///
/// - Inner node can be expanded with multiple inner nodes and leaves.
/// Inner node has ***DIFFERENT*** type as leaf node. If an inner node *contains
/// no leaf*, it is **NOT AVAILABLE** to choose.
/// - Leaf node has ***DIFFERENT*** type as inner node. It is the last item
/// which contains value to choose.
abstract class AbsNodeType {
  dynamic id;
  String title;
  String? subtitle;

  bool isInner;

  /// node is disabled for some reasons? --\_(^.^)_/--
  bool isDisabled;

  /// `true, false, null` are 3 values of a node.
  /// - Inner node:
  ///   + If `isChosen == true`, all of its children are chosen
  ///   + if `isChosen == false`, all of its children are unchosen
  ///   + If `isChosen == null`, some of its children are chosen, some are not
  /// - Leaf node: Only`true` or `false`
  /// 
  /// The default value is false (unchosen-all)
  bool? isChosen;

  AbsNodeType({
    required this.id,
    required this.title,
    this.subtitle,
    this.isInner = true,
    this.isDisabled = false,
    this.isChosen = false,
  });
}
