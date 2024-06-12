import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile_shop_app/models/rating_model.dart';

class RatingScreen extends StatelessWidget{
  const RatingScreen({super.key, required this.rating});

  final RatingModel rating;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${rating.ten} ', style: const TextStyle(fontSize: 16),),
              Text('${rating.ngay.toDate()}', style: const TextStyle(fontSize: 13),),
            ],
          ),
          const SizedBox(height: 10.0,),
          RatingBar.builder(
            initialRating: rating.soSao,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            ignoreGestures: true,
            itemCount: 5,
            itemSize: 16.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating){},
          ),
          const SizedBox(height: 15.0),
          TextField(
            enabled: false,
            controller: TextEditingController(text: rating.noiDung),
            minLines: 1,
            maxLines: 5,
            decoration: const InputDecoration(
              label: Text("Nội dung"),
              border: OutlineInputBorder(),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}