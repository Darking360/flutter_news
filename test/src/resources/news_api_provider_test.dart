import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_news/src/resources/news_api_provider.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    // Setup test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1,2,3,4,5]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1,2,3,4,5]);
    // Expectation
  });

  test('FetchItem returns an item', () async {
    // Setup test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode({ "id": 123 }), 200);
    });

    final item = await newsApi.fetchItem(123);
    expect(item.id, 123);
    // Expectation
  });

}