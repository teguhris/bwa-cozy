import 'package:bwa_cozy/models/space.dart';
import 'package:bwa_cozy/pages/error_page.dart';
import 'package:bwa_cozy/theme.dart';
import 'package:bwa_cozy/widgets/facility_item.dart';
import 'package:bwa_cozy/widgets/rating_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {

  final Space space;
  DetailPage(this.space);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isWishlistClicked = false;

  @override
  Widget build(BuildContext context) {

    void launchUrl(String url) async => await canLaunch(url) ? await launch(url) : Navigator.push(context, MaterialPageRoute(builder: (context)=>ErrorPage()));

    Future<void> _showAlertDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Konfirmasi',
              style: blackTextStyle.copyWith(
                fontSize: 22
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Apakah anda ingin menghubungi pemilik kos ?',
                    style: greyTextStyle
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Batal',
                  style: purpleTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Hubungi',
                  style: purpleTextStyle,
                ),
                onPressed: () {
                  launchUrl('tel:${widget.space.phone}');
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.network(
              widget.space.imageUrl,
              width: MediaQuery.of(context).size.width,
              height: 350,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                SizedBox(height: 328,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      //Note: Title
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.space.name,
                                  style: blackTextStyle.copyWith(
                                    fontSize: 22
                                  ),
                                ),
                                SizedBox(height: 2,),
                                Text.rich(
                                  TextSpan(
                                      text: '\$${widget.space.price}',
                                      style: purpleTextStyle.copyWith(
                                          fontSize: 16
                                      ),
                                      children: [
                                        TextSpan(
                                            text: ' / month',
                                            style: greyTextStyle.copyWith(
                                                fontSize: 16
                                            )
                                        )
                                      ]
                                  ),

                                ),
                              ],
                            ),
                            Row(
                              children: [1,2,3,4,5].map((index){
                                return Container(
                                  margin: EdgeInsets.only(left: 2),
                                  child: RatingItem(
                                    index: index,
                                    rating: widget.space.rating,
                                  ),
                                );
                              }).toList()
                            ),
                          ],
                        )
                      ),
                      //Note: Main Facilities
                      SizedBox(height: 30,),
                      Padding(
                        padding: EdgeInsets.only(
                            left: edge
                        ),
                        child: Text(
                          'Main Facilities',
                          style: regularTextStyle.copyWith(
                              fontSize: 16
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FacilityItem(
                              total: widget.space.numberOfKitchens,
                              name: 'kitchen',
                              imageUrl: 'assets/kitchen-icon.png',
                            ),
                            FacilityItem(
                              total: widget.space.numberOfBedrooms,
                              name: 'bedroom',
                              imageUrl: 'assets/bed-icon.png',
                            ),
                            FacilityItem(
                              total: widget.space.numberOfCupboards,
                              name: 'Big Lemari',
                              imageUrl: 'assets/cupboard-icon.png',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //Note: Photos
                      Padding(
                        padding: EdgeInsets.only(
                            left: edge
                        ),
                        child: Text(
                          'Photos',
                          style: regularTextStyle.copyWith(
                              fontSize: 16
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12
                      ),
                      Container(
                        height: 88,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: widget.space.photos.map((item){
                            return Container(
                              margin: EdgeInsets.only(left: 24),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  item,
                                  width: 110,
                                  height: 88,
                                  fit: BoxFit.cover,

                                ),
                              ),
                            );
                          }).toList(),
                          // children: [
                          //   SizedBox(width: edge,),
                          //   Image.asset(
                          //     'assets/photo1.png',
                          //     width: 110,
                          //     height: 88,
                          //     fit: BoxFit.cover,
                          //   ),
                          //   SizedBox(width: 18,),
                          //   Image.asset(
                          //     'assets/photo2.png',
                          //     width: 110,
                          //     height: 88,
                          //     fit: BoxFit.cover,
                          //   ),
                          //   SizedBox(width: 18,),
                          //   Image.asset(
                          //     'assets/photo3.png',
                          //     width: 110,
                          //     height: 88,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ],
                        )
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //Note: Photos
                      Padding(
                        padding: EdgeInsets.only(
                            left: edge
                        ),
                        child: Text(
                          'Location',
                          style: regularTextStyle.copyWith(
                              fontSize: 16
                          ),
                        ),
                      ),
                      SizedBox(height: 6,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: edge
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${widget.space.address}\n${widget.space.city}',
                                style: greyTextStyle
                            ),
                            InkWell(
                              onTap: (){
                                // launchUrl('https://goo.gl/maps/koFSjmDyF182soBV6');
                                launchUrl(widget.space.mapUrl);
                              },
                              child: Image.asset(
                                'assets/location.png',
                                width: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: edge
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width - (2 * edge),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                          ),
                          onPressed: (){
                            _showAlertDialog();
                          },
                          color: purpleColor,
                          child: Text(
                            'Book Now',
                            style: whiteTextStyle.copyWith(
                              fontSize: 18
                            ),
                          ),
                        )
                      ),
                      SizedBox(height: 40,)
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: edge,
                  vertical: 30
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/btn_back.png',
                      width: 40,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _isWishlistClicked = ! _isWishlistClicked;
                      });
                    },
                    child: Image.asset(
                      _isWishlistClicked ? 'assets/btn_wishlist_true.png' : 'assets/btn_wishlist.png',
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
