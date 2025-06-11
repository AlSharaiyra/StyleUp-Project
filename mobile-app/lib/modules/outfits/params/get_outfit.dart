import 'package:style_up/modules/outfits/model/filter_model.dart';

class GetOutfitParams {
  final String? accessToken;
  final FilterOptions filterOptions;
  const GetOutfitParams({
    this.accessToken,
    this.filterOptions = const FilterOptions(),
  });
  Map<String, String> toHeader() {
    final Map<String, String> header = {};
    if (accessToken!.isNotEmpty) {
      header['Authorization'] = 'Bearer $accessToken';
    }
    return header;
  }

  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> queryParams = {};
    if (filterOptions.type != null && filterOptions.type!.isNotEmpty) {
      queryParams['type'] = filterOptions.type;
    }
    if (filterOptions.season != null && filterOptions.season!.isNotEmpty) {
      queryParams['season'] = filterOptions.season;
    }
    queryParams['size'] = filterOptions.limit;
    queryParams['page'] = filterOptions.page;

    return queryParams;
  }

  String toQueryString() {
    final queryMap = toQueryParams();
    if (queryMap.isEmpty) {
      return '';
    }
    return '?${queryMap.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}').join('&')}';
  }

  GetOutfitParams copyWith({
    String? accessToken,
    FilterOptions? filterOptions,
  }) {
    return GetOutfitParams(
      accessToken: accessToken ?? this.accessToken,
      filterOptions: filterOptions ?? this.filterOptions,
    );
  }
}
