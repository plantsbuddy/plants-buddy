import 'package:equatable/equatable.dart';

class IdentificationResult extends Equatable {
  final dynamic _confidence;
  final String label;
  final Map<String, dynamic> data;

  const IdentificationResult({required dynamic confidence, required this.label, this.data = const {}})
      : _confidence = confidence;

  String get confidence => _confidence is double ? (_confidence * 100).toStringAsFixed(2) : _confidence;

  IdentificationResult copyWith({
    required Map<String, dynamic> data,
  }) =>
      IdentificationResult(
        confidence: _confidence,
        label: label,
        data: data,
      );

  @override
  List<Object?> get props => [_confidence, label, data];
}
