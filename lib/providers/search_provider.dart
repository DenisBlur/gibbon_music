import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/domain/models/search_model.dart';
import 'package:yam_api/search/search.dart';
import 'package:yam_api/search/search_sugges.dart';

class SearchProvider extends ChangeNotifier {
  final SearchModel? searchModel;
  bool _isSuggests = true;

  bool get isSuggests => _isSuggests;

  SearchSuggest _suggest = SearchSuggest();
  Search _searchResult = Search();

  SearchProvider({required this.searchModel});

  SearchSuggest get suggest => _suggest;

  Search get searchResult => _searchResult;

  set isSuggests(bool value) {
    _isSuggests = value;
    notifyListeners();
  }

  set suggest(SearchSuggest value) {
    _suggest = value;
    notifyListeners();
  }

  set searchResult(Search value) {
    _searchResult = value;
    notifyListeners();
  }

  changeType(bool suggest) {
    isSuggests = suggest;
    notifyListeners();
  }

  Future<void> getSearch(String text) async {
    var result = await searchModel!.getFullResult(text);
    _searchResult = result;
    changeType(false);
  }

  Future<void> getSuggest(String text) async {
    var result = await searchModel!.getSuggest(text);
    _suggest = result;
    changeType(true);
  }
}
