import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos_app/core/constants/colors.dart';
import 'package:mobile_pos_app/data/datasources/auth_local_datasource.dart';
import 'package:mobile_pos_app/data/datasources/product_local_datasource.dart';
import 'package:mobile_pos_app/presentation/auth/page/login_page.dart';
import 'package:mobile_pos_app/presentation/home/bloc/logout/logout_bloc.dart';
import 'package:mobile_pos_app/presentation/home/bloc/product/product_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: (){},
                success:(_)async{
                 await ProductLocalDatasource.instance.removeAllProduct(); 
                 await ProductLocalDatasource.instance.insertAllProduct(_.product.toList());
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Text("Sync Data Success")
                  )
                 );
                } 
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: (){
                  return ElevatedButton(onPressed: (){
                    context.read<ProductBloc>().add(const ProductEvent.fetch());
                  }, child: Text("Sync Data"));
                },
                loading: (){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              );
          
            },
          ),
          Divider(),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: (){},
                success: (_){
                  AuthLocalDatasource().removeAuthData();
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const LoginPage())
                  );
                }
              );
            },
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  child: Text("Logout"));
            },
          ),
        ],
      ),
    );
  }
}