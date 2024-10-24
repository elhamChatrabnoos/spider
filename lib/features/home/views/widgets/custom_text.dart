import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.fontColor,
      this.textDecoration,
      this.decorationColor,
      this.textAlign,
      this.overflow,
      this.onClickText,
      this.padding = 0,
      this.paddingRight,
      this.maxLine,
      this.paddingTop,
      this.paddingLeft,
      this.height,
      this.paddingBottom,
      this.textDirection});

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final Function()? onClickText;
  final double? padding;
  final double? paddingRight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingBottom;
  final int? maxLine;
  final double? height;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: paddingRight ?? padding!,
          left: paddingLeft ?? padding!,
          top: paddingTop ?? padding!,
          bottom: paddingBottom ?? padding!),
      child: InkWell(
        onTap: onClickText,
        child: Text(
          text,
          textDirection: textDirection,
          textAlign: textAlign,
          maxLines: maxLine,
          overflow: overflow ?? TextOverflow.ellipsis ,
          style: TextStyle(
            height: height ?? 1.5,
            color: fontColor,
            fontWeight: fontWeight ?? FontWeight.normal,
            decoration: textDecoration,
            overflow: overflow ?? TextOverflow.ellipsis ,
            decorationColor: decorationColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
