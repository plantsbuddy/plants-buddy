import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;

import '../domain/entities/identification_result.dart';
import '../domain/usecases/identification_usecases.dart';

part 'identification_event.dart';

part 'identification_state.dart';

enum IdentificationType { plant, disease, pest }

class IdentificationBloc extends Bloc<IdentificationEvent, IdentificationState> {
  final CaptureImageFromCamera _captureImageFromCamera;
  final DownloadImageFromUrl _downloadImageFromUrl;
  final PickImageFromGallery _pickImageFromGallery;
  final PerformIdentification _performIdentification;

  IdentificationBloc(
      this._captureImageFromCamera, this._downloadImageFromUrl, this._pickImageFromGallery, this._performIdentification,
      {required IdentificationType identificationType})
      : super(IdentificationState.initial(identificationType)) {
    on<IdentificationPickFromGalleryPressed>(onIdentificationPickFromGalleryPressed);
    on<IdentificationCaptureFromCameraPressed>(onIdentificationCaptureFromCameraPressed);
    on<IdentificationDownloadFromUrlPressed>(onIdentificationDownloadFromUrlPressed);
    on<IdentificationTypeChanged>(onIdentificationTypeChanged);
    on<IdentificationPerformIdentificationPressed>(onIdentificationPerformIdentificationPressed);
  }

  Future<FutureOr<void>> onIdentificationPickFromGalleryPressed(
      IdentificationPickFromGalleryPressed event, Emitter<IdentificationState> emit) async {
    final imagePath = await _pickImageFromGallery();

    emit(state.copyWith(image: () => imagePath));
  }

  FutureOr<void> onIdentificationCaptureFromCameraPressed(
      IdentificationCaptureFromCameraPressed event, Emitter<IdentificationState> emit) async {
    final imagePath = await _captureImageFromCamera();

    emit(state.copyWith(image: () => imagePath));
  }

  FutureOr<void> onIdentificationDownloadFromUrlPressed(
      IdentificationDownloadFromUrlPressed event, Emitter<IdentificationState> emit) async {
    final imagePath = await _downloadImageFromUrl(event.url);

    emit(state.copyWith(image: () => imagePath));
  }

  FutureOr<void> onIdentificationTypeChanged(IdentificationTypeChanged event, Emitter<IdentificationState> emit) {
    emit(state.copyWith(identificationType: event.identificationType));
  }

  FutureOr<void> onIdentificationPerformIdentificationPressed(
      IdentificationPerformIdentificationPressed event, Emitter<IdentificationState> emit) async {
    // emit(state.copyWith(status: IdentificationStatus.loading));

    final predictions =
        await _performIdentification(identificationType: state.identificationType, imagePath: state.image!);

    // log(predictions.toString());
    emit(
        state.copyWith(status: IdentificationStatus.identificationPerformed, identificationResults: () => predictions ?? []));
  }
}
