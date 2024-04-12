// ignore_for_file: public_member_api_docs, sort_constructors_first
// it's is an object but what it does is it internally contains two mainly function
// pointers, so what it does is that we create this loading controller so that our
// loading screen itself can contain a copy of this loading screen controller and
// if we already display loading screen to the user then the loading screen is gonna
// contain a copy of this loading screen controller and that is the way our loading
// screen will know that it's already displayed on the screen and once this loading
// controller is obtained by our loading screen then our loading screen just say

// this is a function that just return a boolean that indicate for instance
// if it was successful or not
import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;
  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}
// loading screen controller is not an actual controller that has any logic in it
// it's really just a token that will be returned by the loading screen in component
// itself internally when we from outside call show or hide methods on it


// when you show the loading screen first time the loading experience is then going
// to create an instance of loading screen controller internally and hold onto it, then
// the next time you tell the loading screen to show but with a different text 
// all that loading screen is going to do is just to call the update function
// internally on its loading screen controller instance with which it holds 
// internally and the update function will then update the loading screen overlay
