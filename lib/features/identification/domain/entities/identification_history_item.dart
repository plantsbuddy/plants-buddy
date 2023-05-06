import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:plants_buddy/features/identification/domain/entities/identification_result.dart';

class IdentificationHistoryItem extends Equatable {
  final String firstMatch;
  final int time;
  final String imageUrl;
  final List<IdentificationResult> results;

  const IdentificationHistoryItem({
    required this.firstMatch,
    required this.time,
    required this.imageUrl,
    required this.results,
  });

  String get formattedTime => DateFormat('h:mm a • d MMMM, yyyy ').format(DateTime.fromMillisecondsSinceEpoch(time));

  // IdentificationHistoryItem copyWith({
  //   required Map<String, dynamic> data,
  // }) =>
  //     IdentificationHistoryItem(
  //       confidence: _confidence,
  //       label: label,
  //       data: data,
  //     );

  @override
  List<Object?> get props => [firstMatch, time, imageUrl, results];
}
