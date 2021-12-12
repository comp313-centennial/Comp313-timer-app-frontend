import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timer_app/blocs/navigation/bloc.dart';
import 'package:meta/meta.dart';
import 'package:timer_app/common/constants.dart';
import 'package:timer_app/data/user_repo.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepo userRepo;
  final NavigationBloc navigationBloc;

  AuthBloc({
    @required this.userRepo,
    @required this.navigationBloc,
  }) : super(AuthUninitializedState());

  logout() {
    add(LoggedOutEvent());
  }

  login(User user) {
    add(LoggedInEvent(user: user));
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartedEvent) {
      yield* _handleAppStarted(event);
    } else if (event is LoggedInEvent) {
      yield* _handleLoggedIn(event);
    } else if (event is LoggedOutEvent) {
      yield* _handleLoggedOut(event);
    }
  }

  Stream<AuthState> _handleAppStarted(AppStartedEvent event) async* {
    final bool isUserLoggedIn = await userRepo.isLoggedIn();
    if (isUserLoggedIn) {
      globalFirebaseUser = userRepo.user;
      globalUser = await userRepo.getUserFromDb(globalFirebaseUser.email);
      yield AuthAuthenticatedState(userRepo.user);
    } else {
      yield AuthUnauthenticatedState();
    }
  }

  Stream<AuthState> _handleLoggedIn(LoggedInEvent event) async* {
    navigationBloc.goToHome(event.user);
    yield AuthAuthenticatedState(event.user);
  }

  Stream<AuthState> _handleLoggedOut(LoggedOutEvent event) async* {
    await userRepo.logout();
    navigationBloc.goToLogin();
    yield AuthUnauthenticatedState();
  }
}
