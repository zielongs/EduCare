/*--------------------------------------------------
Author      : Alyssa Annabelle binti James Pekan
Updated by  : 
Tested by   :
Date        : 03 January 2026
Description : 
This screen is used by admin to provide reusable UI components
across various admin screens, such as gradient backgrounds,
circle icon buttons, info fields, and dropdown fields.    
--------------------------------------------------*/
import 'package:flutter/material.dart';

class AdminTheme {
  static const Color top = Color(0xFF63DDE5);
  static const Color mid = Color(0xFF5AA1D6);
  static const Color bottom = Color(0xFF1C2B8C);

  static const Color cardBg = Color(0xD0FFFFFF); // white with opacity
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AdminTheme.top, AdminTheme.mid, AdminTheme.bottom],
        ),
      ),
      child: child,
    );
  }
}

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.25),
            border: Border.all(color: Colors.white.withOpacity(0.45)),
          ),
          child: Icon(icon, color: Colors.black87),
        ),
      ),
    );
  }
}

class InfoField extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;

  const InfoField({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Row(
        children: [
          Icon(leadingIcon, color: Colors.black87),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownField extends StatelessWidget {
  final IconData leadingIcon;
  final String value;
  final List<String> items;
  final String chipText;
  final ValueChanged<String> onChanged;
  final String? subtitle;

  const DropdownField({
    super.key,
    required this.leadingIcon,
    required this.value,
    required this.items,
    required this.chipText,
    required this.onChanged,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Row(
        children: [
          Icon(leadingIcon, color: Colors.black87),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    items: items
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) onChanged(v);
                    },
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: const TextStyle(fontSize: 11)),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          _ChipLabel(text: chipText),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class DateField extends StatelessWidget {
  final String dateText;
  final VoidCallback onTap;

  const DateField({
    super.key,
    required this.dateText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: _CardContainer(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(child: Text(dateText)),
            const Icon(Icons.calendar_month, size: 18),
          ],
        ),
      ),
    );
  }
}

class TimeBox extends StatelessWidget {
  final String valueText;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const TimeBox({
    super.key,
    required this.valueText,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      height: 44,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TinyButton(icon: Icons.remove, onTap: onMinus),
          Text(valueText, style: const TextStyle(fontWeight: FontWeight.w800)),
          _TinyButton(icon: Icons.add, onTap: onPlus),
        ],
      ),
    );
  }
}

class AmPmToggle extends StatelessWidget {
  final bool isAm;
  final ValueChanged<bool> onChanged;

  const AmPmToggle({
    super.key,
    required this.isAm,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      height: 44,
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _TogglePill(text: 'AM', selected: isAm, onTap: () => onChanged(true)),
          _TogglePill(text: 'PM', selected: !isAm, onTap: () => onChanged(false)),
        ],
      ),
    );
  }
}

class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AdminTheme.bottom,
      unselectedItemColor: Colors.black38,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
        BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Attendance'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Tutors'),
      ],
    );
  }
}

// ------------------- internal tiny widgets -------------------

class _CardContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsets? padding;

  const _CardContainer({
    required this.child,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AdminTheme.cardBg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(blurRadius: 10, offset: Offset(0, 6), color: Colors.black26),
        ],
      ),
      child: child,
    );
  }
}

class _ChipLabel extends StatelessWidget {
  final String text;
  const _ChipLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _TinyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TinyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(width: 26, height: 26, child: Icon(icon, size: 16)),
    );
  }
}

class _TogglePill extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _TogglePill({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF90D7E6) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: selected ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }
}
