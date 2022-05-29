import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/characters_cubit.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<CharacterModel>? allCharacters;
  List<CharacterModel>? searchedCharactersList;
  final searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildCharacterList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: searchController.text.isEmpty
          ? allCharacters!.length
          : searchedCharactersList!.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: searchController.text.isEmpty
              ? allCharacters![index]
              : searchedCharactersList![index],
        );
      },
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharacterList(),
          ],
        ),
      ),
    );
  }

  Widget  buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Center showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  void getSearchedCharacters(String searchedCharacters) {
    searchedCharactersList = allCharacters!
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacters))
        .toList();
    setState(() {});
  }

  Widget searchTextField() {
    return TextFormField(
      controller: searchController,
      onChanged: (searchedCharacter) {
        getSearchedCharacters(searchedCharacter);
      },
      decoration: const InputDecoration(
        hintText: 'search here ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey),
      ),
      cursorColor: MyColors.myGrey,
      style: const TextStyle(
          color: MyColors.myGrey, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear_outlined,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search_outlined, color: MyColors.myGrey),
        ),
      ];
    }
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _stopSearching),
    );
    setState(() {
      _isSearching = true;
    });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 23,
                color: MyColors.myGrey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/warning.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? searchTextField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        leading: _isSearching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult value,
          Widget child,
        ) {
          final bool connected = value != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
