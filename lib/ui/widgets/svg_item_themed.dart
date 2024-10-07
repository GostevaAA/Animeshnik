import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconThemed extends StatelessWidget {
  const SvgIconThemed(this.asset, {super.key});

  final String asset;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);

    return SvgPicture.asset(
      asset,
      colorFilter: iconTheme.color == null
          ? null
          : ColorFilter.mode(iconTheme.color!, BlendMode.srcIn),
      width: iconTheme.size,
      height: iconTheme.size,
    );
  }
}
