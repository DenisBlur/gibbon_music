import 'package:yam_api/enums.dart';
import 'package:yam_api/search/search.dart';
import 'package:yam_api/search/search_sugges.dart';

import '../../main.dart';

class SearchModel {

  Future<SearchSuggest> getSuggest(String text) async {
    SearchSuggest result = await client.searchSuggest(text: text);
    return result;
  }

  Future<Search> getFullResult(String text) async {
    Search result = await client.search(text: text, type: SearchType.all, page: 0);
    return result;
  }

}