import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/characters_cubit.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/data/repository/characters_repository.dart';
import 'package:flutter_breaking/data/services/character_services.dart';
import 'package:flutter_breaking/presentation/screens/characters_screen.dart';

import 'constants/strings.dart';
import 'presentation/screens/character_details_screen.dart';

class AppRouter {
  CharactersCubit? charactersCubit;
  CharactersRepository? charactersRepository;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersServices());
    charactersCubit = CharactersCubit(charactersRepository!);
  }

  Route? generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit!,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context)=>CharactersCubit(charactersRepository!),
            child: CharacterDetailsScreen(character: character,) ,
          ),
        );
    }
  }
}
