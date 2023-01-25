// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/comment_options_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailWidget extends StatefulWidget {
  const PostDetailWidget({
    Key? key,
    this.postRef,
  }) : super(key: key);

  final String? postRef;

  @override
  _PostDetailWidgetState createState() => _PostDetailWidgetState();
}

class _PostDetailWidgetState extends State<PostDetailWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'columnOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        RotateEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 100,
        ),
      ],
    ),
  };
  String _currentPageLink = '';
  TextEditingController? textController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'postDetail'});
    textController = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<PostsRecord>>(
      stream: queryPostsRecord(
        queryBuilder: (postsRecord) =>
            postsRecord.where('iid', isEqualTo: widget.postRef),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ),
          );
        }
        List<PostsRecord> postDetailPostsRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final postDetailPostsRecord = postDetailPostsRecordList.isNotEmpty
            ? postDetailPostsRecordList.first
            : null;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          body: NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                pinned: false,
                floating: true,
                snap: false,
                backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
                automaticallyImplyLeading: true,
                leading: Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: InkWell(
                    onTap: () async {
                      context.pop();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
                title: Text(
                  postDetailPostsRecord!.postTitle!,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: InkWell(
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: CommentOptionsWidget(
                                postRef: postDetailPostsRecord.reference,
                                userRef: postDetailPostsRecord.postUser,
                              ),
                            );
                          },
                        ).then((value) => setState(() {}));
                      },
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ],
                centerTitle: true,
                elevation: 1,
              )
            ],
            body: Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: StreamBuilder<UsersRecord>(
                    stream: UsersRecord.getDocument(
                        postDetailPostsRecord!.postUser!),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                      final columnUsersRecord = snapshot.data!;
                      return InkWell(
                        onTap: () async {
                          _currentPageLink = await generateCurrentPageLink(
                            context,
                            title: postDetailPostsRecord.postTitle,
                            imageUrl: postDetailPostsRecord.postPhoto,
                            description: postDetailPostsRecord.postDescription,
                            isShortLink: true,
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 4, 0, 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 0, 16, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            AuthUserStreamWidget(
                                              builder: (context) => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    columnUsersRecord.photoUrl,
                                                    'https://ik.imagekit.io/mofh0plv6/userOutlineBlack_E_9HvIlju.png?tr=w-50,h-50',
                                                  ),
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(12, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      columnUsersRecord
                                                          .displayName!,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1,
                                                    ),
                                                    Text(
                                                      dateTimeFormat(
                                                        'relative',
                                                        postDetailPostsRecord
                                                            .timePosted!,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (postDetailPostsRecord.postPhoto !=
                                              null &&
                                          postDetailPostsRecord.postPhoto != '')
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 5, 16, 5),
                                          child: Image.network(
                                            postDetailPostsRecord.postPhoto!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 12, 16, 0),
                                        child: Text(
                                          postDetailPostsRecord
                                              .postDescription!,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'Nunito',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .black600,
                                              ),
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Color(0xFFC8C8C8),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1.01,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  _currentPageLink =
                                                      await generateCurrentPageLink(
                                                    context,
                                                    title: postDetailPostsRecord
                                                        .postTitle,
                                                    imageUrl:
                                                        postDetailPostsRecord
                                                            .postPhoto,
                                                    description:
                                                        postDetailPostsRecord
                                                            .postDescription,
                                                  );
                                                  if (kDebugMode) {
                                                    print(
                                                        "PAGE SHARE LINK: $_currentPageLink");
                                                  }
                                                  await Share.share(
                                                      _currentPageLink);
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ToggleIcon(
                                                      onPressed: () async {
                                                        setState(() =>
                                                            FFAppState()
                                                                    .unused =
                                                                !FFAppState()
                                                                    .unused);
                                                      },
                                                      value:
                                                          FFAppState().unused,
                                                      onIcon: const Icon(
                                                        Icons.share_outlined,
                                                        color: Colors.black,
                                                        size: 25,
                                                      ),
                                                      offIcon: const Icon(
                                                        Icons.share_outlined,
                                                        color: Colors.black,
                                                        size: 25,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Dibagikan',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1,
                                                    ),
                                                    Text(
                                                      '0',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1,
                                                    ),
                                                  ],
                                                ),
                                              ).animateOnActionTrigger(
                                                animationsMap[
                                                    'columnOnActionTriggerAnimation']!,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ToggleIcon(
                                                    onPressed: () async {
                                                      final bookmarksElement =
                                                          currentUserReference;
                                                      final bookmarksUpdate =
                                                          postDetailPostsRecord
                                                                  .bookmarks!
                                                                  .toList()
                                                                  .contains(
                                                                      bookmarksElement)
                                                              ? FieldValue
                                                                  .arrayRemove([
                                                                  bookmarksElement
                                                                ])
                                                              : FieldValue
                                                                  .arrayUnion([
                                                                  bookmarksElement
                                                                ]);
                                                      final postsUpdateData = {
                                                        'bookmarks':
                                                            bookmarksUpdate,
                                                      };
                                                      await postDetailPostsRecord
                                                          .reference
                                                          .update(
                                                              postsUpdateData);
                                                    },
                                                    value: postDetailPostsRecord
                                                        .bookmarks!
                                                        .toList()
                                                        .contains(
                                                            currentUserReference),
                                                    onIcon: Icon(
                                                      Icons.bookmark,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .black600,
                                                      size: 25,
                                                    ),
                                                    offIcon: const Icon(
                                                      Icons.bookmark_border,
                                                      color: Colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Disimpan',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      postDetailPostsRecord
                                                          .bookmarks!
                                                          .toList()
                                                          .length,
                                                      formatType:
                                                          FormatType.compact,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ToggleIcon(
                                                    onPressed: () async {
                                                      setState(() =>
                                                          FFAppState().unused =
                                                              !FFAppState()
                                                                  .unused);
                                                    },
                                                    value: FFAppState().unused,
                                                    onIcon: const Icon(
                                                      FFIcons.kbubble,
                                                      color: Colors.black,
                                                      size: 25,
                                                    ),
                                                    offIcon: const Icon(
                                                      FFIcons.kbubble,
                                                      color: Colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Komentar',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  StreamBuilder<
                                                      List<CommentsRecord>>(
                                                    stream: queryCommentsRecord(
                                                      parent:
                                                          postDetailPostsRecord
                                                              .reference,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50,
                                                            height: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      return Text(
                                                        formatNumber(
                                                          postDetailPostsRecord
                                                              .numComments!,
                                                          formatType: FormatType
                                                              .compact,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ToggleIcon(
                                                    onPressed: () async {
                                                      final likesElement =
                                                          currentUserReference;
                                                      final likesUpdate =
                                                          postDetailPostsRecord
                                                                  .likes!
                                                                  .toList()
                                                                  .contains(
                                                                      likesElement)
                                                              ? FieldValue
                                                                  .arrayRemove([
                                                                  likesElement
                                                                ])
                                                              : FieldValue
                                                                  .arrayUnion([
                                                                  likesElement
                                                                ]);
                                                      final postsUpdateData = {
                                                        'likes': likesUpdate,
                                                      };
                                                      await postDetailPostsRecord
                                                          .reference
                                                          .update(
                                                              postsUpdateData);
                                                    },
                                                    value: postDetailPostsRecord
                                                        .likes!
                                                        .toList()
                                                        .contains(
                                                            currentUserReference),
                                                    onIcon: const Icon(
                                                      Icons.favorite_sharp,
                                                      color: Color(0xFFFF0808),
                                                      size: 25,
                                                    ),
                                                    offIcon: const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Disukai',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    formatNumber(
                                                      postDetailPostsRecord
                                                          .likes!
                                                          .toList()
                                                          .length,
                                                      formatType:
                                                          FormatType.compact,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Color(0xFFC8C8C8),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 16, 40, 12),
                                        child:
                                            StreamBuilder<List<CommentsRecord>>(
                                          stream: queryCommentsRecord(
                                            parent:
                                                postDetailPostsRecord.reference,
                                            queryBuilder: (commentsRecord) =>
                                                commentsRecord.orderBy('date',
                                                    descending: true),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<CommentsRecord>
                                                listViewCommentsRecordList =
                                                snapshot.data!;
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  listViewCommentsRecordList
                                                      .length,
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewCommentsRecord =
                                                    listViewCommentsRecordList[
                                                        listViewIndex];
                                                return Visibility(
                                                  visible: (currentUserDocument
                                                                  ?.blocked
                                                                  ?.toList() ??
                                                              [])
                                                          .contains(
                                                              listViewCommentsRecord
                                                                  .userRef) ==
                                                      false,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 0, 0, 12),
                                                    child: AuthUserStreamWidget(
                                                      builder: (context) => Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          StreamBuilder<
                                                              UsersRecord>(
                                                            stream: UsersRecord
                                                                .getDocument(
                                                                    listViewCommentsRecord
                                                                        .userRef!),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50,
                                                                    height: 50,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              final imageUsersRecord =
                                                                  snapshot
                                                                      .data!;
                                                              return ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40),
                                                                child: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    imageUsersRecord
                                                                        .photoUrl,
                                                                    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.DVoj_J9g7E8eCEUpphqyvQHaHa%26pid%3DApi&f=1&ipt=c4e1cebc560410117940eca553bb10f9fd005b23004f7c72ace41474f8c57471&ipo=images',
                                                                  ),
                                                                  width: 40,
                                                                  height: 40,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        12,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      StreamBuilder<
                                                                          UsersRecord>(
                                                                        stream:
                                                                            UsersRecord.getDocument(listViewCommentsRecord.userRef!),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
                                                                            return Center(
                                                                              child: SizedBox(
                                                                                width: 50,
                                                                                height: 50,
                                                                                child: CircularProgressIndicator(
                                                                                  color: FlutterFlowTheme.of(context).primaryColor,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                          final commenterNameUsersRecord =
                                                                              snapshot.data!;
                                                                          return Text(
                                                                            commenterNameUsersRecord.displayName!,
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Nunito',
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                          );
                                                                        },
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          listViewCommentsRecord
                                                                              .text!,
                                                                          style:
                                                                              FlutterFlowTheme.of(context).bodyText2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            4,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      dateTimeFormat(
                                                                        'relative',
                                                                        listViewCommentsRecord
                                                                            .date!,
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            12,
                                                                            4,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      'Balas',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText2,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1, 0),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        5,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    await showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Padding(
                                                                          padding:
                                                                              MediaQuery.of(context).viewInsets,
                                                                          child:
                                                                              CommentOptionsWidget(
                                                                            userRef:
                                                                                listViewCommentsRecord.userRef,
                                                                            postRef:
                                                                                postDetailPostsRecord.reference,
                                                                            commentRef:
                                                                                listViewCommentsRecord.reference,
                                                                          ),
                                                                        );
                                                                      },
                                                                    ).then((value) =>
                                                                        setState(
                                                                            () {}));
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .more_vert,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 30,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4089A0),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 10, 10, 10),
                                          child: Container(
                                            width: double.infinity,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            alignment:
                                                const AlignmentDirectional(
                                                    0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          10, 10, 10, 10),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xFF4089A0),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        bottomRight:
                                                            Radius.circular(0),
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    child: AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            currentUserPhoto,
                                                            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.DVoj_J9g7E8eCEUpphqyvQHaHa%26pid%3DApi&f=1&ipt=c4e1cebc560410117940eca553bb10f9fd005b23004f7c72ace41474f8c57471&ipo=images',
                                                          ),
                                                          fit: BoxFit.scaleDown,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Form(
                                                    key: formKey,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .disabled,
                                                    child: TextFormField(
                                                      controller:
                                                          textController,
                                                      autofocus: true,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Ketik Komentarmu...',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2,
                                                        enabledBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        errorBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                        focusedErrorBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    4.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    4.0),
                                                          ),
                                                        ),
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1,
                                                      validator: (val) {
                                                        if (val == null ||
                                                            val.isEmpty) {
                                                          return 'Komentar tidak bisa kosong';
                                                        }

                                                        if (val.length > 50) {
                                                          return 'Maximum 50 characters allowed, currently ${val.length}.';
                                                        }

                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30,
                                                  borderWidth: 1,
                                                  buttonSize: 60,
                                                  icon: Icon(
                                                    Icons.send,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 30,
                                                  ),
                                                  onPressed: () async {
                                                    final commentsCreateData =
                                                        createCommentsRecordData(
                                                      text:
                                                          textController!.text,
                                                      date: getCurrentTimestamp,
                                                      postRef:
                                                          postDetailPostsRecord
                                                              .reference,
                                                      userRef:
                                                          currentUserReference,
                                                    );
                                                    await CommentsRecord.createDoc(
                                                            postDetailPostsRecord
                                                                .reference)
                                                        .set(
                                                            commentsCreateData);
                                                    setState(() {
                                                      textController?.clear();
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );

                // SafeArea(
                //   child: GestureDetector(
                //     onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
                //     child: ),
                // );
              },
            ),
          ),
        );
      },
    );
  }
}
