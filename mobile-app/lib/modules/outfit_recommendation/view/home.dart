import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/enum/semester.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/events/events_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/events/events_event.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/events/events_state.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/firstStep/first_step_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/firstStep/first_step_event.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/firstStep/first_step_state.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/weather/weather_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/weather/weather_state.dart';
import 'package:style_up/modules/outfit_recommendation/controller/weather.dart';
import 'package:style_up/modules/outfit_recommendation/params/first_step.dart';
import 'package:style_up/modules/outfit_recommendation/widget/event_card.dart';
import 'package:style_up/modules/outfit_recommendation/widget/message_card.dart';
import 'package:style_up/modules/outfit_recommendation/widget/outfit_card.dart';
import 'package:style_up/modules/outfit_recommendation/widget/outfit_generate.dart';
import 'package:style_up/modules/outfit_recommendation/widget/popup.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final ScrollController _scrollController = ScrollController();
  void _autoScroll() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 3), // Adjust speed here
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.1;
    final double spacing = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
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
                  AppLocalizations.of(context)!.recommendationSelectEvent,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              BlocBuilder<FirstStepBloc, FirstStepState>(
                  builder: (context, firstStepState) {
                if (firstStepState is FirstStepLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (firstStepState is FirstStepSuccess &&
                    (firstStepState.index ?? 9000) <= 2) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showGeneralDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierLabel: 'Popup',
                        barrierColor: Colors.black54,
                        transitionDuration: const Duration(milliseconds: 350),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Center(
                            child: PopupCard(
                              imageUrl: firstStepState.selectedItem!.url,
                              text:
                                  'Try those ${firstStepState.selectedItem!.description} !',
                            ),
                          );
                        });
                  });
                }

                return BlocBuilder<EventBloc, EventsState>(
                    builder: (context, state) {
                  if (state is EventsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is EventsSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.events.length,
                      itemBuilder: (context, index) {
                        return EventCard(
                          text: state.events[index].displayName,
                          isTextBold: true,
                          borderColor: ColorsTheme.black,
                          backgroundColor: state.events[index].displayName ==
                                  state.selectedEvent
                              ? ColorsTheme.primryButton
                              : ColorsTheme.selectOutfitButton,
                          onTap: () async {
                            final secureTokenStorage =
                                SecureTokenStorage.instance;
                            context.read<EventBloc>().add(
                                  SelectEvent(
                                      eventName:
                                          state.events[index].displayName),
                                );
                            final weatherData = context
                                .read<WeatherBloc>()
                                .state as WeatherSucssess;
                            final season = await WeatherController()
                                .getCurrentSemester(
                                    weatherData
                                            .weather.current?.temperature2m ??
                                        0,
                                    weatherData.weather.current?.windSpeed10m ??
                                        0);
                            context.read<FirstStepBloc>().add(
                                FirstStepFetchEvents(
                                    context: context,
                                    params: FirstStepParams(
                                        eventType: state.events[index].name,
                                        season: getSemesterName(season),
                                        accessToken: await secureTokenStorage
                                                .getAccessToken() ??
                                            '')));

                            _autoScroll();
                          },
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No events found'));
                });
              }),
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
              const OutfitGenerate(),
              const OutfitCard(
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx_bmXrSNSANFEEoSjZTO9EG6j4OrZrdxaJA&s',
                  text: 'Black t-shirt would be nice !'),
              SizedBox(
                height: spacing * 0.1,
              ),
              const OutfitGenerate(),
            ],
          ),
        ),
      ),
    );
  }
}
