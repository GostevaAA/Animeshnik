import 'package:animeshnik/data/models/title_updates.dart';
import 'package:animeshnik/data/network/anlibria_service.dart';
import 'package:animeshnik/presentation/title_updates/title_card.dart';
import 'package:animeshnik/presentation/title_updates/title_updates_ui_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Title;

import '../../data/models/title.dart';

class TitleUpdatesScreen extends StatefulWidget {
  const TitleUpdatesScreen({super.key});

  @override
  State<TitleUpdatesScreen> createState() => _TitleUpdatesScreenState();
}

class _TitleUpdatesScreenState extends State<TitleUpdatesScreen> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  List<Title> _titles = [];
  List<TitleUpdatesUiModel> _titleUpdatesUiModel = [];
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  bool _isLoading = false;
  bool _isAllPagesLoaded = false;
  late final AnlibriaService _anilibriaService;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: false));
    _anilibriaService = AnlibriaService(dio);

    loadTitleUpdates();

    _scrollController.addListener(loadNextPage);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  HeaderDate formatDateToHeaderDateType(int localUpdatedAt) {
    if (localUpdatedAt == DateTime.now().day) {
      return HeaderDate.today;
    } else if (DateTime.now().day - localUpdatedAt == 1) {
      return HeaderDate.yesterday;
    } else {
      return HeaderDate.other;
    }
  }

  List<TitleUpdatesUiModel> toUiModel(List<Title> titles) {
    List<TitleUpdatesUiModel> titleUpdatesUiModel = [];
    int? prevDate;
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

  void loadTitleUpdates() async {
    setState(() {
      _isLoading = true;
    });

    TitleUpdates titleUpdates = await _anilibriaService.getTitleUpdates(1, _itemsPerPage);
    List<Title> titles = titleUpdates.list;

    List<TitleUpdatesUiModel> titleUpdatesUiModel = toUiModel(titles);

    setState(() {
      _titles = titles;
      _titleUpdatesUiModel = titleUpdatesUiModel;
      _isLoading = false;
    });
  }

  void loadNextPage() async {
    if (_isAllPagesLoaded) return;

    bool isAllPagesLoaded = false;
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      int currentPage = _currentPage + 1;

      setState(() {
        _isLoading = true;
      });

      TitleUpdates titleUpdates = await _anilibriaService.getTitleUpdates(currentPage, _itemsPerPage);

      List<Title> titles = _titles;
      titles.addAll(titleUpdates.list);

      List<TitleUpdatesUiModel> titleUpdatesUiModel = toUiModel(titles);

      if (titleUpdates.pagination.currentPage == titleUpdates.pagination.pages) isAllPagesLoaded = true;

      setState(() {
        _titles = titles;
        _titleUpdatesUiModel = titleUpdatesUiModel;
        _currentPage = currentPage;
        _isLoading = false;
        _isAllPagesLoaded = isAllPagesLoaded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: _titleUpdatesUiModel.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                if (index == _titleUpdatesUiModel.length && _isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (index != _titleUpdatesUiModel.length) {
                  final item = _titleUpdatesUiModel[index];
                  return switch (item) {
                    TitleUiModel() => TitleCard(titleUiModel: item),
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
                return null;
              },
              itemCount: _titleUpdatesUiModel.length + 1,
            ),
    );
  }
}
