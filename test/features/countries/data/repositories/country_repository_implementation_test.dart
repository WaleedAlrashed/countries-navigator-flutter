import 'package:countries_navigator/core/errors/exceptions.dart';
import 'package:countries_navigator/core/errors/faliures.dart';
import 'package:countries_navigator/core/helpers/network_info.dart';
import 'package:countries_navigator/features/countries/data/datasources/country_local_data_source.dart';
import 'package:countries_navigator/features/countries/data/datasources/country_remote_data_source.dart';
import 'package:countries_navigator/features/countries/data/models/country_model.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart'; // Import Country entity
import 'package:countries_navigator/features/countries/data/repositories/country_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'country_repository_implementation_test.mocks.dart';

@GenerateMocks([
  CountryRemoteDataSource,
  CountryLocalDataSource,
  NetworkInfo,
])
void main() {
  late CountryRepositoryImplementation repository;
  late MockCountryRemoteDataSource mockRemoteDataSource;
  late MockCountryLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockCountryRemoteDataSource();
    mockLocalDataSource = MockCountryLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CountryRepositoryImplementation(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tCountryModelList = [
    CountryModel.fromJson({
      "name": {
        "common": "Test Country",
        "official": "Official Test Country",
        "nativeName": {
          "eng": {"official": "Official Test Country", "common": "Test Country"}
        }
      },
      "cca2": "TC",
      "cca3": "TCT",
      "status": "officially-assigned",
      "independent": true,
      "unMember": true,
      "idd": {"root": "+1", "suffixes": ["234"]},
      "capital": ["Test Capital"],
      "region": "Test Region",
      "subregion": "Test Subregion",
      "latlng": [0.0, 0.0],
      "landlocked": false,
      "area": 1000.0,
      "population": 10000,
      "timezones": ["UTC+0"],
      "continents": ["Test Continent"],
      "flags": {"png": "test.png", "svg": "test.svg"},
      "coatOfArms": {"png": "test_coa.png", "svg": "test_coa.svg"},
      "startOfWeek": "monday"
    }),
  ];

  group('getCountries', () {
    test(
        'should return cached data when local data source has cached data',
        () async {
      // Arrange
      when(mockLocalDataSource.getCachedCountries())
          .thenAnswer((_) async => tCountryModelList);
      // Act
      final result = await repository.getCountries();
      // Assert
      verify(mockLocalDataSource.getCachedCountries());
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(result, equals(Right(tCountryModelList)));
    });

    group('when cache is empty', () {
      setUp(() {
        when(mockLocalDataSource.getCachedCountries())
            .thenThrow(EmptyCacheException());
      });

      test(
          'should return remote data and cache it when network is available',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getCountries())
            .thenAnswer((_) async => tCountryModelList);
        when(mockLocalDataSource.cacheCountries(any))
            .thenAnswer((_) async => unit); // Use unit from dartz
        // Act
        final result = await repository.getCountries();
        // Assert
        verify(mockLocalDataSource.getCachedCountries());
        verify(mockNetworkInfo.isConnected);
        verify(mockRemoteDataSource.getCountries());
        verify(mockLocalDataSource.cacheCountries(tCountryModelList));
        expect(result, equals(Right(tCountryModelList)));
      });

      test(
          'should return EmptyCacheFailure when network is unavailable',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        // Act
        final result = await repository.getCountries();
        // Assert
        verify(mockLocalDataSource.getCachedCountries());
        verify(mockNetworkInfo.isConnected);
        verifyZeroInteractions(mockRemoteDataSource);
        verifyNever(mockLocalDataSource.cacheCountries(any)); // Ensure cacheCountries is not called
        expect(result, equals(Left(EmptyCacheFailure())));
      });

      test(
          'should return ServerFailure when remote source fails and network is available',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getCountries()).thenThrow(ServerException());
        // Act
        final result = await repository.getCountries();
        // Assert
        verify(mockLocalDataSource.getCachedCountries());
        verify(mockNetworkInfo.isConnected);
        verify(mockRemoteDataSource.getCountries());
        verifyNever(mockLocalDataSource.cacheCountries(any)); // Ensure cacheCountries is not called
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
}
