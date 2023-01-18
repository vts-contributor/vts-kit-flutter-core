import '../abstract_node_type.dart';
import 'custom_node_type.dart';
import '../tree_functions.dart';
import '../tree_type.dart';

List<TreeType<CustomNodeType>> sampleTreeType<T extends AbsNodeType>() {
  var root =  TreeType<CustomNodeType>(
    data: CustomNodeType.sampleInner("0"),
    childrenNodes: [],
    parent: null,
  );

  // ------------------ lv 1

  var lv1_1 = TreeType<CustomNodeType>(
    data: CustomNodeType.sampleInner("1.1"),
    childrenNodes: [],
    parent: root,
  );

  var lv1_2 = TreeType<CustomNodeType>(
    data: CustomNodeType.sampleInner("1.2"),
    childrenNodes: [],
    parent: root,
  );

  // ------------------ lv 2

  var lv2_1 = TreeType<CustomNodeType>(
    data: CustomNodeType.sampleInner("2.1"),
    childrenNodes: [],
    parent: lv1_1,
  );

  var lv2_2 = TreeType<CustomNodeType>(
    data: CustomNodeType.sampleInner("2.2"),
    childrenNodes: [],
    parent: lv1_1,
  );

  var lv2_3 = TreeType<CustomNodeType>(
    data: CustomNodeType.sampleInner("2.3"),
    childrenNodes: [],
    parent: lv1_1,
  );

  // ------------------ lv 2

  var lv3_1 = TreeType<CustomNodeType>(
    data: CustomNodeType.sampleLeaf("3.1"),
    childrenNodes: [],
    parent: lv2_1,
  );

  var lv3_2 = TreeType<CustomNodeType>(
    data: CustomNodeType.sampleLeaf("3.2"),
    childrenNodes: [],
    parent: lv2_1,
  );

  var lv3_3 = TreeType<CustomNodeType>(
    data: CustomNodeType.sampleLeaf("3.3"),
    childrenNodes: [],
    parent: lv2_1,
  );

  var lv3_4 = TreeType<CustomNodeType>(
    data: CustomNodeType.sampleLeaf("3.4"),
    childrenNodes: [],
    parent: lv2_2,
  );

  // --- connect everything together

  root.childrenNodes.addAll([lv1_1, lv1_2]);
  lv1_1.childrenNodes.addAll([lv2_1, lv2_2, lv2_3]);
  lv2_1.childrenNodes.addAll([lv3_1, lv3_2, lv3_3]);
  lv2_2.childrenNodes.addAll([lv3_4]);

  updateAllUnavailableNodes(root);

  return [lv1_1, lv1_2];
}
