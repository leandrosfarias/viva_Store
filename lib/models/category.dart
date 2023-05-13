class Category {
  final String id;
  final String name;
  final String description;
  final String imageUrl; // optional
  final String parentId; // optional

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.parentId,
  });
}
