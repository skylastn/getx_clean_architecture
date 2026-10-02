import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../shared/common/exception.dart';
import '../../../../shared/core/network/api_provider.dart';

import '../../domain/model/response/komik_response.dart';

class KomikRemoteDataSource {
  String getBaseUrl(BEType type) {
    String url = '/';
    switch (type) {
      case BEType.komik:
        return '${url}komiku';
      case BEType.anime:
        return '${url}komiku';
      case BEType.film:
        return '${url}komiku';
      // default:
      //   return '${url}komiku';
    }
  }

  Future<Either<GenericException, KomikResponse>> getPopularKomik() async {
    try {
      var response = await ApiProvider().getApi(
        '${getBaseUrl(BEType.komik)}/popular',
      );
      if (!response.isError) {
        return Right(
          KomikResponse.fromJson(jsonDecode(response.result?.body ?? '')),
        );
      }
      return Left(
        ServerRequestException(
          code: ExceptionCode.serverFailure,
          value: response.msg,
        ),
      );
    } catch (e) {
      return Left(
        ServerRequestException(
          code: ExceptionCode.unknown,
          value: e.toString(),
        ),
      );
    }
  }
}

enum BEType {
  komik,
  anime,
  film,
}
