

import 'package:flutter/material.dart';

class RankSelectionBox extends StatelessWidget {
  final VoidCallback onTap;
  const RankSelectionBox({
    super.key,
    required this.primaryColor,
    required this.selectedRank, required this.onTap,
  });

  final Color primaryColor;
  final String selectedRank;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Icon(Icons.badge, color: primaryColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  selectedRank,
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedRank == "Tap to select your rank"
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
              ),
              Icon(Icons.arrow_drop_down, color: primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}