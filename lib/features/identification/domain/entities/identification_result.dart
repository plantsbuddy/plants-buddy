import 'package:equatable/equatable.dart';

class IdentificationResult extends Equatable {
  final double _confidence;
  final String label;

  const IdentificationResult({required double confidence, required this.label}) : _confidence = confidence;

  String get confidence => (_confidence * 100).toStringAsFixed(2);

  @override
  List<Object?> get props => [_confidence, label];
}
