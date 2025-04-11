import 'package:flutter/material.dart';
import 'package:word_app/screens/support_screen.dart';
import 'package:word_app/screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback switchToStartScreen;
  final bool isDarkMode;
  final Function(bool) toggleDarkMode;

  const AppDrawer({
    required this.switchToStartScreen,
    required this.isDarkMode,
    required this.toggleDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calculate,
                    size: 50,
                    color: theme.colorScheme.onPrimary,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Word Guessing Game',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.support_agent,
              title: 'Get Support',
              onTap: () => _navigateTo(context, SupportScreen()),
              backgroundColor: theme.colorScheme.error.withOpacity(0.2),
              iconColor: theme.colorScheme.error,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              borderColor: theme.colorScheme.error,
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.settings,
              title: 'Settings',
              onTap: () => _navigateTo(context, SettingsScreen()),
              backgroundColor: theme.colorScheme.surface,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: SwitchListTile(
                title: Text(
                  "Dark Mode",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: isDarkMode,
                onChanged: toggleDarkMode,
                activeColor: theme.colorScheme.primary,
                thumbColor:
                    WidgetStateProperty.all(theme.colorScheme.onPrimary),
                trackColor: WidgetStateProperty.resolveWith((states) =>
                    states.contains(WidgetState.selected)
                        ? theme.colorScheme.primary.withOpacity(0.5)
                        : theme.colorScheme.surface),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isPremiumRequired = false,
    Color? backgroundColor,
    Color? iconColor,
    Color? borderColor,
    TextStyle? textStyle,
    Gradient? gradient,
  }) {
    final theme = Theme.of(context);
    final defaultIconColor =
        isPremiumRequired ? Colors.grey : theme.iconTheme.color;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        gradient: gradient,
        color:
            gradient == null ? backgroundColor ?? theme.cardTheme.color : null,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1.5)
            : isPremiumRequired
                ? Border.all(
                    color: theme.colorScheme.error.withOpacity(0.5), width: 1.5)
                : Border.all(color: theme.dividerColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: theme.colorScheme.primary.withOpacity(0.3),
        highlightColor: theme.colorScheme.primary.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (iconColor ??
                          defaultIconColor ??
                          theme.colorScheme.primary)
                      .withOpacity(0.1),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? defaultIconColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyLarge?.merge(textStyle).copyWith(
                        color: theme.colorScheme.onSurface,
                        fontSize: 16,
                      ),
                ),
              ),
              if (isPremiumRequired)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.error.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.lock,
                    size: 20,
                    color: theme.colorScheme.error,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
