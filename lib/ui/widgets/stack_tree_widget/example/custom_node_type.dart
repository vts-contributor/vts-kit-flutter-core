import 'dart:math';

import '../abstract_node_type.dart';

class CustomNodeType extends AbsNodeType {
  CustomNodeType({
    required dynamic id,
    required dynamic title,
    String? subtitle,
    bool isInner = true,
  }) : super(id: id, title: title, subtitle: subtitle, isInner: isInner);

  CustomNodeType.sampleInner(String level) : super(id: -1, title: "") {
    super.id = Random().nextInt(100000);
    super.title = "(inner) title of level $level";
    super.subtitle = "subtitle of level = $level";
  }

  CustomNodeType.sampleLeaf(String level) : super(id: -1, title: "") {
    super.id = Random().nextInt(100000);
    super.title = "(leaf) title of level $level";
    super.subtitle = "subtitle of level = $level";
    super.isInner = false;
  }
}
