import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePageWidget extends StatefulWidget {
  const ExplorePageWidget({Key? key}) : super(key: key);

  @override
  _ExplorePageWidgetState createState() => _ExplorePageWidgetState();
}

class _ExplorePageWidgetState extends State<ExplorePageWidget> {
  Completer<List<PostsRecord>>? _algoliaRequestCompleter1;
  TextEditingController? textController;
  Completer<List<PostsRecord>>? _algoliaRequestCompleter2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'explorePage'});
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: textController,
                          onChanged: (_) => EasyDebounce.debounce(
                            'textController',
                            Duration(milliseconds: 500),
                            () async {
                              setState(() => _algoliaRequestCompleter1 = null);
                              await waitForAlgoliaRequestCompleter1();
                            },
                          ),
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                            suffixIcon: Icon(
                              Icons.search_outlined,
                              color: Color(0xFF757575),
                              size: 22,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Stack(
                            children: [
                              if (textController!.text == null ||
                                  textController!.text == '')
                                FutureBuilder<List<PostsRecord>>(
                                  future: (_algoliaRequestCompleter2 ??=
                                          Completer<List<PostsRecord>>()
                                            ..complete(PostsRecord.search(
                                              term: 'ar',
                                            )))
                                      .future,
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                          ),
                                        ),
                                      );
                                    }
                                    List<PostsRecord>
                                        normalViewPostsRecordList =
                                        snapshot.data!;
                                    // Customize what your widget looks like with no search results.
                                    if (snapshot.data!.isEmpty) {
                                      return Container(
                                        height: 100,
                                        child: Center(
                                          child: Text('No results.'),
                                        ),
                                      );
                                    }
                                    return RefreshIndicator(
                                      onRefresh: () async {
                                        setState(() =>
                                            _algoliaRequestCompleter2 = null);
                                        await waitForAlgoliaRequestCompleter2();
                                      },
                                      child: MasonryGridView.count(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                        itemCount:
                                            normalViewPostsRecordList.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (context, normalViewIndex) {
                                          final normalViewPostsRecord =
                                              normalViewPostsRecordList[
                                                  normalViewIndex];
                                          return InkWell(
                                            onTap: () async {
                                              context.pushNamed(
                                                'postDetail',
                                                queryParams: {
                                                  'postRef': serializeParam(
                                                    normalViewPostsRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType
                                                            .scale,
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                  ),
                                                },
                                              );
                                            },
                                            child: Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: double.infinity,
                                                  maxHeight: double.infinity,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      normalViewPostsRecord
                                                          .postPhoto!,
                                                    ),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration:
                                                          BoxDecoration(),
                                                    ),
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x80272727),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        5),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  normalViewPostsRecord
                                                                      .postTitle!,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBtnText,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  normalViewPostsRecord
                                                                      .postDescription!
                                                                      .maybeHandleOverflow(
                                                                          maxChars:
                                                                              50),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              if (textController!.text != null &&
                                  textController!.text != '')
                                FutureBuilder<List<PostsRecord>>(
                                  future: (_algoliaRequestCompleter1 ??=
                                          Completer<List<PostsRecord>>()
                                            ..complete(PostsRecord.search(
                                              term: 'Design',
                                            )))
                                      .future,
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                          ),
                                        ),
                                      );
                                    }
                                    List<PostsRecord>
                                        searchViewPostsRecordList =
                                        snapshot.data!;
                                    // Customize what your widget looks like with no search results.
                                    if (snapshot.data!.isEmpty) {
                                      return Container(
                                        height: 100,
                                        child: Center(
                                          child: Text('No results.'),
                                        ),
                                      );
                                    }
                                    return MasonryGridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      itemCount:
                                          searchViewPostsRecordList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, searchViewIndex) {
                                        final searchViewPostsRecord =
                                            searchViewPostsRecordList[
                                                searchViewIndex];
                                        return InkWell(
                                          onTap: () async {
                                            context.pushNamed(
                                              'postDetail',
                                              queryParams: {
                                                'postRef': serializeParam(
                                                  searchViewPostsRecord
                                                      .reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.scale,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                ),
                                              },
                                            );
                                          },
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Color(0xFFF5F5F5),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: double.infinity,
                                                maxHeight: double.infinity,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    searchViewPostsRecord
                                                        .postPhoto!,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x80272727),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 5),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                searchViewPostsRecord
                                                                    .postTitle!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBtnText,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                              ),
                                                              Text(
                                                                searchViewPostsRecord
                                                                    .postDescription!
                                                                    .maybeHandleOverflow(
                                                                        maxChars:
                                                                            50),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      if ('0' == '1')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Lihat Semua',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 40,
                              color: Color(0xFF3B5159),
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                  ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future waitForAlgoliaRequestCompleter1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _algoliaRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForAlgoliaRequestCompleter2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _algoliaRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
