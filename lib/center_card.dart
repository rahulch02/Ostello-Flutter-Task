import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CenterCard extends StatelessWidget {
  late int _colleagues;
  late String _name;
  late String _location;
  late double _rating;
  late double _distance;
  late String _imageAsset;
  late List<String> _tags;
  late int _discount;

  CenterCard(this._colleagues, this._name, this._rating, this._distance,
      this._imageAsset, this._discount, this._tags, this._location);

  @override
  Widget build(BuildContext context) {
    return _colleagues != 0
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                  style: BorderStyle.solid, color: Colors.grey, width: 0.2),
              color: Color(0xFF7D23E0).withOpacity(0.08),
            ),
            height: 200,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      // boxShadow: [BoxShadow(offset: Offset(0, 0.5), blurRadius: 4)],
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.grey,
                          width: 0.6),
                      color: Colors.purple.withOpacity(0.03)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: Stack(
                      children: [
                        Container(
                          width: 140,
                          child: Image.network(
                            _imageAsset,
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 70),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Color(0xFF7D23E0), Colors.transparent],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                      size: 9,
                                    ),
                                    Text(
                                      _location,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.stars,
                                color: Colors.green,
                              ),
                              Text(
                                'Rating: ' +
                                    _rating.toString() +
                                    ' · ' +
                                    _distance.toString() +
                                    ' kms away',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Wrap(
                          runSpacing: 8,
                          spacing: 6,
                          children: [
                            for (final tag in _tags)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Color(0xFF7D23E0))),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xFF7D23E0)),
                                ),
                              ),
                            if (_discount != 0)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFF7D23E0)),
                                child: Text(
                                  _discount.toString() + '% OFF',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '· ' +
                          _colleagues.toString() +
                          ' of your schoolmates study here',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            alignment: Alignment.topCenter,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                // boxShadow: [BoxShadow(offset: Offset(0, 0.5), blurRadius: 4)],
                border: Border.all(
                    style: BorderStyle.solid, color: Colors.grey, width: 0.6),
                color: Colors.purple.withOpacity(0.12)),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              leading: Stack(
                children: [
                  Container(
                    width: 140,
                    child: Image.network(
                      _imageAsset,
                      fit: BoxFit.cover,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 70),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xFF7D23E0), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: 9,
                              ),
                              Text(
                                _location,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.stars,
                        color: Colors.green,
                      ),
                      Text(
                        'Rating: ' +
                            _rating.toString() +
                            ' · ' +
                            _distance.toString() +
                            ' kms away',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 13),
                      ),
                    ],
                  ),
                  Wrap(
                    runSpacing: 8,
                    spacing: 6,
                    children: [
                      for (final tag in _tags)
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Color(0xFF7D23E0))),
                          child: Text(
                            tag,
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF7D23E0)),
                          ),
                        ),
                      if (_discount != 0)
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFF7D23E0)),
                          child: Text(
                            _discount.toString(),
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        )
                    ],
                  )
                ],
              ),
              onTap: () {},
            ),
          );
  }
}
