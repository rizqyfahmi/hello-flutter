import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;

  /// Profile is a widget used to display its photo profile, name, and role
  ///
  /// [imageUrl] is a link of the *photo* profile. Default `https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png`
  ///
  /// [name] is a place where we set *name* of the user. Default `NO NAME`
  ///
  /// [role] is a *role* of the user. Default `NO ROLE`
  ///
  /// For example:
  /// ```
  /// Profile(
  ///   imageUrl: "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
  ///   name: "NO NAME",
  ///   role: "NO ROLE"
  /// )
  /// ```
  ///
  /// ![](https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png)
  const Profile(
      {Key? key,
      this.imageUrl =
          "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
      this.name = "NO NAME",
      this.role = "NO ROLE"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(imageUrl)),
              borderRadius: BorderRadius.circular(50)),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Text(
          role,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
