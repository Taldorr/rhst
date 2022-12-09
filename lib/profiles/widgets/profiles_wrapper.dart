import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhst/profiles/bloc/profiles_bloc.dart';
import 'package:rhst/profiles/repositories/profiles_repository.dart';

class ProfilesWrapper extends StatelessWidget {
  final Widget child;
  const ProfilesWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProfilesRepository(),
      child: BlocProvider(
        create: (context) => ProfilesBloc(RepositoryProvider.of<ProfilesRepository>(context))
          ..add(const LoadProfilesEvent()),
        child: child,
      ),
    );
  }
}
