import 'package:flutter/material.dart';
import 'package:mrcatcash/models/profile_data.dart';
import 'package:mrcatcash/views/received_notes_view.dart';
import 'package:mrcatcash/widgets/components/copyable_wallet_number_widget.dart';
import '../services/api_service.dart';

class CampaignsView extends StatefulWidget {
  const CampaignsView({super.key, required this.profileData});

  final ProfileData profileData;

  @override
  _CampaignsViewState createState() => _CampaignsViewState();
}

class _CampaignsViewState extends State<CampaignsView> {
  String appVersion = 'v.1.0.1';
  final ApiService apiService = ApiService(); // Initialize the API service
  late ProfileData profile = ProfileData(
      uniqueId: '',
      createdAt: '00/00/0000 - 00:00:00',
      vouchers: Vouchers(valid: '0', invalid: '0', count: '0'),
      tokens: Tokens(amount: '0,0', collected: '0,0', allocated: '0,0'),
      currency: Currency(amount: '0.0'),
      presences: Presences(
          professional: { 'created': DateTime(2024, 11, 09), 'active': false },
          personal: { 'created': DateTime(2024, 11, 09), 'active': false }
      )
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var activeProfile = profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Campanhas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        automaticallyImplyLeading: false, // Removes the back button
        backgroundColor: const Color(0xFFFED86A),
        titleTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 20,
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Image.asset(
                  'assets/images/menu-close.png', // Path to your image
                  width: 30, height: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>
                      ReceivedNotesView(profileData: activeProfile, message:
                      {},)),
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      /* endDrawer: _buildRightDrawer(context), */
      body: const Stack(
        children: [
          Column(
            children: [
            ],
          ),
        ],
      ),
    );
  }
}