import 'package:flutter/material.dart';

class Review {
  final String name;
  final String avatarUrl;
  final double rating;
  final String daysAgo;
  final String reviewText;

  Review({
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.daysAgo,
    required this.reviewText,
  });
}

class ReviewsWidget extends StatefulWidget {
  const ReviewsWidget({super.key});

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  List<Review> reviews = [
    Review(
      name: "Neha Sharma",
      avatarUrl: "https://randomuser.me/api/portraits/women/1.jpg",
      rating: 5.0,
      daysAgo: "2 days ago",
      reviewText:
          "Absolutely loved the service! The professional was on time, polite, and completed everything with great attention to detail.",
    ),
    Review(
      name: "Yash Shah",
      avatarUrl: "https://randomuser.me/api/portraits/men/32.jpg",
      rating: 4.0,
      daysAgo: "2 days ago",
      reviewText:
          "The quality exceeded my expectations! I could see the effort and care put into every step of the service.",
    ),
    Review(
      name: "Priyanka Das",
      avatarUrl: "https://randomuser.me/api/portraits/women/44.jpg",
      rating: 5.0,
      daysAgo: "6 days ago",
      reviewText:
          "Outstanding service! Everything was done perfectly and right on schedule — highly recommend!",
    ),
    Review(
      name: "Kartik Bora",
      avatarUrl: "https://randomuser.me/api/portraits/men/36.jpg",
      rating: 4.0,
      daysAgo: "10 days ago",
      reviewText:
          "Good experience overall. The service was neat and effective, though a slight delay in timing.",
    ),
  ];

  Widget buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < fullStars; i++)
          Icon(Icons.star, color: Colors.blue[900], size: 16),
        if (hasHalfStar)
          Icon(Icons.star_half, color: Colors.blue[900], size: 16),
        for (var i = 0; i < 5 - fullStars - (hasHalfStar ? 1 : 0); i++)
          Icon(Icons.star_border, color: Colors.blue[900], size: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 16, left: 12, right: 12, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reviews",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "See all",
                style: TextStyle(color: Colors.blue, fontSize: 13),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Review List
          ...reviews.map((review) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(review.avatarUrl),
                  ),
                  SizedBox(width: 12),
                  // Details Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Row
                        Text(
                          review.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        // Rating and Days Ago Row
                        Row(
                          children: [
                            buildRatingStars(review.rating),
                            SizedBox(width: 6),
                            Text(
                              review.rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                            Spacer(),
                            Text(
                              review.daysAgo,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        // Review description
                        Text(
                          review.reviewText,
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.black87,
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          // "Add a review" Button
          Center(
            child: GestureDetector(
              onTap: () {
                // Add review logic here
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 8, bottom: 12),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!, width: 1.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.black54, size: 18),
                      SizedBox(width: 6),
                      Text(
                        "Add a review",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom Row: Cost and Done button
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              
              
            ],
          ),
        ],
      ),
    );
  }
}
