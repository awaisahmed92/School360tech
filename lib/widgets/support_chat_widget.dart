import 'package:flutter/material.dart';

class SupportChatButton extends StatelessWidget {
  const SupportChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) => const SupportPanelSheet(),
      ),
      backgroundColor: const Color(0xFF4F46E5),
      child: const Icon(Icons.sentiment_satisfied_alt_outlined,
          color: Colors.white),
    );
  }
}

class SupportPanelSheet extends StatelessWidget {
  const SupportPanelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.72,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Ideas'),
                Tab(text: 'Changelog'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _panel(
                    title: 'Live Chat Support',
                    subtitle: 'Chatwoot integration placeholder',
                    icon: Icons.chat_bubble_outline,
                  ),
                  _panel(
                    title: 'Ideas Board',
                    subtitle: 'Sleekplan embed placeholder',
                    icon: Icons.lightbulb_outline,
                  ),
                  _panel(
                    title: 'Changelog',
                    subtitle: 'No updates yet',
                    icon: Icons.new_releases_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _panel(
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 44, color: const Color(0xFF4F46E5)),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Color(0xFF6B7280))),
            ],
          ),
        ),
      ),
    );
  }
}
