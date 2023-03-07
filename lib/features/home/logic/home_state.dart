part of 'home_cubit.dart';

enum BottomNavPages { home, community, collections, reminders, more }

@immutable
class HomeState extends Equatable {
  final BottomNavPages currentPage;

  HomeState(
    int pageIndex,
  ) : currentPage = BottomNavPages.values[pageIndex];

  @override
  List<Object?> get props => [currentPage];
}
