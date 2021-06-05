import 'package:bwa_cozy/models/tips.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:flutter/material.dart';

class TipsCard extends StatelessWidget {
  final Tips tips;

  TipsCard(this.tips);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
            tips.imageUrl,
          width: 80,
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tips.title,
              style: blackTextStyle.copyWith(
                fontSize: 18
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Updated ${tips.updatedAt}',
              style: greyTextStyle.copyWith(
                fontSize: 14
              ),
            )
          ],
        ),
        Spacer(),
        //Spacer Widget dipakai biar widget IconButton ada di ujung
        IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.chevron_right,
            color: greyColor,
          //  Kalau mau, bisa aja setting ukuran iconnya (size)
          //  Tapi karena ukuran default nya udah 24, jadi gaperlu lagi diatur
          ),
        )

      ],
    );
  }
}
