import 'package:bingocaller/assets/Utils/app_styles.dart';
import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSnackBar(
      BuildContext context, String message, IconData icon) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.accent,
          ),
          const SizedBox(width: 8),
          Text(message),
        ],
      ),
    ));
  }
}
