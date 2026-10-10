import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/app_state.dart';
import '../core/auth/auth_state.dart';

class SchoolNavItem {
  const SchoolNavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
}

/// Shared light bar and sidebar used by parent and admin shells.
class SchoolChrome extends StatefulWidget {
  const SchoolChrome({
    super.key,
    required this.title,
    required this.items,
    required this.body,
    this.trailing,
  });

  final String title;
  final List<SchoolNavItem> items;
  final Widget body;
  final Widget? trailing;

  @override
  State<SchoolChrome> createState() => _SchoolChromeState();
}

class _SchoolChromeState extends State<SchoolChrome> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final phone = width < 720;
    final wide = width >= 1100;
    final dark = Theme.of(context).brightness == Brightness.dark;

    Widget nav({required bool iconsOnly}) {
      return _SideNav(
        items: widget.items,
        iconsOnly: iconsOnly,
        dark: dark,
        onPicked: () => _scaffoldKey.currentState?.closeDrawer(),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: phone
          ? Drawer(width: 248, child: SafeArea(child: nav(iconsOnly: false)))
          : null,
      body: Row(
        children: [
          if (wide) SizedBox(width: 248, child: nav(iconsOnly: false)),
          if (!wide && !phone) SizedBox(width: 72, child: nav(iconsOnly: true)),
          Expanded(
            child: Column(
              children: [
                _TopBar(
                  title: widget.title,
                  trailing: widget.trailing,
                  onMenu: phone ? () => _scaffoldKey.currentState?.openDrawer() : null,
                ),
                Expanded(child: widget.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title, this.trailing, this.onMenu});

  final String title;
  final Widget? trailing;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE6E8EE))),
      ),
      child: Row(
        children: [
          if (onMenu != null)
            IconButton(
              tooltip: 'Menu',
              onPressed: onMenu,
              icon: const Icon(Icons.menu, color: Color(0xFF1A1D26)),
            ),
          Icon(Icons.school_rounded, color: accent, size: 22),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Color(0xFF1A1D26), fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _SideNav extends StatelessWidget {
  const _SideNav({
    required this.items,
    required this.iconsOnly,
    required this.dark,
    required this.onPicked,
  });

  final List<SchoolNavItem> items;
  final bool iconsOnly;
  final bool dark;
  final VoidCallback onPicked;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? const Color(0xFF161B22) : Colors.white;
    final line = dark ? const Color(0xFF2C3558) : const Color(0xFFE6E8EE);
    final accent = Theme.of(context).colorScheme.primary;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        border: Border(right: BorderSide(color: line)),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        children: [
          if (!iconsOnly)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
              child: Text(
                'MENU',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w700,
                  color: dark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                ),
              ),
            ),
          for (final item in items)
            iconsOnly
                ? Tooltip(
                    message: item.label,
                    child: IconButton(
                      onPressed: () {
                        item.onTap();
                        onPicked();
                      },
                      icon: Icon(item.icon, color: item.selected ? accent : const Color(0xFF6B7280)),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: item.selected ? accent.withValues(alpha: 0.10) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          left: BorderSide(color: item.selected ? accent : Colors.transparent, width: 3),
                        ),
                      ),
                      child: ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        leading: Icon(item.icon, size: 18, color: item.selected ? accent : const Color(0xFF6B7280)),
                        title: Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: item.selected ? FontWeight.w700 : FontWeight.w600,
                            color: item.selected
                                ? accent
                                : (dark ? Colors.white : const Color(0xFF1A1D26)),
                          ),
                        ),
                        onTap: () {
                          item.onTap();
                          onPicked();
                        },
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}

class SchoolAccountMenu extends StatelessWidget {
  const SchoolAccountMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthState>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none_rounded, color: Theme.of(context).colorScheme.primary),
        ),
        PopupMenuButton<String>(
          tooltip: 'Account',
          offset: const Offset(0, 42),
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
            PopupMenuItem(enabled: false, value: 'version', child: Text('Version: 1.0.0')),
            PopupMenuItem(value: 'profile', child: Text('View My Profile')),
            PopupMenuItem(value: 'policies', child: Text('Policies')),
            PopupMenuItem(value: 'password', child: Text('Change Password')),
            PopupMenuItem(value: 'logout', child: Text('Logout')),
          ],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                auth.user?.name ?? 'Parent',
                style: const TextStyle(color: Color(0xFF1A1D26), fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 14,
                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                child: Icon(Icons.person, size: 16, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
