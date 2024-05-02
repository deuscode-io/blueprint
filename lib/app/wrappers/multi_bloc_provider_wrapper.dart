import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/features/authentication/cubits/authentication_cubit.dart';
import 'package:blueprint/features/profile/blocs/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocProviderWrapper extends StatelessWidget {
  const MultiBlocProviderWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: Injector.get<AuthenticationCubit>()),
        BlocProvider.value(value: Injector.get<ProfileBloc>()),
      ],
      child: child,
    );
  }
}
