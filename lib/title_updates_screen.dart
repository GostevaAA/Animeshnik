import 'package:animeshnik/data/models/title_updates.dart';
import 'package:animeshnik/data/network/anlibria_service.dart';
import 'package:animeshnik/title_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Title;

import 'data/models/title.dart';

class TitleUpdatesScreen extends StatefulWidget {
  const TitleUpdatesScreen({super.key});

  @override
  State<TitleUpdatesScreen> createState() => _TitleUpdatesScreenState();
}

class _TitleUpdatesScreenState extends State<TitleUpdatesScreen> {
  ScrollController _scrollController = ScrollController();

  List<Title> _titles = [];
  List<TitleUpdatesUiModel> _titleUpdatesUiModel = [];
  int _currentPage = 1;
  int _itemsPerPage = 10;
  bool _isLoading = false;

  @override
  void initState() {
    _load_title_updates();
    super.initState();
    _scrollController.addListener(_load_next_page);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  HeaderDate formatDateToHeaderDateType(int localUpdatedAt) {
    if (localUpdatedAt == DateTime.now().day)
      return HeaderDate.today;
    else if (DateTime.now().day - localUpdatedAt == 1)
      return HeaderDate.yesterday;
    else
      return HeaderDate.other;
  }

  List<TitleUpdatesUiModel> _to_ui_model(List<Title> titles) {
    List<TitleUpdatesUiModel> titleUpdatesUiModel = [];
    int? prevDate = null;
    HeaderDate prevHeader = HeaderDate.today;

    for (var title in titles) {
      final updatedAt = title.updated;
      final newDate = DateTime.fromMillisecondsSinceEpoch(updatedAt * 1000).day;

      if (prevDate != newDate && prevHeader != HeaderDate.other) {
        prevHeader = formatDateToHeaderDateType(newDate);
        titleUpdatesUiModel.add(Header(prevHeader));
        prevDate = newDate;
      }

      titleUpdatesUiModel.add(TitleUiModel(title));
    }

    return titleUpdatesUiModel;
  }

  void _load_title_updates() async {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: false));

    AnlibriaService anilibriaService = AnlibriaService(dio);

    setState(() {
      _isLoading = true;
    });

    TitleUpdates titleUpdates =
        await anilibriaService.getTitleUpdates(1, _itemsPerPage);
    List<Title> titles = titleUpdates.list;

    List<TitleUpdatesUiModel> titleUpdatesUiModel = _to_ui_model(titles);

    setState(() {
      _titles = titles;
      _titleUpdatesUiModel = titleUpdatesUiModel;
      _isLoading = false;
    });
  }

  void _load_next_page() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: false));

      AnlibriaService anilibriaService = AnlibriaService(dio);
      int currentPage = _currentPage + 1;

      setState(() {
        _isLoading = true;
      });

      TitleUpdates titleUpdates =
          await anilibriaService.getTitleUpdates(currentPage, _itemsPerPage);

      List<Title> titles = _titles;
      titles.addAll(titleUpdates.list);

      List<TitleUpdatesUiModel> titleUpdatesUiModel = _to_ui_model(titles);

      setState(() {
        _titles = titles;
        _titleUpdatesUiModel = titleUpdatesUiModel;
        _currentPage = currentPage;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _titleUpdatesUiModel.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (index == _titleUpdatesUiModel.length && _isLoading) {
                  return Center(child: const CircularProgressIndicator());
                }
                if (index != _titleUpdatesUiModel.length) {
                  final item = _titleUpdatesUiModel[index];
                  return switch (item) {
                    TitleUiModel() => TitleScreen(titleUiModel: item),
                    Header() => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          switch (item.type) {
                            HeaderDate.today => "Сегодня",
                            HeaderDate.yesterday => "Вчера",
                            HeaderDate.other => "Ранее",
                          },
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                  };
                }
              },
              itemCount: _titleUpdatesUiModel.length + 1,
            ),
    );
  }
}

sealed class TitleUpdatesUiModel {}

class TitleUiModel extends TitleUpdatesUiModel {
  final Title title;

  TitleUiModel(this.title);
}

class Header extends TitleUpdatesUiModel {
  final HeaderDate type;

  Header(this.type);
}

enum HeaderDate {
  today,
  yesterday,
  other,
}
