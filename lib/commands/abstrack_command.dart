import 'package:app/globals.dart';
import 'package:app/models/AppModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class AbstractCommand {
  static BuildContext? _lastKnownRoot;

  /// Provide all commands access to the global context & navigator
  late BuildContext context;

  NavigatorState? get rootNav => AppGlobals.nav;

  AbstractCommand(BuildContext c) {
    /// Get root context
    /// If we're passed a context that is known to be root, skip the lookup, it will throw an error otherwise.
    context = (c == _lastKnownRoot) ? c : Provider.of(c, listen: false);
    _lastKnownRoot = context;
  }

  T getProvided<T>() => Provider.of<T>(context, listen: false);

  /// Convenience lookup methods for all commands to share
  ///
  /// Models
  AppModel get appModel => getProvided();

  /// Services
}

/// //////////////////////////////////////////////////////////////////
/// MIX-INS
/// //////////////////////////////////////////////////////////////////

mixin CancelableCommandMixin on AbstractCommand {
  bool isCancelled = false;

  bool cancel() => isCancelled = true;
}