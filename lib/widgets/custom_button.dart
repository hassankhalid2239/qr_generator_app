import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const CustomButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: SizedBox(
        height: 60,
        child: ElevatedButton.icon(
          onPressed: onTap,
          style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Color(0xff2879F1)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))),
          icon: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          label: Text(
            title,
            style: GoogleFonts.nunito(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
