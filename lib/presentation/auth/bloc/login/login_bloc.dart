import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:mobile_pos_app/data/datasources/auth_remote_datasource.dart';
import 'package:mobile_pos_app/data/models/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;
  LoginBloc( 
    this.authRemoteDatasource
    ) : super(_Initial()) {
    on<_Login>((event, emit) async{
      emit(const _Loading());
      final response = await authRemoteDatasource.login(
        event.email, 
        event.password
      );
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r))
      );
    });
  }
}
