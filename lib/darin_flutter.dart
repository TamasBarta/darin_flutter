library darin_flutter;

import 'package:darin/darin.dart';
import 'package:flutter/widgets.dart';

class Darin extends InheritedWidget {
  Darin({
    Key? key,
    required this.scope,
    required WidgetBuilder builder,
  }) : super(key: key, child: Builder(builder: builder));

  final Scope scope;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static Scope scopeOf(BuildContext context) {
    final darinWidget = context.dependOnInheritedWidgetOfExactType<Darin>();
    if (darinWidget == null) {
      throw Exception(
          "The Darin widget cannot be found in the current context.");
    }
    return darinWidget.scope;
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

  static Scope newScopeOf<T>(BuildContext context, T target) =>
      scopeOf(context).scope(target);

  static Scope Function() newScopeProviderOf<T>(
          BuildContext context, T target) =>
      scopeOf(context).scopeProvider(target);
}

extension DarinContext on BuildContext {
  Scope darinScope() => Darin.scopeOf(this);

  T darinGet<T>({dynamic qualifier}) => Darin.get(this, qualifier: qualifier);

  T Function() darinGetProvider<T>({dynamic qualifier}) =>
      Darin.getProvider(this, qualifier: qualifier);

  T darinGetMap<T extends Map>({dynamic qualifier}) =>
      Darin.getMap(this, qualifier: qualifier);

  T darinGetSet<T extends Set>({dynamic qualifier}) =>
      Darin.getSet(this, qualifier: qualifier);

  Scope newDarinScope<T>(T target) => Darin.newScopeOf(this, target);

  Scope Function() newDarinScopeProvider<T>(T target) =>
      Darin.newScopeProviderOf(this, target);
}
