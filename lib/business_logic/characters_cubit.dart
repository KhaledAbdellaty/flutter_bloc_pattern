import 'package:bloc/bloc.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  List<CharacterModel> characters = [];

  List<CharacterModel> getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters){
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
