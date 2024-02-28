import 'package:flutter/material.dart';

class ListtilComponent extends StatelessWidget {
  const ListtilComponent(
      {super.key,
      required this.selected,
      required this.name,
      required this.icons,
      required this.destination});

  final bool selected;
  final String name;
  final Icon icons;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icons,
      selected: selected,
      selectedColor: Colors.amber,
      title: Text(name),
      // selected: _selectedIndex == 0,
      onTap: () {
        // Update the state of the app
        // _onItemTapped(0);
        // Then close the drawer
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => destination));
      },
    );
  }
}
