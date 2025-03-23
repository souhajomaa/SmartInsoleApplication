import 'package:flutter/material.dart';
import 'package:smartinsole/presentation/dashboard/model/menu_model.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.home, title: 'Home'),
    MenuModel(icon: Icons.person, title: 'Profile'),
    MenuModel(icon: Icons.add, title: 'Add player'),
    MenuModel(icon: Icons.history, title: 'History'),
    MenuModel(icon: Icons.logout, title: 'SignOut'),
  ];
}
