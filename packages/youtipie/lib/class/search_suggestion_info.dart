class SearchSuggestionInfo {
  final String fullText;
  final (String, String)? typedAndCompletion;
  final String? subtitle;
  final String? displayName;
  final String? entityId;
  final String? thumbnailUrl;
  final bool isChannel;

  const SearchSuggestionInfo({
    this.fullText = '',
    this.typedAndCompletion,
    this.subtitle,
    this.displayName,
    this.entityId,
    this.thumbnailUrl,
    this.isChannel = false,
  });
}
