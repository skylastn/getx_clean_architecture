// import 'package:dartz/dartz.dart';
// import 'package:isar/isar.dart';
// import 'package:sample_app/app/global/logic/local_logic.dart';
// import 'package:get/get.dart';

// import '../../../../app/common/exception.dart';
// import '../../domain/model/recent_chapter_komik_model.dart';

// class KomikLocalDataSource {
//   final db = Get.find<LocalLogic>().db;

//   Stream<List<RecentChapterKomikModel>> getRecentChapterKomik({
//     required String slug,
//   }) {
//     return db.recentChapterKomikModels
//         .where()
//         .filter()
//         .slugKomikEqualTo(slug)
//         .watch();
//   }

//   Future<Either<GenericException, int>> insertOrUpdateRecentChapter({
//     required RecentChapterKomikModel recentChapter,
//   }) async {
//     try {
//       var result = await db.writeTxn(() async {
//         return await db.recentChapterKomikModels.put(recentChapter);
//       });
//       return Right(result);
//     } catch (e) {
//       return Left(
//         DatabaseException(
//           code: ExceptionCode.database,
//           value: e.toString(),
//         ),
//       );
//     }
//   }
// }
