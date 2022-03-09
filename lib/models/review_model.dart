class ReviewModel
{
  final int rating;
  final String comment;
  final String userEmail;

  ReviewModel({required this.rating, required this.comment, required this.userEmail});

  static ReviewModel fromJson(json)
  {
    return ReviewModel(
        rating: json['rating'],
        comment: json['comment'],
        userEmail: json['user']['userEmail']
    );
  }
}