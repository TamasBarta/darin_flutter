library darin_flutter;

import 'package:darin/darin.dart';
import 'package:flutter/widgets.dart';

class Darin extends StatefulWidget {
  const Darin({Key? key, required this.builder, required this.scope})
      : super(key: key);

  final WidgetBuilder builder;
  final Scope scope;

  @override
  State<Darin> createState() => _DarinState();
}

class _DarinState extends State<Darin> {
  late Scope scope;

  @override
  Widget build(BuildContext context) {
    return DarinInheritance(scope: scope, builder: widget.builder);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scope = widget.scope;
  }
}

class DarinInheritance extends InheritedWidget {
  DarinInheritance({
    Key? key,
    required this.scope,
    required WidgetBuilder builder,
  }) : super(key: key, child: Builder(builder: builder));

  final Scope scope;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static Scope scopeOf(BuildContext context) {
    final darinWidget =
        context.dependOnInheritedWidgetOfExactType<DarinInheritance>();
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
  Scope darinScope() => DarinInheritance.scopeOf(this);

  T darinGet<T>({dynamic qualifier}) =>
      DarinInheritance.get(this, qualifier: qualifier);

  T Function() darinGetProvider<T>({dynamic qualifier}) =>
      DarinInheritance.getProvider(this, qualifier: qualifier);

  T darinGetMap<T extends Map>({dynamic qualifier}) =>
      DarinInheritance.getMap(this, qualifier: qualifier);

  T darinGetSet<T extends Set>({dynamic qualifier}) =>
      DarinInheritance.getSet(this, qualifier: qualifier);

  Scope newDarinScope<T>(T target) => DarinInheritance.newScopeOf(this, target);

  Scope Function() newDarinScopeProvider<T>(T target) =>
      DarinInheritance.newScopeProviderOf(this, target);
}
