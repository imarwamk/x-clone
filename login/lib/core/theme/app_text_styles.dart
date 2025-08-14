import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final title = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textWhite,
  );

  static final subtitle = GoogleFonts.poppins(
    fontSize: 15,
    color: AppColors.textWhite,
  );

  static final button = GoogleFonts.poppins(
    fontSize: 20,
    color: AppColors.textWhite,
  );
}
