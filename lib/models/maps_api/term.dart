class Term {
  final int? offset;
  final String? value;

  Term({
    this.offset,
    this.value,
  });

  factory Term.fromJson(Map<String, dynamic>? json) {
    final int? offset = json?['offset'];
    final String? value = json?['value'];
    return Term(
      offset: offset,
      value: value,
    );
  }
}
