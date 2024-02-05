import 'package:flutter/material.dart';
import 'package:hexatour/src/views/screens/home/islamic/charity/charity_container.dart';

class FruitDatesPage extends StatefulWidget {
 
final String? id;

  final String? description;

  FruitDatesPage({
    Key? key,
    required this.id,
   
    // required this.imagepath,
    this.description,

    //  this.price,
  }) : super(key: key);
  @override
  State<FruitDatesPage> createState() => _FruitDatesPageState();
}

class _FruitDatesPageState extends State<FruitDatesPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameControl = TextEditingController();
    TextEditingController hotelControl = TextEditingController();
    TextEditingController roomControl = TextEditingController();
    TextEditingController mobileControl = TextEditingController();
    String setTime = '';
    TextEditingController unitControl = TextEditingController();

    List<String> images = [
     'https://tse4.mm.bing.net/th?id=OIP.GuxEoQ4eJBtuxRHMb1sEcQHaFO&pid=Api&P=0&h=180',
     'https://tse4.mm.bing.net/th?id=OIP.GuxEoQ4eJBtuxRHMb1sEcQHaFO&pid=Api&P=0&h=180',
     'https://tse4.mm.bing.net/th?id=OIP.GuxEoQ4eJBtuxRHMb1sEcQHaFO&pid=Api&P=0&h=180'
    ];
    return CharityContainer(
      id: widget.id,
      description:  widget.description,
      nameControl: nameControl,
      hotelControl: hotelControl,
      roomControl: roomControl,
      mobileControl: mobileControl,
      unitControl: unitControl,
      onSelect: (time) {
        setTime = time;
      },
      images: images,
      onTap: () {
        print(setTime);
        print(unitControl.text);
      },
    );
    
  }
}
