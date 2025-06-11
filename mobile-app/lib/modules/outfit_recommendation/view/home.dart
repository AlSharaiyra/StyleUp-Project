import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
import 'package:style_up/modules/outfit_recommendation/bloc/secondStep/second_step_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/secondStep/second_step_event.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/secondStep/second_step_state.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/thirdStep/third_step_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/thirdStep/third_step_event.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/thirdStep/third_step_state.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/weather/weather_bloc.dart';
import 'package:style_up/modules/outfit_recommendation/bloc/weather/weather_state.dart';
import 'package:style_up/modules/outfit_recommendation/controller/weather.dart';
import 'package:style_up/modules/outfit_recommendation/params/first_step.dart';
import 'package:style_up/modules/outfit_recommendation/params/second_step.dart';
import 'package:style_up/modules/outfit_recommendation/params/third_step.dart';
import 'package:style_up/modules/outfit_recommendation/widget/event_card.dart';
import 'package:style_up/modules/outfit_recommendation/widget/message_card.dart';
import 'package:style_up/modules/outfit_recommendation/widget/outfit_card.dart';
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<SecondStepBloc, SecondStepState>(
              listener: (context, state) {
            if (state is SecondStepLoading) {
              // Show loading indicator if needed
            } else if (state is SecondStepError) {
              // Handle error state, maybe show a snackbar or dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is SecondStepSuccess) {
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
                          imageUrl: state.selectedItem!.url,
                          text:
                              'Try those ${state.selectedItem!.description} !',
                          onNoPressed: () {
                            context
                                .read<SecondStepBloc>()
                                .add(SecondStepSelectEvent());
                            context.pop();
                          },
                          onYesPressed: () async {
                            final secureTokenStorage =
                                SecureTokenStorage.instance;

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
                            final previosItemId = state.selectedItem!.itemId;
                            final eventState = context.read<EventBloc>().state
                                as EventsSuccess;
                            context.read<ThirdStepBloc>().add(
                                ThirdStepFetchEvents(
                                    context: context,
                                    params: ThirdStepParams(
                                        eventType:
                                            eventState.selectedEvent?.name ??
                                                "'",
                                        season: getSemesterName(season),
                                        previousItemId: previosItemId,
                                        accessToken: await secureTokenStorage
                                                .getAccessToken() ??
                                            '')));
                            context.pop();
                            _autoScroll();
                          },
                        ),
                      );
                    });
              });
            }
          }),
          BlocListener<ThirdStepBloc, ThirdStepState>(
              listener: (context, state) {
            if (state is ThirdStepLoading) {
              // Show loading indicator if needed
            } else if (state is ThirdStepError) {
              // Handle error state, maybe show a snackbar or dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is ThirdStepSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showGeneralDialog(
                    context: context,
                    barrierDismissible: false,
                    barrierLabel: 'Popup',
                    barrierColor: Colors.black54,
                    transitionDuration: const Duration(milliseconds: 350),
                    pageBuilder: (context, animation, ThirdaryAnimation) {
                      return Center(
                        child: PopupCard(
                          imageUrl: state.selectedItem!.url,
                          text:
                              'Try those ${state.selectedItem!.description} !',
                          onNoPressed: () {
                            context
                                .read<ThirdStepBloc>()
                                .add(ThirdStepSelectEvent());
                            context.pop();
                          },
                          onYesPressed: () async {
                            final secureTokenStorage =
                                SecureTokenStorage.instance;

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

                            context.pop();
                            _autoScroll();
                          },
                        ),
                      );
                    });
              });
            }
          })
        ],
        child: SingleChildScrollView(
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Center(
                              child: PopupCard(
                                imageUrl: firstStepState.selectedItem!.url,
                                text:
                                    'Try those ${firstStepState.selectedItem!.description} !',
                                onNoPressed: () {
                                  context
                                      .read<FirstStepBloc>()
                                      .add(FirstStepSelectEvent());
                                  context.pop();
                                },
                                onYesPressed: () async {
                                  final secureTokenStorage =
                                      SecureTokenStorage.instance;

                                  final weatherData = context
                                      .read<WeatherBloc>()
                                      .state as WeatherSucssess;
                                  final season = await WeatherController()
                                      .getCurrentSemester(
                                          weatherData.weather.current
                                                  ?.temperature2m ??
                                              0,
                                          weatherData.weather.current
                                                  ?.windSpeed10m ??
                                              0);
                                  final previosItemId =
                                      firstStepState.selectedItem!.itemId;
                                  final eventState = context
                                      .read<EventBloc>()
                                      .state as EventsSuccess;
                                  context.read<SecondStepBloc>().add(
                                      SecondStepFetchEvents(
                                          context: context,
                                          params: SecondStepParams(
                                              eventType: eventState
                                                      .selectedEvent?.name ??
                                                  "'",
                                              season: getSemesterName(season),
                                              previousItemId: previosItemId,
                                              accessToken:
                                                  await secureTokenStorage
                                                          .getAccessToken() ??
                                                      '')));
                                  context.pop();
                                  _autoScroll();
                                },
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
                                    SelectEvent(event: state.events[index]),
                                  );
                              final weatherData = context
                                  .read<WeatherBloc>()
                                  .state as WeatherSucssess;
                              final season = await WeatherController()
                                  .getCurrentSemester(
                                      weatherData
                                              .weather.current?.temperature2m ??
                                          0,
                                      weatherData
                                              .weather.current?.windSpeed10m ??
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
                BlocBuilder<EventBloc, EventsState>(builder: (context, state) {
                  if (state is EventsSuccess && state.selectedEvent != null) {
                    return MessageCard(
                      text:
                          'Im attending a ${(state as EventsSuccess).selectedEvent?.displayName} this weekend.',
                      isSender: true,
                    );
                  }
                  return SizedBox();
                }),
                SizedBox(
                  height: spacing * 0.1,
                ),
                // const OutfitGenerate(),
                BlocBuilder<FirstStepBloc, FirstStepState>(
                    builder: (context, state) {
                  if (state is FirstStepSuccess) {
                    return OutfitCard(
                        imageUrl: state.selectedItem?.url ?? '', text: '');
                  }
                  return SizedBox();
                }),
                BlocBuilder<SecondStepBloc, SecondStepState>(
                    builder: (context, state) {
                  if (state is SecondStepSuccess) {
                    return OutfitCard(
                        imageUrl: state.selectedItem?.url ?? '', text: '');
                  }
                  return SizedBox();
                }),
                BlocBuilder<ThirdStepBloc, ThirdStepState>(
                    builder: (context, state) {
                  if (state is ThirdStepSuccess) {
                    return OutfitCard(
                        imageUrl: state.selectedItem?.url ?? '', text: '');
                  }
                  return SizedBox();
                }),
                SizedBox(
                  height: spacing * 0.1,
                ),
                // const OutfitGenerate(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
