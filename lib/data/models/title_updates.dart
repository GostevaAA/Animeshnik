import 'package:animeshnik/data/models/title.dart';

class TitleUpdates {
  final List<Title> list;
  final Pagination pagination;

  TitleUpdates(this.list, this.pagination);

  TitleUpdates.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List<dynamic>)
            .map((e) => Title.fromJson(e as Map<String, dynamic>))
            .toList(),
        pagination =
            Pagination.fromJson(json['pagination'] as Map<String, dynamic>);
}

class Pagination {
  final int pages;
  final int currentPage;
  final int itemsPerPage;
  final int totalItems;

  Pagination(this.pages, this.currentPage, this.itemsPerPage, this.totalItems);

  Pagination.fromJson(Map<String, dynamic> json)
      : pages = json['pages'] as int,
        currentPage = json['current_page'] as int,
        itemsPerPage = json['items_per_page'] as int,
        totalItems = json['total_items'] as int;
}
