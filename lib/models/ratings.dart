import 'dart:convert';

class Rating {
  final String name;
  final int rating;
  final String review;

  Rating({
    required this.name,
    required this.rating,
    required this.review,
  });

  Rating copyWith({
    String? name,
    int? rating,
    String? review,
  }) {
    return Rating(
      name: name ?? this.name,
      rating: rating ?? this.rating,
      review: review ?? this.review,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'rating': rating,
      'review': review,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    print(map);
    return Rating(
      name: map['name'] as String,
      rating: map['rating'] as int,
      review: map['review'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) =>
      Rating.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Rating(name: $name, rating: $rating, review: $review)';

  @override
  bool operator ==(covariant Rating other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.rating == rating &&
        other.review == review;
  }

  @override
  int get hashCode => name.hashCode ^ rating.hashCode ^ review.hashCode;
}
