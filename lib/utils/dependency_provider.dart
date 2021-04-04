import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:timer_app/blocs/auth/auth_bloc.dart';
import 'package:timer_app/blocs/navigation/navigation_bloc.dart';
import 'package:timer_app/data/user_repo.dart';

// ignore: must_be_immutable
class DependencyProvider extends InheritedWidget {
  UserRepo _userRepo;
  AuthBloc _authBloc;
  NavigationBloc _navigationBloc;


  UserRepo get userRepo {
    if (_userRepo == null) {
      _userRepo = UserRepo();
    }
    return _userRepo;
  }

  AuthBloc get authBloc {
    if (_authBloc == null) {
      _authBloc = AuthBloc(
        userRepo: userRepo,
        navigationBloc: navigationBloc,
      );
    }
    return _authBloc;
  }

  NavigationBloc get navigationBloc {
    if (_navigationBloc == null) {
      _navigationBloc = NavigationBloc();
    }
    return _navigationBloc;
  }

  DependencyProvider({Key key, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  static DependencyProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
  }

  dispose() {
    _authBloc?.close();
    _navigationBloc?.close();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
