import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final TextStyle textStyle = const TextStyle(
    fontFamily: "Poppins",
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white
  );

  const ProfileCard({ Key? key, required this.imageUrl, required this.name, required this.email }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(33, 50, 94, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 6,
          offset: const Offset(1, 1)
        )]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textStyle,
                ),
                Text(
                  email,
                  style: textStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}