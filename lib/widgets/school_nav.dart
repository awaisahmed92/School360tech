import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';
import '../core/auth/auth_state.dart';

class SchoolNav extends StatelessWidget {
  const SchoolNav({super.key, this.onMenu});

  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final auth = context.watch<AuthState>();
    const tabs = ParentTab.values;
    final isCompact = MediaQuery.sizeOf(context).width < 1100;

    return Container(
      color: const Color(0xFF3F33D0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          if (isCompact && onMenu != null)
            IconButton(
              tooltip: 'Menu',
              onPressed: onMenu,
              icon: const Icon(Icons.menu, color: Colors.white),
            ),
          const Icon(Icons.school_rounded, color: Colors.white),
          const SizedBox(width: 8),
          const Text(
            'School360tech',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(width: 18),
          if (!isCompact)
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final tab in tabs)
                    _TabButton(
                      selected: state.tab == tab,
                      label: tab.label,
                      icon: tab.icon,
                      onTap: () => context.read<AppState>().selectTab(tab),
                    ),
                ],
              ),
            )
          else
            const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded,
                color: Colors.white),
          ),
          PopupMenuButton<String>(
            color: Colors.white,
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  auth.user?.name ?? 'Parent',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 6),
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: Color(0xFFECE9FF),
                  child: Icon(Icons.person, size: 16, color: Color(0xFF3F33D0)),
                ),
              ],
            ),
            onSelected: (value) async {
              final app = context.read<AppState>();
              if (value == 'logout') {
                await context.read<AuthState>().logout();
              } else if (value == 'profile') {
                app.openParentPage(ParentPage.parentProfile);
              } else if (value == 'policies') {
                app.openParentPage(ParentPage.policies);
              } else if (value == 'password') {
                app.openParentPage(ParentPage.changePassword);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                enabled: false,
                value: 'version',
                child: Text('Version: 1.0.0'),
              ),
              PopupMenuItem(value: 'profile', child: Text('View My Profile')),
              PopupMenuItem(value: 'policies', child: Text('Policies')),
              PopupMenuItem(value: 'password', child: Text('Change Password')),
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.selected,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
