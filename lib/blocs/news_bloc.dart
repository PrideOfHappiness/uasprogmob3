import '../../Model/article_model.dart';
import '../../repositories/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_states.dart';



class NewsBloc extends Bloc<NewsEvents,NewsStates>{
  NewsRepository? newsRepository;

  NewsBloc({required NewsStates initialState,required this.newsRepository}): super(initialState){
    add(StartEvent());
  }

  @override

  Stream<NewsStates> mapEventToState(NewsEvents event)async*{
    if(event is StartEvent){
      try {
        List<ArticleModel> _articleList = [];
        yield NewsInitstate();
        _articleList = await newsRepository!.fetchNews();
        yield NewsLoadedState(articleList: _articleList);
      } catch (e) {
        yield NewsErrorState(errorMessage: e.toString());
      }
    }
  }

}