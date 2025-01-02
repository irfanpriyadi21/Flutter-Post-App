import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_pos_app/data/datasources/auth_remote_datasource.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource _authRemoteDatasource;
  LogoutBloc(
    this._authRemoteDatasource
  ) : super(_Initial()) {
    on<_Logout>((event, emit)async {
      final result = await _authRemoteDatasource.logout();
      result.fold(
        (l) => emit(LogoutState.error(l)),
        (r) => emit(const LogoutState.success())
      );
    });
  }
}
