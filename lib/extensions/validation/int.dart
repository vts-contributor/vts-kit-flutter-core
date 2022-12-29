import 'dart:math';

extension IntValidation on int {
  //src: https://stackoverflow.com/a/62150343
  //if this is not effective enough, please check other algorithms:
  //ex: Miller-Rabin algorithm...
  bool get isPrime {
    if (this <= 1) return false;
    if (this <= 3) return true;

    if (this % 2 == 0 || this % 3 == 0) {
      return false;
    }

    for (int i = 5; i * i < this; i += 6) {
      if (this % i == 0 || this % (i + 2) == 0) {
        return false;
      }
    }

    return true;
  }
}

