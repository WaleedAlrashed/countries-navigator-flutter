import 'package:countries_navigator/core/errors/exceptions.dart';
import 'package:countries_navigator/core/errors/faliures.dart';
import 'package:countries_navigator/features/countries/data/datasources/country_local_data_source.dart';
import 'package:countries_navigator/features/countries/data/datasources/country_remote_data_source.dart';
import 'package:countries_navigator/features/countries/data/models/country_model.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart';
import 'package:countries_navigator/features/countries/domain/repsitories/coutntry_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:countries_navigator/core/helpers/network_info.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CountryRepositoryImplementation implements CountryRepository {
  final CountryRemoteDataSource remoteDataSource;
  final CountryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CountryRepositoryImplementation(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<CountryModel>>> getCountries() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCountries = await remoteDataSource.getCountries();
        localDataSource.cacheCountries(remoteCountries);
        return Right(remoteCountries);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCountries = await localDataSource.getCachedCountries();
        return Right(localCountries);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Either<Failure, pw.Document> generateCountryProfile(Country country) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello ${country.name!.commonNativeName}"),
          ); // Center
        },
      ),
    );

    return Right(pdf);
  }
}
