import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/suggestions/logic/suggestions_bloc.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SuggestionsBloc, SuggestionsState>(
              buildWhen: (previous, current) => previous.tipOfTheDayLoaded != current.tipOfTheDayLoaded,
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.yellow[200]),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          custom_icons.plant,
                          height: 24,
                          width: 24,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'General plantation tip',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            state.tipOfTheDayLoaded
                                ? Text(
                                    state.tipOfTheDay,
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  )
                                : SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<SuggestionsBloc, SuggestionsState>(
              buildWhen: (previous, current) => previous.weatherDataStatus != current.weatherDataStatus,
              builder: (context, state) {
                return state.weatherDataStatus == SuggestionsStatus.loading
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 30),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary.withOpacity(0.85),
                              Theme.of(context).colorScheme.surfaceTint.withOpacity(0.8),
                              Theme.of(context).colorScheme.primary.withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${state.weatherData['temperature']}°C',
                              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              state.weatherData['city'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Image.network(
                                  state.weatherData['weather_status_icon'] as String,
                                  width: 30,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.weatherData['weather_status_title'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                    Text(
                                      state.weatherData['weather_status_description'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  size: 24,
                                  color: Colors.white.withOpacity(0.77),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Humidity',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                    Text(
                                      state.weatherData['humidity'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.wind_power,
                                  size: 23,
                                  color: Colors.white.withOpacity(0.77),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Wind speed',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                    Text(
                                      state.weatherData['wind_speed'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.cloudy_snowing,
                                  size: 23,
                                  color: Colors.white.withOpacity(0.77),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Precipitation',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                    Text(
                                      state.weatherData['precipitation'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 15, bottom: 10),
              child: Text(
                'Plantation tips based on weather',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            BlocBuilder<SuggestionsBloc, SuggestionsState>(
              buildWhen: (previous, current) =>
                  previous.weatherBasedSuggestionsStatus != current.weatherBasedSuggestionsStatus,
              builder: (context, state) {
                return state.weatherBasedSuggestionsStatus == SuggestionsStatus.loading
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 30),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView(
                        children: state.weatherBasedSuggestions
                            .map(
                              (suggestion) => Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.orangeAccent.withOpacity(0.65),
                                      Colors.orange.withOpacity(0.55),
                                      Colors.orangeAccent.withOpacity(0.48),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  suggestion,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                ),
                              ),
                            )
                            .toList(),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                      );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 15, bottom: 10),
              child: Text(
                'Suggested plants based on weather',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            BlocBuilder<SuggestionsBloc, SuggestionsState>(
              buildWhen: (previous, current) =>
                  previous.weatherBasedPlantSuggestionsStatus != current.weatherBasedPlantSuggestionsStatus,
              builder: (context, state) {
                return state.weatherBasedPlantSuggestionsStatus == SuggestionsStatus.loading
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 30),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 10),
                            child: Text(
                              state.currentWeatherPlantsType,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
                            ),
                          ),
                          Wrap(
                            children: state.weatherBasedPlantSuggestions
                                .map(
                                  (plant) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Chip(
                                      label: Text(plant),
                                      side: BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
