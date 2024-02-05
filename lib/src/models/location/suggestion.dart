class Suggestion {
  final String placeId;
  final String descriptions;

  Suggestion(this.placeId, this.descriptions);

  @override
  String toString() {
    return 'Suggestion(description: $descriptions, placeId: $placeId)';
  }
}
