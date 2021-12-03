[![Flutter](https://github.com/TamasBarta/darin_flutter/actions/workflows/flutter.yml/badge.svg?branch=main)](https://github.com/TamasBarta/darin_flutter/actions/workflows/flutter.yml)

Flutter inherited widget for Darin scopes.

## Features

For features of Darin, and the explanation of the concept, see the main package: [https://github.com/TamasBarta/darin](Darin)

## Getting started

Import the package (published to pub.dev soon):

```yml
dependencies:
  darin_flutter:
    git: https://github.com/TamasBarta/darin_flutter.git
```

## Usage

You can use the `Darin` inherited widget to pass scopes down the widget tree. Down the tree you can then get objects with their dependencies resolved, and new scopes with new `Darin` inherited widgets.

```dart
// Declare your modules
final exampleModule = Module(
  (module) => module
    ..factory((module) => MyFeatureScreen(module.get()),
);

// Concat all your modules from all your packages, if you have multiple
compileModules() => Module.fromModules(
      [
        exampleModule,
      ],
    );

// Wrap your application widgets in a `Darin` widget, do you can query
// objects down the tree
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Darin(
      module: compileModules(),
      // `Builder` is used, so `builderContext` already can be used
      // for widget inheritance, so Darin is already available here
      child: Builder(
        builder: (builderContext) => MaterialApp(
          title: 'Darin Demo',
          ... 
        ),
      ),
    );
  }
}

// And somewhere lower in the widget tree, you can obtain objects,
// or create new scopes.
Widget build(BuidlContext context) {
  return Text(context.darinGet(qualifier: "MyStringTitle"))
}

// Use can use `.of()` style static functions as well instead of
// the extension methods on `BuildContext`.
Widget build(BuidlContext context) {
  return Text(Darin.get(context, qualifier: "MyStringTitle"))
}
```
