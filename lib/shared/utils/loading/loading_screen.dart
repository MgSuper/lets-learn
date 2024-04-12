// step_8
import 'dart:async';
import 'package:boost_e_skills/shared/utils/loading/loading_screen_controller.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  // create singleton for this one
  // singleton pattern
  LoadingScreen._sharedInstance(); // this like an internal constructor
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared; // whoever call loading screen
  // they get an instance of loading screen as a shared instance

  // there should absolutely be no way for you to be able to create another loading
  // screen in your flutter application. can only be displayed on the screen one time
  // means there can only be one instance of loading screen at any possible time in
  // the duration of the application

  LoadingScreenController? _controller;

  // for the outside world who ever wants to display overlay is gonna call this
  // function.
  // but we are going to internally call the show overlay function
  void show({required BuildContext context, required String text}) {
    // if we have no controller false is producion here
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(context: context, text: text);
    }
  }

  void hide() {
    // if controller avaiable, then close it
    _controller?.close();
    // this controller doesn't exist anymore
    _controller = null;
  }

  LoadingScreenController _showOverlay(
      {required BuildContext context, required String text}) {
    final txt = StreamController<String>();
    txt.add(text);

    // get the size
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    // create overlay entry
    final overlay = OverlayEntry(
      builder: ((context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      StreamBuilder<String>(
                        stream: txt.stream,
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
    // how to insert the overlay on the screen
    state.insert(overlay);
    // how do we now go ahead and create the loading screen controller
    return LoadingScreenController(close: () {
      txt.close();
      overlay.remove();
      return true;
    }, update: (text) {
      txt.add(text);
      return true;
    });
  }
}
