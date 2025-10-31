import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:my_web_app/feature/sale/bloc/sale_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_state.dart';
import 'package:my_web_app/feature/sale/page/sale_view.dart';
import 'package:my_web_app/utils/theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SaleBloc(),
      child: BlocBuilder<SaleBloc, SaleState>(
        builder: (context, state) {
          return ShadApp(
            theme: AppTheme.lightMode,
            darkTheme: AppTheme.darkMode,
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: BouncingScrollWrapper.builder(context, child!),
              breakpoints: [
                Breakpoint(start: 0, end: 750, name: MOBILE),
                Breakpoint(start: 751, end: 1200, name: TABLET),
                Breakpoint(start: 1200, end: 1920, name: DESKTOP),
                Breakpoint(start: 1920, end: double.infinity, name: '4K'),
              ],
            ),
            home: const SaleView(),
          );
        },
      ),
    );
  }
}
