import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

import '../models/profile_data.dart';
import '../services/api_service.dart';
import '../views/received_notes_view.dart';

class QRScannerWidget extends StatefulWidget {
  final ProfileData profileData;
  const QRScannerWidget({super.key, required this.profileData});

  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  QRViewController? controller;

  final ApiService apiService = ApiService(); // Initialize the API service
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profileData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupon QRCode'),
      ),
      body: QRView(
        key: qrKey, onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     final scannedUrl = scanData.code;
  //     if (scannedUrl != null) {
  //       controller.pauseCamera();
  //       _createReceivedNote(scannedUrl);
  //
  //       // >>> show view to confirm and add more info to createReceivedNot
  //
  //       _navigateToHome(scannedUrl); // Navigate to 'Coming Bind' view
  //     }
  //   });
  // }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    final profile = widget.profileData;

    controller.scannedDataStream.listen((scanData) async {
      final scannedUrl = scanData.code;
      if (scannedUrl != null) {
        controller.pauseCamera();

        apiService.createReceivedNote({
          "url": scannedUrl, "uniqueId": profile.uniqueId
        });

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            ReceivedNotesView(profileData: profile)), (Route<dynamic> route) => route.isFirst,
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
