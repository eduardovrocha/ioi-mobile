import 'package:flutter/material.dart';
import 'package:mrcatcash/models/profile_data.dart';
import 'package:mrcatcash/widgets/update_profile_screen_widget.dart';
import 'package:mrcatcash/widgets/modals/content/content_activation_form_widget.dart';

class ModalActivationProfessionalAccountFormWidget extends StatelessWidget {
  const ModalActivationProfessionalAccountFormWidget(
      {super.key, required this.profileData, required this.profilePresences});

  final ProfileData profileData;
  final List profilePresences;

  static void show(BuildContext context, profileData, profilePresences) {

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ContentActivationFormWidget(profilePresences)
                ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
    ).then((value) {
      Map<String, dynamic>? returnMessage = {
        "type": "${value?.type}",
        "message": "${value?.message}",
        "available": value?.available,
      };

      if (value?.available == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                UpdateProfileScreenWidget(
                  message: returnMessage,
                )
            ));
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

extension StatusExtension on Object? {
  get status {
    if (this is Map<String, dynamic> &&
        (this as Map<String, dynamic>).containsKey('status')) {
      return (this as Map<String, dynamic>)['status'];
    }
    return null;
  }

  get type {
    if (this is Map<String, dynamic> &&
        (this as Map<String, dynamic>).containsKey('type')) {
      return (this as Map<String, dynamic>)['type'];
    }
    return null;
  }

  get message {
    if (this is Map<String, dynamic> &&
        (this as Map<String, dynamic>).containsKey('message')) {
      return (this as Map<String, dynamic>)['message'];
    }
    return null;
  }

  get available {
    if (this is Map<String, dynamic> &&
        (this as Map<String, dynamic>).containsKey('available')) {
      return (this as Map<String, dynamic>)['available'];
    }
    return null;
  }
}
