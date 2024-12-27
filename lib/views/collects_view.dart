import 'package:flutter/material.dart';
import 'package:mrcatcash/models/profile_data.dart';
import 'package:mrcatcash/widgets/lists/collect_list_widget.dart';
import '../services/api_service.dart';

import '../widgets/sections/section_area_panel_widget.dart';

class CollectsView extends StatefulWidget {
  const CollectsView({super.key, required this.profileData});
  final ProfileData profileData;

  @override
  _CollectsViewState createState() => _CollectsViewState();
}

class _CollectsViewState extends State<CollectsView> {
  String appVersion = 'v.1.0.1';
  final ApiService apiService = ApiService(); // Initialize the API service

  Future<Map<String, dynamic>> fetchCollects() async {
    return apiService.fetchCollects();
  }
  late Future<List<dynamic>> collectsFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileData = widget.profileData;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recompensas',
          style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        automaticallyImplyLeading: false, // Removes the back button
        backgroundColor: const Color(0xFFFED86A),
        titleTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 20,
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Column(
            children: [
              SectionAreaPanelWidget(
                  uniqueId: profileData.uniqueId,
                  viewNameFor: 'collect'
              ),
              CollectListWidget()
            ],
          ),
        ],
      ),
    );
  }
}

