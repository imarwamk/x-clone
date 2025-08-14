import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final VoidCallback? onTap;

  const PostCard({required this.post, this.onTap});

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      timestamp = timestamp.toDate();
    }
    if (timestamp is DateTime) {
      final now = DateTime.now();
      final diff = now.difference(timestamp);
      if (diff.inMinutes < 1) return 'sic';
      if (diff.inMinutes < 60) return '${diff.inMinutes} min';
      if (diff.inHours < 24) return '${diff.inHours} hr';
      if (diff.inDays < 7) return DateFormat('dd/MM/yyyy').format(timestamp);
    }
    return '  ';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 1),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(2, 0, 0, 0),
          borderRadius: BorderRadius.circular(0),
          border: Border(
            top: BorderSide(
              width: 0.2,
              color: const Color.fromARGB(138, 255, 255, 255),
            ),
            bottom: BorderSide(
              width: 0.2,
              color: const Color.fromARGB(138, 255, 255, 255),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage('assets/avatar.jpeg'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post['title'] ?? 'Unknown ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "@${post['IMarwa_MK'] ?? 'IMarwa_MK'}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _formatTimestamp(post['timestamp']),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                post['content'] ?? '',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 5),

            if (post['imageUrl'] != null && post['imageUrl'].isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    post['imageUrl'],
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        color: Colors.grey.shade800,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(
                      height: 200,
                      color: Colors.grey.shade800,
                      child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.share,
                        color: Color.fromARGB(129, 255, 255, 255),
                      ),
                      SizedBox(width: 3),
                      Text('1', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.repeat,
                        color: Color.fromARGB(129, 255, 255, 255),
                      ),
                      SizedBox(width: 3),
                      Text('1', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border_outlined,
                        color: Color.fromARGB(129, 255, 255, 255),
                      ),
                      SizedBox(width: 3),
                      Text('5', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.bookmark_outline,
                        color: Color.fromARGB(129, 255, 255, 255),
                      ),
                      SizedBox(width: 3),
                      Text('4', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Icon(
                    Icons.more_horiz,
                    color: Color.fromARGB(129, 255, 255, 255),
                  ),
                  SizedBox(width: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
