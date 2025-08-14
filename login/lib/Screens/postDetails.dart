import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDetails extends StatefulWidget {
  final Map<String, dynamic> data;

  const PostDetails(this.data, {super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  bool isFav = false;
  bool isSave = false;
  bool isrepost = false;

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      timestamp = timestamp.toDate();
    }
    if (timestamp is DateTime) {
      final now = DateTime.now();
      final diff = now.difference(timestamp);
      if (diff.inMinutes < 1) return 'Now';
      if (diff.inMinutes < 60) return '${diff.inMinutes} min';
      if (diff.inHours < 24) return '${diff.inHours} hr';
      if (diff.inDays < 7) return DateFormat('dd/MM/yyyy').format(timestamp);
    }
    return '  ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage('assets/avatar.jpeg'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.data['title'] ?? 'UnKnown ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '@${widget.data['author'] ?? 'UnKnown'}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.grey),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  widget.data['content'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                if (widget.data['imageUrl'] != null &&
                    widget.data['imageUrl'].isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.data['imageUrl'],
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        height: 300,
                        color: Colors.grey.shade800,
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 30),
                Text(
                  _formatTimestamp(widget.data['timestamp']),
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 4),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.share, color: Colors.grey, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            '',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isrepost ? Icons.repeat : Icons.repeat_outlined,
                              color: isrepost ? Colors.green : Colors.grey,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                isrepost = !isrepost;
                              });
                            },
                          ),

                          const SizedBox(width: 5),
                          Text(
                            isrepost ? '1' : '',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isFav = !isFav;
                              });
                            },
                          ),
                          Text(
                            isFav ? '1' : '',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isSave ? Icons.bookmark  : Icons.bookmark_border ,
                              color: isSave ? Colors.blue : Colors.grey,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                isSave = !isSave;
                              });
                            },
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isSave ? '1' : '',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
