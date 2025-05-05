import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/modules/outfit_recommendation/widget/event_card.dart';
import 'package:style_up/modules/outfit_recommendation/widget/message_card.dart';
import 'package:style_up/modules/outfit_recommendation/widget/outfit_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.075;
    final double spacing = MediaQuery.of(context).size.height * 0.015;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            spacing: spacing,
            children: [
              const MessageCard(
                text: 'What event you have today?',
              ),
              SizedBox(
                height: spacing * 0.1,
              ),
              Center(
                child: Text(
                  'Select your event :',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                height: spacing * 0.1,
              ),
              const EventCard(
                text: 'ايمن عدس',
                isTextBold: true,
                borderColor: ColorsTheme.black,
                backgroundColor: ColorsTheme.selectOutfitButton,
              ),
              const EventCard(
                text: 'ايمن عدس',
              ),
              const EventCard(
                text: 'ايمن عدس',
              ),
              const EventCard(
                text: 'ايمن عدس',
              ),
              const EventCard(
                text: 'ايمن عدس',
              ),
              const EventCard(
                text: 'ايمن عدس',
              ),
              SizedBox(
                height: spacing * 0.1,
              ),
              const MessageCard(
                text: 'Im attending a wedding this weekend.',
                isSender: true,
              ),
               SizedBox(
                height: spacing * 0.1,
              ),
              const OutfitCard(imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx_bmXrSNSANFEEoSjZTO9EG6j4OrZrdxaJA&s', text: 'Black t-shirt would be nice !')
            ],
          ),
        ),
      ),
    );
  }
}
