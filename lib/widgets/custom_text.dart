import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// Google Fonts Poppins memberikan tipografi yang bersih, modern, dan ramah untuk KantinKu.
// Proporsinya yang seimbang meningkatkan keterbacaan pada layar ponsel untuk nama menu dan harga.
// Parameter gaya yang dapat dikonfigurasi membuat widget ini mudah digunakan kembali di seluruh halaman aplikasi.

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
