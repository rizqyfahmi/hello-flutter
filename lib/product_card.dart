import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final int quantity;
  final VoidCallback? onAddToCart;
  final VoidCallback? onIncreament;
  final VoidCallback? onDecrement;
  final TextStyle textStyle = TextStyle(
    fontFamily: "Poppins",
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey[800]
  );
  
  ProductCard({ Key? key, required this.title, required this.description, required this.quantity, this.onAddToCart, this.onIncreament, this.onDecrement }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 10,
          right: 10,
          bottom: 0,
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 200),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return FractionalTranslation(
                translation: Offset(0, value),
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child: const Text("Discount 10%"),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)
                )
              ),
            ),
          )
        ),
        Container(
          width: 150,
          height: 350,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              // BoxShadow(
              //   color: Colors.grey.withOpacity(0.5),
              //   blurRadius: 5,
              //   spreadRadius: 6,
              //   offset: const Offset(1, 3)
              // ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 3,
                spreadRadius: 4,
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
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 5
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 1
                        )
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: onIncreament,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.orange,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                quantity.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onDecrement,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.orange,
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: onAddToCart,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10), 
                                )
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_chart,
                                  color: Colors.white,
                                ),
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
        ),
      ],
    );
  }
}