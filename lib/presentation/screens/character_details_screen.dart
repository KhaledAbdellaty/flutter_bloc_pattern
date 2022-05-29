import 'package:flutter/material.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);
  final CharacterModel character;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickName,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          buildSliverList(),

        ],
      ),
    );
  }

  Widget characterInfo(String title, String info, double endIndent) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.myWhite,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: info,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.myWhite,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Divider(
          color: MyColors.myYellow,
          thickness: 2,
          endIndent: endIndent,
        ),
      ],
    );
  }

  SliverList buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                characterInfo('job : ', character.jobs.join(' / '), 250),
                character.betterCallSaulAppearance.isNotEmpty
                    ? characterInfo('Better Call Saul Appearance : ',
                        character.betterCallSaulAppearance.join(' / '), 250)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
