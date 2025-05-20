import 'package:flutter/material.dart';
import 'package:smart_hydronest/views/pengaturan.dart';
import 'package:smart_hydronest/views/profil.dart';

enum BottomNavItem { home, settings, profile }

class CustomBottomNavBar extends StatelessWidget {
  final BottomNavItem activeItem;
  final VoidCallback? onHomeTap;

  const CustomBottomNavBar({
    super.key,
    required this.activeItem,
    this.onHomeTap,
  });

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required BottomNavItem item,
    required VoidCallback onTap,
  }) {
    final isActive = item == activeItem;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4CAF50) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : Colors.white70,
          size: 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            icon: Icons.settings,
            item: BottomNavItem.settings,
            onTap: () {
              if (activeItem != BottomNavItem.settings) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Pengaturan()),
                );
              }
            },
          ),
          _buildNavItem(
            context: context,
            icon: Icons.home,
            item: BottomNavItem.home,
            onTap: () {
              if (onHomeTap != null && activeItem != BottomNavItem.home) {
                onHomeTap!();
              }
            },
          ),
          _buildNavItem(
            context: context,
            icon: Icons.person,
            item: BottomNavItem.profile,
            onTap: () {
              if (activeItem != BottomNavItem.profile) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Profil()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
