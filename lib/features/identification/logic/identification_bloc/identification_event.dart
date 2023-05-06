part of 'identification_bloc.dart';

@immutable
abstract class IdentificationEvent {}

class IdentificationPickFromGalleryPressed extends IdentificationEvent {}

class IdentificationCaptureFromCameraPressed extends IdentificationEvent {}

class IdentificationPerformIdentificationPressed extends IdentificationEvent {}

class IdentificationDownloadFromUrlPressed extends IdentificationEvent {
  final String url;

  IdentificationDownloadFromUrlPressed(this.url);
}

class IdentificationTypeChanged extends IdentificationEvent {
  final IdentificationType identificationType;

  IdentificationTypeChanged(this.identificationType);
}
