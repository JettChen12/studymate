import 'package:flutter/material.dart';

import '../pages/chat_page/chat_page.dart';
import '../pages/community_page/community_page.dart';
import '../pages/profile_page/profile_page.dart';
import '../pages/timer_page/timer_page.dart';
import '../pages/todo_page/todo_page.dart';

class NavigatorItem {
  final String title;
  final IconData icon;
  final Widget page;

  NavigatorItem({required this.title, required this.icon, required this.page});
}

final iconList = [
  NavigatorItem(title: 'Community', icon: Icons.group, page: CommunityPage()),
  NavigatorItem(title: 'Todo', icon: Icons.library_add_check, page: TodoPage()),
  NavigatorItem(title: 'Chat', icon: Icons.chat_bubble, page: ChatPage()),
  NavigatorItem(title: 'Timer', icon: Icons.timelapse_rounded, page: TimerPage()),
  NavigatorItem(title: 'Profile', icon: Icons.settings, page: ProfilePage()),
];
