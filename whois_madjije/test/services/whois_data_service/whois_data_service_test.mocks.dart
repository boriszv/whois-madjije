// Mocks generated by Mockito 5.0.16 from annotations
// in whois_madjije/test/services/whois_data_service/whois_data_service_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;
import 'dart:io' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:whois_madjije/services/iwhois_api.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [IWhoisApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockIWhoisApi extends _i1.Mock implements _i2.IWhoisApi {
  MockIWhoisApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<Map<String, dynamic>> getWhoisData(String? domain) =>
      (super.noSuchMethod(Invocation.method(#getWhoisData, [domain]),
              returnValue:
                  Future<Map<String, dynamic>>.value(<String, dynamic>{}))
          as _i3.Future<Map<String, dynamic>>);
  @override
  _i3.Future<List<_i4.InternetAddress>> getIps(String? domain) =>
      (super.noSuchMethod(Invocation.method(#getIps, [domain]),
              returnValue: Future<List<_i4.InternetAddress>>.value(
                  <_i4.InternetAddress>[]))
          as _i3.Future<List<_i4.InternetAddress>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [IWhoisApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockWhoisApi extends _i1.Mock implements _i2.IWhoisApi {
  MockWhoisApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<Map<String, dynamic>> getWhoisData(String? domain) =>
      (super.noSuchMethod(Invocation.method(#getWhoisData, [domain]),
              returnValue:
                  Future<Map<String, dynamic>>.value(<String, dynamic>{}))
          as _i3.Future<Map<String, dynamic>>);
  @override
  _i3.Future<List<_i4.InternetAddress>> getIps(String? domain) =>
      (super.noSuchMethod(Invocation.method(#getIps, [domain]),
              returnValue: Future<List<_i4.InternetAddress>>.value(
                  <_i4.InternetAddress>[]))
          as _i3.Future<List<_i4.InternetAddress>>);
  @override
  String toString() => super.toString();
}
