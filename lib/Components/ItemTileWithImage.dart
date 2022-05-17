import 'package:event_app/Components/BaseContainer.dart';
import 'package:flutter/material.dart';

class ItemTileWithImage extends StatelessWidget {
  ItemTileWithImage({
    Key key,
    this.description,
    this.subtitle,
    this.title,
    this.onTap,
    this.image,
  }) : super(key: key);

  String title;
  String description;
  String subtitle;
  Function onTap;
  ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      height: 100,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    image: image,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Center(
                          child:const Text('😢', style: TextStyle(fontSize: 75),)
                      );
                    },
                  ),
                ),
              )
            ),
            Column(
              mainAxisAlignment: subtitle == null ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(title !=null)Text(
                    title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if(subtitle == null) SizedBox(height: 10,),
                if(description != null )Text(
                    description,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if(subtitle != null) Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
