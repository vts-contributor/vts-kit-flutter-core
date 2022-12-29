class PlusCode {
  final String? globalCode;
  final String? compoundCode;

  PlusCode({
    this.globalCode,
    this.compoundCode,
  });

  factory PlusCode.fromJson(Map<String, dynamic>? json) {
    final String? globalCode = json?['global_code'];
    final String? compoundCode = json?['compound_code'];
    return PlusCode(globalCode: globalCode, compoundCode: compoundCode);
  }
}
