import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:my_web_app/feature/sale/page/sale_mobile_view.dart';
import 'package:my_web_app/feature/sale/page/sale_tablet_view.dart';
import 'package:my_web_app/feature/sale/page/sale_desktop_view.dart';

class SaleView extends StatelessWidget {
  const SaleView({super.key});

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final width = MediaQuery.of(context).size.width;
    print(width);

    if (breakpoints.isMobile) {
      return const MobileView();
    } else if (breakpoints.isTablet) {
      return const TabletView();
    } else {
      return const DesktopView();
    }
  }
}
