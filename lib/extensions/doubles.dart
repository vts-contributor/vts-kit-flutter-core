
extension RoundUp on double {
  int roundUp() {
    final floor = this.floor();
    if (this - floor > 0) {
      return floor + 1;
    }
    return floor;
  }
}
