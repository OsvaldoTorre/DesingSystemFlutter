import 'package:design_system_mobile/design_system.dart';

/// Modelo de tab
class TabItemDS {
  const TabItemDS({
    required this.label,
    required this.content,
    this.icon,
    this.badge,
    this.enabled = true,
  });

  final String label;
  final Widget content;
  final IconData? icon;
  final String? badge;
  final bool enabled;
}

/// Estilos de tabs
enum TabStyleDS { underline, pills, enclosed }

/// CpTabs — Sistema de pestañas con contenido intercambiable.
/// Organism que combina TabBar + TabBarView con estilos del Design System.
///
/// ```dart
/// CpTabs(
///   tabs: [
///     TabItemDS(label: 'Perfil', icon: Icons.person, content: ProfileView()),
///     TabItemDS(label: 'Seguridad', content: SecurityView()),
///     TabItemDS(label: 'Notificaciones', badge: '3', content: NotifView()),
///   ],
/// )
/// ```
class CpTabs extends StatefulWidget {
  const CpTabs({
    super.key,
    required this.tabs,
    this.style = TabStyleDS.underline,
    this.initialIndex = 0,
    this.onChanged,
    this.scrollable = false,
  });

  final List<TabItemDS> tabs;
  final TabStyleDS style;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final bool scrollable;

  @override
  State<CpTabs> createState() => _CpTabsState();
}

class _CpTabsState extends State<CpTabs> with SingleTickerProviderStateMixin {
  late TabController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _ctrl.addListener(() {
      if (!_ctrl.indexIsChanging) widget.onChanged?.call(_ctrl.index);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _ctrl,
            children: widget.tabs.map((t) => t.content).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return switch (widget.style) {
      TabStyleDS.underline => _UnderlineTabBar(
          ctrl: _ctrl, tabs: widget.tabs, scrollable: widget.scrollable),
      TabStyleDS.pills => _PillsTabBar(
          ctrl: _ctrl, tabs: widget.tabs, scrollable: widget.scrollable),
      TabStyleDS.enclosed => _EnclosedTabBar(
          ctrl: _ctrl, tabs: widget.tabs, scrollable: widget.scrollable),
    };
  }
}

// ─── Underline (Bootstrap default) ───────────────────────────────────────────
class _UnderlineTabBar extends StatelessWidget {
  const _UnderlineTabBar({
    required this.ctrl,
    required this.tabs,
    required this.scrollable,
  });
  final TabController ctrl;
  final List<TabItemDS> tabs;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: ctrl,
      isScrollable: scrollable,
      indicatorColor: ColorsDS.primary,
      indicatorWeight: 2,
      labelColor: ColorsDS.primary,
      unselectedLabelColor: ColorsDS.gray600,
      labelStyle: TypographyDS.body.copyWith(fontWeight: TypographyDS.weightSemi),
      unselectedLabelStyle: TypographyDS.body,
      dividerColor: ColorsDS.gray200,
      tabs: tabs.map((t) => _TabLabel(tab: t)).toList(),
    );
  }
}

// ─── Pills ────────────────────────────────────────────────────────────────────
class _PillsTabBar extends StatelessWidget {
  const _PillsTabBar({
    required this.ctrl,
    required this.tabs,
    required this.scrollable,
  });
  final TabController ctrl;
  final List<TabItemDS> tabs;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: ctrl,
      isScrollable: scrollable,
      indicator: BoxDecoration(
        color: ColorsDS.primary,
        borderRadius: RadiusDS.borderPill,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: ColorsDS.white,
      unselectedLabelColor: ColorsDS.gray600,
      labelStyle: TypographyDS.body.copyWith(fontWeight: TypographyDS.weightSemi),
      unselectedLabelStyle: TypographyDS.body,
      dividerColor: Colors.transparent,
      padding: const EdgeInsets.all(SpacingsDS.xs),
      tabs: tabs.map((t) => _TabLabel(tab: t)).toList(),
    );
  }
}

// ─── Enclosed ─────────────────────────────────────────────────────────────────
class _EnclosedTabBar extends StatelessWidget {
  const _EnclosedTabBar({
    required this.ctrl,
    required this.tabs,
    required this.scrollable,
  });
  final TabController ctrl;
  final List<TabItemDS> tabs;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(SpacingsDS.sm),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: ColorsDS.gray100,
        borderRadius: RadiusDS.borderMd,
      ),
      child: TabBar(
        controller: ctrl,
        isScrollable: scrollable,
        indicator: BoxDecoration(
          color: ColorsDS.white,
          borderRadius: RadiusDS.borderSm,
          boxShadow: const [
            BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 1)),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: ColorsDS.bodyColor,
        unselectedLabelColor: ColorsDS.gray500,
        labelStyle: TypographyDS.body.copyWith(fontWeight: TypographyDS.weightSemi),
        unselectedLabelStyle: TypographyDS.body,
        dividerColor: Colors.transparent,
        tabs: tabs.map((t) => _TabLabel(tab: t)).toList(),
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({required this.tab});
  final TabItemDS tab;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tab.icon != null) ...[
            Icon(tab.icon, size: 16),
            const SizedBox(width: 4),
          ],
          Text(tab.label),
          if (tab.badge != null) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: ColorsDS.danger,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                tab.badge!,
                style: const TextStyle(
                  fontSize: 9,
                  color: ColorsDS.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
