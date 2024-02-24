// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  final String caption;
  final String imageLink;
  final String uid;
  final String name;
  final String image;
  Post({
    required this.caption,
    required this.imageLink,
    required this.uid,
    required this.name,
    required this.image,
  });

  Post copyWith({
    String? caption,
    String? imageLink,
    String? uid,
    String? name,
    String? image,
  }) {
    return Post(
      caption: caption ?? this.caption,
      imageLink: imageLink ?? this.imageLink,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'caption': caption,
      'imageLink': imageLink,
      'uid': uid,
      'name': name,
      'image': image,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      caption: map['caption'] as String,
      imageLink: map['imageLink'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(caption: $caption, imageLink: $imageLink, uid: $uid, name: $name, image: $image)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.caption == caption &&
        other.imageLink == imageLink &&
        other.uid == uid &&
        other.name == name &&
        other.image == image;
  }

  @override
  int get hashCode {
    return caption.hashCode ^
        imageLink.hashCode ^
        uid.hashCode ^
        name.hashCode ^
        image.hashCode;
  }
}
