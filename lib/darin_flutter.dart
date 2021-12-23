library darin_flutter;

import 'package:darin/darin.dart';
import 'package:flutter/material.dart';

class Darin extends InheritedWidget {
  const Darin({
    Key? key,
    required this.module,
    required Widget child,
  }) : super(key: key, child: child);

  final Module module;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static Module scopeOf(BuildContext context) {
    final darinWidget = context.dependOnInheritedWidgetOfExactType<Darin>();
    if (darinWidget == null) {
      throw Exception(
          "The Darin widget cannot be found in the current context.");
    }
    return darinWidget.module;
  }

  static T get<T>(BuildContext context, {dynamic qualifier}) =>
      scopeOf(context).get<T>(qualifier: qualifier);

  static T Function() getProvider<T>(BuildContext context,
          {dynamic qualifier}) =>
      scopeOf(context).getProvider(qualifier: qualifier);

  static T getMap<T extends Map>(BuildContext context, {dynamic qualifier}) =>
      scopeOf(context).getMap<T>(qualifier: qualifier);

  static T getSet<T extends Set>(BuildContext context, {dynamic qualifier}) =>
      scopeOf(context).getSet<T>(qualifier: qualifier);

  static Module newScopeOf<T>(BuildContext context, T target) =>
      scopeOf(context).scope(target);
}

extension DarinContext on BuildContext {
  Module darinScope() => Darin.scopeOf(this);

  T darinGet<T>({dynamic qualifier}) => Darin.get(this, qualifier: qualifier);

  T Function() darinGetProvider<T>({dynamic qualifier}) =>
      Darin.getProvider(this, qualifier: qualifier);

  T darinGetMap<T extends Map>({dynamic qualifier}) =>
      Darin.getMap(this, qualifier: qualifier);

  T darinGetSet<T extends Set>({dynamic qualifier}) =>
      Darin.getSet(this, qualifier: qualifier);

  Module newDarinScope<T>(T target) => Darin.newScopeOf(this, target);
}
