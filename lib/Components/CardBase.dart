import 'package:event_app/Components/BlurredContainer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardBase extends StatelessWidget {
  NetworkImage image;
  bool hasFirstBlurredContainer;
  bool hasSecondBlurredContainer;
  List<Widget> firstBlurredContainer;
  List<Widget> secondBlurredContainer;
  String title;
  String description;
  String address;
  double width;
  Color descriptionColor;
  Function firstBlurredContainerOnTap;
  Function secondBlurredContainerOnTap;
  Function cardOnTap;

  CardBase({
    Key key,
    this.image,
    this.hasFirstBlurredContainer = false,
    this.hasSecondBlurredContainer = false,
    this.firstBlurredContainer,
    this.secondBlurredContainer,
    this.title,
    this.description,
    this.address,
    this.width,
    this.descriptionColor = const Color(0xff3F38DD),
    this.secondBlurredContainerOnTap,
    this.firstBlurredContainerOnTap,
    this.cardOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardOnTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 20, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18)
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    width: double.infinity,
                    height: 180,
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
                if (hasFirstBlurredContainer) Positioned(
                  top: 8,
                    left: 8,
                    child: BlurredContainer(
                      onTap: firstBlurredContainerOnTap,
                      children: firstBlurredContainer,
                    )
                ),
                if(hasSecondBlurredContainer) Positioned(
                    top: 8,
                    right: 8,
                    child: BlurredContainer(
                      onTap: secondBlurredContainerOnTap,
                      children: secondBlurredContainer,
                    )
                ),
              ],
            ),
            const SizedBox(height: 15,),
            SizedBox(
              width: double.infinity,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
              width: double.infinity,
              child: Text(
                description,
                style: TextStyle(
                  color: descriptionColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              children: [
                const Icon(FontAwesomeIcons.locationDot, color: Colors.grey,),
                const SizedBox(width: 5,),
                Text(
                  address,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
