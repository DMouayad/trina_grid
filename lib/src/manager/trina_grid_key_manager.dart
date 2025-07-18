import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:rxdart/rxdart.dart';

/// 2021-11-19
/// Temporary code due to KeyEventResult.skipRemainingHandlers operation error
/// After issue resolution: Delete
///
/// Occurs only on desktop
/// When returning skipRemainingHandlers, the FocusScope callback in trina_grid.dart
/// is not called and key inputs should go to TextField, but
/// arrow keys, backspace, etc. are not input (characters are input normally)
/// https://github.com/flutter/flutter/issues/93873
class TrinaGridKeyEventResult {
  bool _skip = false;

  bool get isSkip => _skip;

  KeyEventResult skip(KeyEventResult result) {
    _skip = true;

    return result;
  }

  KeyEventResult consume(KeyEventResult result) {
    if (_skip) {
      _skip = false;

      return KeyEventResult.ignored;
    }

    return result;
  }
}

class TrinaGridKeyManager {
  TrinaGridStateManager stateManager;

  TrinaGridKeyEventResult eventResult = TrinaGridKeyEventResult();

  TrinaGridKeyManager({
    required this.stateManager,
  });

  final PublishSubject<TrinaKeyManagerEvent> _subject =
      PublishSubject<TrinaKeyManagerEvent>();

  PublishSubject<TrinaKeyManagerEvent> get subject => _subject;

  late final StreamSubscription _subscription;

  StreamSubscription get subscription => _subscription;

  void dispose() {
    _subscription.cancel();

    _subject.close();
  }

  void init() {
    final normalStream = _subject.stream.where((event) => !event.needsThrottle);

    final movingStream =
        _subject.stream.where((event) => event.needsThrottle).transform(
              ThrottleStreamTransformer(
                // ignore: void_checks
                (e) => TimerStream(e, const Duration(milliseconds: 1)),
              ),
            );

    _subscription = MergeStream([normalStream, movingStream]).listen(_handler);
  }

  void _handler(TrinaKeyManagerEvent keyEvent) {
    if (keyEvent.isKeyUpEvent) return;

    if (stateManager.configuration.shortcut.handle(
      keyEvent: keyEvent,
      stateManager: stateManager,
      state: HardwareKeyboard.instance,
    )) {
      return;
    }

    _handleDefaultActions(keyEvent);
  }

  void _handleDefaultActions(TrinaKeyManagerEvent keyEvent) {
    // If a modifier key is pressed, only allow shift.
    final hasAllowedModifier =
        !keyEvent.isModifierPressed || keyEvent.isShiftPressed;

    if (keyEvent.isCharacter && hasAllowedModifier) {
      _handleCharacter(keyEvent);
    }
  }

  void _handleCharacter(TrinaKeyManagerEvent keyEvent) {
    if (stateManager.isEditing || stateManager.currentCell == null) {
      return;
    }

    stateManager.setEditing(true);

    // In the case of a character, the character is immediately entered into the TextField.
    // This is because the editing state is changed to true
    // and the widget is rebuilt in the next frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // We need to wait for the next event loop to ensure that the text field
      // is fully initialized and has handled its default focus behavior
      // (which can select all text).
      Future.delayed(Duration.zero, () {
        final controller = stateManager.textEditingController;
        final character = keyEvent.event.character;

        // If the state has changed back before this future runs, do nothing.
        if (controller == null ||
            character == null ||
            character.isEmpty ||
            !stateManager.isEditing) {
          return;
        }

        controller.text = character;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      });
    });
  }
}
