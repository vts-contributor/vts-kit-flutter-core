class Media {
  final String id;
  final String? type;
  final String? thumbnailUrl;
  final String? url;

  Media({required this.id, required this.type, this.thumbnailUrl, this.url});

  factory Media.fromJson(
    Map<String, dynamic>? json, {
    String idKey = 'id',
    String typeKey = 'type',
    String thumbnailKey = 'thumbnail_url',
    String urlKey = 'url',
  }) {
    final String id = json?[idKey] ?? '';
    final String? type = json?[typeKey];
    final String? thumbnail = json?[thumbnailKey];
    final String? url = json?[urlKey];
    return Media(id: id, type: type, thumbnailUrl: thumbnail, url: url);
  }
}
