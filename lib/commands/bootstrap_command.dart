import 'package:app/commands/abstrack_command.dart';
import 'package:app/models/AppModel.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BootstrapCommand extends AbstractCommand {
  BootstrapCommand(BuildContext context) : super(context);

  Future<bool> execute() async {
    /// Let the splash view sit for a bit. Mainly for aesthetics and to ensure a smooth intro animation.
    /// Set minimal Window size
    await DesktopWindow.setWindowSize(const Size(800,700));
    await DesktopWindow.setMinWindowSize(const Size(750, 680));
    await DesktopWindow.setMaxWindowSize(const Size(1200, 800));

    /// Handle version upgrades
    if (appModel.version != AppModel.kCurrentVersion) {
      appModel.upgradeToVersion(AppModel.kCurrentVersion);
    }

    /// After we've loaded the models, kickoff an auth-token refresh, our old one is likely expired.
    bool signInError = false;
      /// Try and refresh authKey and Contacts.
      if (kIsWeb) {
        // On web, perform a silentSignIn to refresh the OAuth token
      } else {
        // On desktop, refresh the authToken manually
      }
      // Load contacts
      // Check that both the authCall and contactsLoad was successful
      signInError = true;
    return signInError;
  }
}
