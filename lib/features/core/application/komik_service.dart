import 'package:dartz/dartz.dart';
import 'package:get/instance_manager.dart';
import '../../../app/common/exception.dart';
import '../domain/interface/komik_repository_base.dart';
import '../infrastructure/model/komik_response.dart';
import '../infrastructure/model/recent_chapter_komik_model.dart';
import '../infrastructure/repository/komik_repository.dart';

class KomikService {
  final KomikRepositoryBase _repository = Get.find<KomikRepository>();

  // Stream<List<RecentChapterKomikModel>> getRecentChapterKomik(
  //     {required String slug}) {
  //   return _repository.getRecentChapterKomik(slug: slug);
  // }

  // Future<Either<GenericException, int>> insertOrUpdateRecentChapter(
  //     {required RecentChapterKomikModel recentChapter}) async {
  //   return await _repository.insertOrUpdateRecentChapter(
  //     recentChapter: recentChapter,
  //   );
  // }

  Future<Either<GenericException, KomikResponse>> getPopularKomik() async {
    return await _repository.getPopularKomik();
  }
}
