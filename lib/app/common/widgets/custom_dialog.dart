import 'package:flutter/material.dart';
import 'package:kvn_catering/app/common/widgets/custom_text.dart';
import 'package:kvn_catering/app/core/themes/theme.dart';

class ReActionDialog extends StatelessWidget {
  final Color backgroundColor;
  final double elevation;
  final double radius;
  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? children;
  final EdgeInsetsGeometry contentPadding;
  final String cancelText;
  final String confirmText;
  final TextStyle? actionStyle;
  final Function()? onCancel;
  final Function()? onConfirm;
  final CrossAxisAlignment childrenAlignment;
  const ReActionDialog({
    super.key,
    this.backgroundColor = AppColor.background,
    this.elevation = 0,
    this.radius = 16,
    required this.title,
    required this.children,
    this.titleStyle,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 24,
      horizontal: 16,
    ),
    this.cancelText = 'Batal',
    this.confirmText = 'Simpan',
    this.actionStyle,
    required this.onCancel,
    required this.onConfirm,
    this.childrenAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Dialog(
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReText(
                value: title,
                style: titleStyle ?? AppStyle().titleLarge,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              const Divider(
                height: 0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: contentPadding,
                      child: Column(
                        crossAxisAlignment: childrenAlignment,
                        children: children ?? [],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: onCancel,
                      child: ReText(
                        value: cancelText,
                        style: actionStyle ??
                            AppStyle()
                                .titleMedium
                                .copyWith(color: AppColor.accent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 56,
                    child: VerticalDivider(),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: onConfirm,
                      child: ReText(
                        value: confirmText,
                        style: actionStyle ??
                            AppStyle()
                                .titleMedium
                                .copyWith(color: AppColor.accent),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReDialog extends StatelessWidget {
  final Color backgroundColor;
  final double elevation;
  final double radius;
  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? children;
  final EdgeInsetsGeometry contentPadding;
  final String cancelText;
  final TextStyle? actionStyle;
  final Function()? onCancel;
  final CrossAxisAlignment childrenAlignment;
  const ReDialog({
    super.key,
    this.backgroundColor = AppColor.background,
    this.elevation = 0,
    this.radius = 16,
    required this.title,
    required this.children,
    this.titleStyle,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 24,
      horizontal: 16,
    ),
    this.cancelText = 'Back',
    this.actionStyle,
    required this.onCancel,
    this.childrenAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Dialog(
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReText(
                value: title,
                style: titleStyle ?? AppStyle().titleLarge,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              const Divider(
                height: 0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: contentPadding,
                      child: Column(
                        crossAxisAlignment: childrenAlignment,
                        children: children ?? [],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onCancel,
                    child: ReText(
                      value: cancelText,
                      style: actionStyle ??
                          AppStyle()
                              .titleMedium
                              .copyWith(color: AppColor.accent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
