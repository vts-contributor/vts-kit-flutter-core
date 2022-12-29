
import 'dart:math';

extension BinaryString on String {
  int toSignedInt() {
    var result = 0;
    final binary = this;
    final length = binary.length;
    for (var i = 0; i < binary.length; i++) {
      final c = binary[i];
      if (c != '0' && c != '1') {
        return 0;
      }
      final num = int.parse(c);
      if (i == 0) {
        final int sign;
        if (num == 1) {
          sign = -1;
        } else {
          sign = 1;
        }
        result = sign * num * pow(2, length - 1 - i).toInt();
      } else {
        result += num * pow(2, length - 1 - i).toInt();
      }
    }
    return result;
  }
}

extension BinaryInt on int {
  String toReversed8Bit() {
    int x = this;
    String bitString = "";
    for (var i = 0; i < 8; i++) {
      bitString = ((x & 1 == 1) ? "0" : "1") + bitString;
      x = x >> 1;
    }
    return bitString;
  }
}