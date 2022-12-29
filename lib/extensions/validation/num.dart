extension NumExtension on num {
  bool isInRange(num lower, num upper, {
    bool lowerExclusive = true,
    bool upperExclusive = true
  }) {
    return ( lowerExclusive? this > lower: this >= lower)
      && (upperExclusive? this < upper: this <= upper);
  }
}