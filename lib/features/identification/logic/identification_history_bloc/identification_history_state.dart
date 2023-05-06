part of 'identification_history_bloc.dart';

enum HistoryStatus { loading, loaded }

@immutable
class IdentificationHistoryState extends Equatable {
  final List<IdentificationHistoryItem> plants;
  final HistoryStatus plantsStatus;
  final List<IdentificationHistoryItem> diseases;
  final HistoryStatus diseasesStatus;
  final List<IdentificationHistoryItem> pests;
  final HistoryStatus pestsStatus;

  const IdentificationHistoryState({
    required this.plants,
    required this.plantsStatus,
    required this.diseases,
    required this.diseasesStatus,
    required this.pests,
    required this.pestsStatus,
  });

  const IdentificationHistoryState.initial()
      : plants = const [],
        plantsStatus = HistoryStatus.loading,
        diseases = const [],
        diseasesStatus = HistoryStatus.loading,
        pests = const [],
        pestsStatus = HistoryStatus.loading;

  IdentificationHistoryState copyWith({
    List<IdentificationHistoryItem>? plants,
    HistoryStatus? plantsStatus,
    List<IdentificationHistoryItem>? diseases,
    HistoryStatus? diseasesStatus,
    List<IdentificationHistoryItem>? pests,
    HistoryStatus? pestsStatus,
  }) =>
      IdentificationHistoryState(
        plants: plants ?? this.plants,
        plantsStatus: plantsStatus ?? this.plantsStatus,
        diseases: diseases ?? this.diseases,
        diseasesStatus: diseasesStatus ?? this.diseasesStatus,
        pests: pests ?? this.pests,
        pestsStatus: pestsStatus ?? this.pestsStatus,
      );

  @override
  List<Object?> get props => [
        plants,
        plantsStatus,
        diseases,
        diseasesStatus,
        pests,
        pestsStatus,
      ];
}
