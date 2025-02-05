import 'package:flutter/material.dart';

class Customeappbar extends StatelessWidget implements PreferredSizeWidget {
  const Customeappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      title: Text(
        'VALORANT STARTAGIES',
        style: TextStyle(
          fontFamily: 'valorantfonts',
        ),
      ),
      centerTitle: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(52.0);
}
