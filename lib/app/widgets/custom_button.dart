import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.buttonColor,
    this.borderColor,
    this.paddingSize,
    this.textColor,
    this.textSize,
    this.borderRadius,
    this.width,
    this.height,
    this.isLoading = false,
    this.enabled = true,
    this.borderWidth,
    this.widget,
    this.visualDensity,
    this.textStyle,
    this.paddingLeftRight,
    this.paddingTopBottom,
  });

  final Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final Color? borderColor;
  final double? paddingSize;
  final double? paddingLeftRight;
  final double? paddingTopBottom;
  final Color? textColor;
  final double? textSize;
  final double? borderRadius;
  final double? width;
  final double? height;
  final bool? isLoading;
  final bool? enabled;
  final double? borderWidth;
  final Widget? widget;
  final VisualDensity? visualDensity;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == 0 ? null : width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          visualDensity: visualDensity ??
              (paddingSize == 0
                  ? const VisualDensity(
                      horizontal: -3,
                      vertical: -3,
                    )
                  : null),
          foregroundColor: WidgetStateProperty.all(textColor ?? Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 3),
              side: BorderSide(
                color: borderColor ?? buttonColor ?? Theme.of(context).colorScheme.primary,
                width: borderWidth ?? 0.5,
              ),
            ),
          ),
          padding: (paddingLeftRight != null || paddingTopBottom != null)
              ? WidgetStateProperty.all(
                  EdgeInsets.only(
                    top: paddingTopBottom ?? 10,
                    bottom: paddingTopBottom ?? 10,
                    left: paddingLeftRight ?? 10,
                    right: paddingLeftRight ?? 10,
                  ),
                )
              : WidgetStateProperty.all(EdgeInsets.all(paddingSize ?? 10)),
          alignment: Alignment.center,
          backgroundColor: enabled!
              ? WidgetStateProperty.all(buttonColor ??  Theme.of(context).colorScheme.primary)
              : WidgetStateProperty.all(buttonColor?.withOpacity(0.5) ??
                  Colors.grey.withOpacity(0.5)),
        ),
        onPressed: enabled != null && enabled! ? onPressed : null,
        child: isLoading!
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white))
            : Container(
                padding: EdgeInsets.zero,
                child: widget ??
                    Text(
                      text,
                      style: textStyle ??
                          TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: textSize,
                          ),
                    ),
              ),
      ),
    );
  }
}
