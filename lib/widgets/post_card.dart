import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final int id;
  final String title;
  final String body;

  const PostCard({ Key? key, required this.id, required this.title, required this.body }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 5,
          offset: const Offset(1, 1)
        )]
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$id")
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14
                  ),
                ),
                const SizedBox(height: 5),
                Text(body)
              ],
            )
          )
        ],
      ),
    );
  }
}