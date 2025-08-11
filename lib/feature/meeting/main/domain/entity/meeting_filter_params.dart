class MeetingFilterParams {
  final String? region;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final int? minParticipants;
  final int? maxParticipants;
  final String? category;

  const MeetingFilterParams({
    this.region,
    this.startDate,
    this.endDate,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.minParticipants,
    this.maxParticipants,
    this.category,
  });

  MeetingFilterParams copyWith({
    String? region,
    DateTime? startDate,
    DateTime? endDate,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    int? minParticipants,
    int? maxParticipants,
    String? category,
  }) {
    return MeetingFilterParams(
      region: region ?? this.region,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      minParticipants: minParticipants ?? this.minParticipants,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeetingFilterParams &&
          runtimeType == other.runtimeType &&
          region == other.region &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          minPrice == other.minPrice &&
          maxPrice == other.maxPrice &&
          minRating == other.minRating &&
          minParticipants == other.minParticipants &&
          maxParticipants == other.maxParticipants &&
          category == other.category;

  @override
  int get hashCode =>
      region.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      minPrice.hashCode ^
      maxPrice.hashCode ^
      minRating.hashCode ^
      minParticipants.hashCode ^
      maxParticipants.hashCode ^
      category.hashCode;
}
