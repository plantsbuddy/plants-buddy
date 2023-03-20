part of 'identification_bloc.dart';

enum IdentificationStatus { initial, loading, identificationPerformed, dataLoaded }

@immutable
class IdentificationState extends Equatable {
  final IdentificationStatus status;
  final String? image;
  final IdentificationType identificationType;
  final List<IdentificationResult> identificationResults;

  IdentificationState({
    required this.status,
    required this.image,
    required this.identificationType,
    required this.identificationResults,
  });

  IdentificationState.initial(this.identificationType)
      : status = IdentificationStatus.initial,
        image = null,
        identificationResults = [];

  String get identificationTypeTitle => [
        'plant',
        'disease',
        'pest',
      ][IdentificationType.values.indexOf(identificationType)];

  String get identificationTypeIcon => [
        custom_icons.plant,
        custom_icons.plantDisease,
        custom_icons.pest,
      ][IdentificationType.values.indexOf(identificationType)];

  IdentificationState copyWith({
    IdentificationStatus? status,
    String? Function()? image,
    IdentificationType? identificationType,
    List<IdentificationResult> Function()? identificationResults,
  }) =>
      IdentificationState(
        status: status ?? this.status,
        identificationType: identificationType ?? this.identificationType,
        image: image == null ? this.image : image(),
        identificationResults: identificationResults == null ? this.identificationResults : identificationResults(),
      );

  @override
  List<Object?> get props => [status, image, identificationType, identificationResults];
}
