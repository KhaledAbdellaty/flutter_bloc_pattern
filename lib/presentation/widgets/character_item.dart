import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/constants/strings.dart';
import 'package:flutter_breaking/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel character;

  const CharacterItem({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: ()=> Navigator.pushNamed(context, characterDetailsScreen, arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MyColors.myGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.png'),
            ),
          ),
          footer: Container(
            color: Colors.black54,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            child: Text(
              character.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                height: 1.3,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: MyColors.myWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
