// ignore_for_file: file_names, override_on_non_overriding_member, annotate_overrides, use_key_in_widget_constructors
//the card in nutrition chart screen
import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';

class TheMainCard extends StatefulWidget {
  final String heading;
  final String author;
  final String imageUrl;
  const TheMainCard(
      {required this.heading, required this.author, required this.imageUrl});

  @override
  _TheMainCardState createState() => _TheMainCardState();
}

class _TheMainCardState extends State<TheMainCard> {
  @override
  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: NeumorphicContainer(
          width: 350,
          height: 85,
          borderRadius: 20,
          primaryColor: Theme.of(context).primaryColor,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 3,
                height: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).primaryColorDark),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 190,
                height: 64,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FontLightHeader(
                      content: widget.heading,
                      contentSize: 18,
                      numberOfLines: 2,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    FontLight(content: widget.author, contentSize: 14),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 120,
                height: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
