import 'dart:io';

import 'package:app/_internal/no_glow_scroll_behavior.dart';
import 'package:app/commands/bootstrap_command.dart';
import 'package:app/globals.dart';
import 'package:app/models/AppModel.dart';
import 'package:app/styles.dart';
import 'package:app/themes.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/DribbbleMusicPlayer.dart';
import 'package:app/pages/Login.dart';
import 'package:provider/provider.dart';

void main() {
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppModel()),
        /// ROOT CONTEXT, Allows Commands to retrieve a 'safe' context that is not tied to any one view. Allows them to work on async tasks without issues.
        Provider<BuildContext>(create: (c) => c),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    context.read<AppModel>().load().then((value) async {
      print('--------');
      await BootstrapCommand(context).execute();
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    ThemeType themeType = context.select<AppModel, ThemeType>((value) => value.theme);
    AppTheme theme = AppTheme.fromType(themeType);

    return Provider.value(
      value: theme,
      child: MaterialApp(
        title: 'Ulanqab',
        debugShowCheckedModeBanner: false,
        navigatorKey: AppGlobals.rootNavKey,
        
        theme: theme.themeData,

        home: DribbbleMusicPlayer(),
        builder: (_, navigator) {
          if (navigator == null) return Container();
          // Wrap root page in a builder, so we can make initial responsive tweaks based on MediaQuery
          return Builder(builder: (c) {
            //Responsive: Reduce size of our gutter scale when we're below a certain size
            Insets.gutterScale = 1;
            // Disable all Material glow effects with [ NoGlowScrollBehavior ]
            return ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: navigator,
            );
          });
        },
      )
    );
  }
}