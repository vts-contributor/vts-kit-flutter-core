import 'package:flutter/material.dart';

/// error page & empty page include 2 components: image asset & message
///
/// - `assetImage`: [String]
/// - `message`: [String]
class ErrorPage extends StatelessWidget {
  final String assetImage;
  final String message;
  const ErrorPage({
    Key? key,
    required this.assetImage,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Image(image: AssetImage(assetImage), height: 100),
          const SizedBox(height: 15),
          Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
