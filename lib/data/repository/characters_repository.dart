import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/data/services/character_services.dart';

class CharactersRepository{
  final CharactersServices charactersServices;

  CharactersRepository(this.charactersServices);


  Future<List<CharacterModel>> getAllCharacters()async{
    final characters = await charactersServices.getAllCharacters();
    return characters.map((character)=> CharacterModel.fromJson(character)).toList();

  }
}