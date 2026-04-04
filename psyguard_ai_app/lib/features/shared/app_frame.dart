import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppFrame extends StatelessWidget {
  const AppFrame({
    super.key,
    required this.title,
    required this.child,
    required this.activeRoute,
    this.actions,
  });

  final String title;
  final Widget child;
  final String activeRoute;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'PsyGuard AI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ..._menuItems(context),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    );
  }

  List<Widget> _menuItems(BuildContext context) {
    final items = [
      ('/home', '首頁'),
      ('/chat', 'AI 對話'),
      ('/checkin', '30 秒心情'),
      ('/sleep', '睡眠紀錄'),
      ('/trends', '趨勢圖'),
      ('/tools', '工具庫'),
      ('/safety', 'Safety Flow'),
      ('/export', '匯出摘要'),
    ];

    return items.map((item) {
      final route = item.$1;
      return ListTile(
        selected: route == activeRoute,
        title: Text(item.$2),
        onTap: () {
          Navigator.of(context).pop();
          context.go(route);
        },
      );
    }).toList();
  }
}
