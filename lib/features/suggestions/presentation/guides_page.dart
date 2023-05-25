import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;

import '../logic/suggestions_bloc.dart';

class GuidesPage extends StatelessWidget {
  const GuidesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestionsBloc, SuggestionsState>(
      buildWhen: (previous, current) => previous.plantationGuidesStatus != current.plantationGuidesStatus,
      builder: (context, state) {
        return state.weatherDataStatus == SuggestionsStatus.loading
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    child: GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Image.network(
                                state.plantationGuides[index].cover,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black12,
                                      Colors.black.withOpacity(0.8),
                                      Colors.black.withOpacity(0.7),
                                      Colors.black,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 5,
                                  child: Text(
                                    state.plantationGuides[index].title,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => Navigator.of(context)
                          .pushNamed(app_routes.fullGuide, arguments: state.plantationGuides[index]),
                    ),
                  );
                },
                itemCount: state.plantationGuides.length,
              );
      },
    );
  }
}
