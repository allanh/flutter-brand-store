import 'package:brandstores/src/domain/entities/helper_center.dart';
import 'package:brandstores/src/domain/usecases/helper_center/get_article_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ArticlePresenter extends Presenter {
  late Function onNext;
  late Function onComplete;
  late Function onError;

  final GetArticleUseCase useCase;

  ArticlePresenter(repo) : useCase = GetArticleUseCase(repo);

  void getArticle(ArticleType articleType) {
    useCase.execute(
        _UseCaseObserver(this), GetArticleUseCaseParams(articleType));
  }

  @override
  void dispose() {
    useCase.dispose();
  }
}

class _UseCaseObserver extends Observer<GetArticleUseCaseResponse> {
  final ArticlePresenter presenter;

  _UseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.onComplete();
  }

  @override
  void onError(e) {
    presenter.onError(e);
  }

  @override
  void onNext(response) {
    presenter.onNext(response?.data);
  }
}
