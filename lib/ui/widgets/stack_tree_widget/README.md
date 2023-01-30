# Stack Tree Widget

A Stack Tree Widget.

## Flutter doctor -v
-------

```
[✓] Flutter (Channel stable, 3.3.10, on macOS 13.1 22C65 darwin-arm, locale en-VN)
    • Flutter version 3.3.10 on channel stable at /Users/nvbien/development/flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 135454af32 (5 weeks ago), 2022-12-15 07:36:55 -0800
    • Engine revision 3316dd8728
    • Dart version 2.18.6
    • DevTools version 2.15.0

[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
    • Android SDK at /Users/nvbien/Library/Android/sdk
    • Platform android-33, build-tools 33.0.0
    • Java binary at: /Applications/Android Studio.app/Contents/jre/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 11.0.13+0-b1751.21-8125866)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 14.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 14B47b
    • CocoaPods version 1.11.3

[✓] Chrome - develop for the web
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2021.3)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 11.0.13+0-b1751.21-8125866)

[✓] VS Code (version 1.74.3)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.56.0

[✓] Connected device (3 available)
    • iPhone 11 (mobile) • C9E9D660-DC8F-46B9-8055-C1DBD8490432 • ios            • com.apple.CoreSimulator.SimRuntime.iOS-16-1
      (simulator)
    • macOS (desktop)    • macos                                • darwin-arm64   • macOS 13.1 22C65 darwin-arm
    • Chrome (web)       • chrome                               • web-javascript • Google Chrome 109.0.5414.87

[✓] HTTP Host Availability
    • All required HTTP hosts are available
```

## Usage
-------
### Data structure
- *Tree is obviously a data structure of this Stack Tree Widget.*
- [AbsNodeType](abstract_node_type.dart): An abstract class about node data type. There're 2 kinds of node: inner node (including root) & leaf node. These below are basic fields for a node:
    - `id`: _required_, dynamic.
    - `title`: _required_, String.
    - `subtitle`: nullable.
    - `isInner`:  boolean, default is **true**. Is this node inner or leaf?
    - `isDisabled`:  boolean, default is **false**. Is this node chosenable or not?
    - `isChosen`: nullable boolean, default is **false**. A leaf can be being chosen or not (**true** or **false**). But an inner node's value could be **null**, which means some of its children are chosen, some are not.
- [TreeType<T extends AbsNodeType>](tree_type.dart): A class about tree data type:
    - `T` is implement class of [AbsNodeType](abstract_node_type.dart)
    - `data`: _required_, `T`. Data of node.
    - `childrenNodes`: _required_, `List<TreeType<T>>`. List of children nodes.
    - `parent`: parent, _required_, `TreeType<T>?`. Parent of current tree. If this tree is including root (full tree), `parent` will be null.
    - `isLeaf`
    - `isRoot`
- [tree_functions.dart](tree_functions.dart): There are 2 ***VERY IMPORTANT*** functions:
    - `updateAllUnavailableNodes(tree)`: Be used to update all unavailable nodes, such as inner node without children. It is **NECESSARY** to call this at the first time the tree was `INITIATED`,
    - `updateTree(tree, chosenValue)`: Be used to update entire tree, when current node's value are changed.
### Widget:
- [ErrorPage](error_page.dart): A screen for special condition, such as an empty list or an error occurred. This screen includes 2 components:
    - `assetImage`: _required_, String.
    - `message`: _required_, String.
- [StackTreeWidget](stack_tree_widget.dart): See instruction inside [file](stack_tree_widget.dart) & see example on [example_show_tree.dart](example/example_show_tree.dart). "List trees" variable will be updated after bottom sheet closes. To run example, modify [main.dart](../../../main.dart): add floating action button, then use function `onShowTree(context)` to show tree:
```dart
floatingActionButton: FloatingActionButton(
    onPressed: () {
        onShowTree(context);
    },
),
```
- [ExpandedTreeWidget](expanded_tree_widget.dart): See instruction inside [file](expanded_tree_widget.dart) & see example on [example_show_tree.dart](example/example_show_tree.dart). To run example, modify [main.dart](../../../main.dart): add floating action button, then use function `onShowExpandedTree(context)` to show tree:
```dart
floatingActionButton: FloatingActionButton(
    onPressed: () {
        onShowExpandedTree(context);
    },
),