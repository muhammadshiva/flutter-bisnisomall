import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()){
    on<AuthenticationEvent>(onAuthenticationEvent);
  }

    final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  final UserRepository _userRepository = UserRepository();
  User user;

  onAuthenticationEvent(AuthenticationEvent event, Emitter<AuthenticationState> emit)async{
    if (event is AppStarted) {
      final bool hasToken = await authenticationRepository.hasToken();
      if (hasToken) {
        try {
          final UserResponse userResponse = await _userRepository.fetchUser();
          user = userResponse.data;
          emit(AuthenticationAuthenticated(user: userResponse.data)) ;
        } catch (error) {
          emit(AuthenticationFailure(message: error.toString())) ;
          await Future.delayed(Duration(milliseconds: 3000));
          emit(AuthenticationUnauthenticated()); 
        }
      } else {
        emit(AuthenticationUnauthenticated()) ;
      }
    }

    if (event is SignedIn) {
      emit(AuthenticationLoading()) ;
      try {
        await authenticationRepository.persistToken(event.token);
        final UserResponse userResponse = await _userRepository.fetchUser();
        user = userResponse.data;
        emit(AuthenticationAuthenticated(user: userResponse.data)) ;
      } catch (error) {
        emit(AuthenticationFailure(message: error.toString())) ;
        await Future.delayed(Duration(milliseconds: 3000));
        emit(AuthenticationUnauthenticated()) ;
      }
    }

    if (event is OtpRequested) {
      emit(AuthenticationOtpUnauthenticated(
          phoneNumber: event.phoneNumber, timeout: event.otpTimeout)) ;
    }

    if (event is SignedOut) {
      emit(AuthenticationLoading());
      await authenticationRepository.deleteToken();
      await Future.delayed(Duration(milliseconds: 1000));
      emit(AuthenticationUnauthenticated()) ;
    }

    if (event is SetUserData) {
      user = event.user;
    }
  }


}
