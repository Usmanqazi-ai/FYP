import 'package:flutter/material.dart';

import '../resources/constants/app_Colors.dart';

class HomeScreenProvider extends ChangeNotifier {
  final List<String> _racksList = [
    "Rack 1",
    "Rack 2",
    "Rack 3",
    "Rack 4",
    "Rack 5",
  ];

  List<String> get rackslist => _racksList;
  int _rackNo = 0;

  int get rackNo => _rackNo;
  String _selectedRack = "Tap to select your rank";

  String get selectedRack => _selectedRack;

  void selectRank(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 12),

            // Title
            Text(
              "Select Your Rack",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 12),

            // List of Ranks
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _racksList.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final rank = _racksList[index];
                  return ListTile(
                    title: Text(rank),
                    leading: Icon(
                      rank == _selectedRack
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      _selectedRack = rank;
                      _rackNo = index + 1;
                      print(_rackNo);
                      notifyListeners();
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
