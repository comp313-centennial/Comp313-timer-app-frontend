import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocScreen<B extends Bloc<dynamic, S>, S> extends StatelessWidget {
  final B bloc;
  final BlocBuilderCondition<S> builderCondition;
  final BlocWidgetBuilder<S> builder;

  final BlocListenerCondition<S> listenerCondition;
  final BlocWidgetListener<S> listener;

  BlocScreen({
    this.bloc,
    this.builderCondition,
    @required this.builder,
    this.listenerCondition,
    @required this.listener,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listenWhen: listenerCondition,
      listener: listener,
      cubit: bloc,
      child: BlocBuilder<B, S>(
        cubit: bloc,
        buildWhen: builderCondition,
        builder: builder,
      ),
    );
  }
}
