import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_event.dart';
import 'package:my_web_app/feature/sale/bloc/sale_state.dart';
import 'package:my_web_app/feature/sale/page/login_signup.dart';
import 'package:my_web_app/feature/sale/widget/order_buttons.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HeaderView extends StatefulWidget {
  final bool showCartButton;
  final bool showDate;
  const HeaderView({
    super.key,
    this.showCartButton = false,
    this.showDate = false,
    required bool showBackButton,
  });

  @override
  State<HeaderView> createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView> {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isDeskTop = ResponsiveBreakpoints.of(context).isDesktop;
    final theme = ShadTheme.of(context).colorScheme;

    return Column(
      children: [
        const SizedBox(height: 4),
        Row(
          children: [
            // Builder(
            //   builder: (context) => IconButton(
            //     icon: const Icon(Icons.menu),
            //     onPressed: () => Scaffold.of(context).openDrawer(),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Text("9:41 Mon Jun 6"),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                },
                icon: const Icon(Icons.person),
              ),
            ),

            BlocBuilder<SaleBloc, SaleState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    final isCurrentlyDark = context
                        .read<SaleBloc>()
                        .state
                        .isDark;
                    context.read<SaleBloc>().add(
                      ThemeChangeEvent(!isCurrentlyDark),
                    );
                  },
                  icon: Icon(
                    context.read<SaleBloc>().state.isDark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                );
              },
            ),

            if (widget.showCartButton) ...[
              const SizedBox(width: 8),
              BlocBuilder<SaleBloc, SaleState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<SaleBloc>().add(ToggleCartViewEvent());
                    },
                    icon: Badge(
                      label: Text(state.cartItems.length.toString()),
                      child: const Icon(Icons.shopping_cart, size: 23),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
        // Main Content - This will wrap automatically
        Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Section
            Expanded(
              flex: 2,
              child: Row(
                spacing: isDeskTop ? 8 : 2,
                children: [
                  Padding(
                    padding: EdgeInsets.all(isDeskTop ? 10 : 4),
                    child: Text(
                      "AMA",
                      style: TextStyle(fontSize: isDeskTop ? 14 : 10),
                    ),
                  ),
                  Text(
                    "American Coffee",
                    style: TextStyle(
                      fontSize: isDeskTop ? 18 : 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  //if (isDeskTop)
                  Container(
                    child: Row(
                      spacing: isDeskTop ? 10 : 3,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDeskTop ? 13 : 5,
                          ),
                          width: isDeskTop ? 80 : 65,
                          height: 40,
                          decoration: BoxDecoration(
                            color: theme.primary,
                            border: Border.all(color: theme.primary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Open",
                                style: TextStyle(color: theme.foreground),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),

                        Icon(Icons.photo),
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            fontSize: isDeskTop ? 16 : 12,
                            color: theme.muted,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDeskTop ? 8 : 4,
                          ),
                          width: isDeskTop ? 80 : 70,
                          height: 40,
                          decoration: BoxDecoration(
                            color: theme.primary,
                            border: Border.all(color: theme.primary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            spacing: 3,
                            children: [
                              Icon(Icons.book),
                              Text(
                                "Menu",
                                style: TextStyle(color: theme.foreground),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (widget.showDate)
              Row(
                spacing: 10,
                children: [
                  //   SizedBox(width: 10),
                  const Icon(Icons.calendar_month_outlined, size: 18),
                  Text(
                    isMobile ? "27 Mar 2025" : "Wednesday, 27 Mar 2025 09:48",
                  ),
                ],
              ),
            //  Spacer(),
            // Right Section
            if (!isMobile)
              Container(
                //    flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: [
                      ReusableButton(label: "Refresh", icon: Icons.refresh),
                      ShadButton(
                        child: const Icon(Icons.wifi),
                        backgroundColor: theme.primary,
                        foregroundColor: theme.primaryForeground,
                        hoverBackgroundColor: theme.secondary,
                      ),
                      ShadButton(
                        child: const Icon(Icons.notifications_outlined),
                        backgroundColor: theme.primary,
                        foregroundColor: theme.primaryForeground,
                        hoverBackgroundColor: theme.secondary,
                      ),
                      ReusableButton(
                        label: "Bizer Alex",
                        icon: Icons.restaurant,

                        trailing: const Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
