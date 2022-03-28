import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String description;

  final TextStyle textStyle = TextStyle(
    fontFamily: "Poppins",
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey[800]
  );
  
  ProductCard({ Key? key, required this.title, required this.description }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 250,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 6,
            offset: const Offset(1, 3)
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child: Image(
              image: NetworkImage("https://img.freepik.com/free-vector/nature-scene-with-river-hills-forest-mountain-landscape-flat-cartoon-style-illustration_1150-37326.jpg"),
              fit: BoxFit.cover,
            )
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: textStyle,
                            ),
                            Text(
                              description,
                              textAlign: TextAlign.start,
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey[500]),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10), 
                          )
                        ),
                        child: Text(
                          "Add to Cart", 
                          textAlign: TextAlign.center,
                          style: textStyle.copyWith(
                            color: Colors.white
                          ),
                        ),
                      )
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}