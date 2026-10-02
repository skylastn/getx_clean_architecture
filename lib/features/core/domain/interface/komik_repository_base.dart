import 'package:dartz/dartz.dart';

import '../../../../shared/common/exception.dart';
import '../../domain/model/response/komik_response.dart';

abstract class KomikRepositoryBase {
  // Stream<List<RecentChapterKomikModel>> getRecentChapterKomik({
  //   required String slug,
  // });
  // Future<Either<GenericException, int>> insertOrUpdateRecentChapter({
  //   required RecentChapterKomikModel recentChapter,
  // });

  Future<Either<GenericException, KomikResponse>> getPopularKomik();
}
