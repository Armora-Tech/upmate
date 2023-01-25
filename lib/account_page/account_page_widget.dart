// ignore_for_file: library_private_types_in_public_api

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/post_options_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';

class AccountPageWidget extends StatefulWidget {
  const AccountPageWidget({Key? key}) : super(key: key);

  @override
  _AccountPageWidgetState createState() => _AccountPageWidgetState();
}

class _AccountPageWidgetState extends State<AccountPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String selected = '';
  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'accountPage'});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Image.network(
                      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.f500hDXIWDURg3TxO1l2owHaE7%26pid%3DApi&f=1&ipt=3b4466b5ce23b55b4d5de25f3430a4b3fab569d2c497b1ec014ad7e686041a00&ipo=images',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: FlutterFlowIconButton(
                            borderRadius: 30,
                            borderWidth: 0,
                            buttonSize: 30,
                            fillColor: const Color(0x9AFFFFFF),
                            icon: FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 15,
                            ),
                            onPressed: () async {
                              context.pop();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 0, 0),
                          child: AuthUserStreamWidget(
                            builder: (context) => Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.2,
                              clipBehavior: Clip.antiAlias,
                              // color: Colors.white30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70),
                              child: Image.network(valueOrDefault(
                                  currentUserPhoto,
                                  "https://ik.imagekit.io/mofh0plv6/userOutlineBlack_E_9HvIlju.png?tr=w-60,h-60")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: AuthUserStreamWidget(
                  builder: (context) => SelectionArea(
                      child: Text(
                    currentUserDisplayName,
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: SelectionArea(
                    child: Text(
                  currentUserEmail,
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Nunito',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                )),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('editProfile');
                  },
                  text: 'Edit Profile',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 26,
                    color: const Color(0xFFD9D9D9),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Nunito',
                          color: Colors.black,
                        ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: FlutterFlowTheme.of(context).primaryColor,
                          labelStyle: FlutterFlowTheme.of(context).bodyText1,
                          indicatorColor:
                              FlutterFlowTheme.of(context).secondaryColor,
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.grid_on,
                                color: FlutterFlowTheme.of(context).black600,
                                size: 30,
                              ),
                            ),
                            Tab(
                              icon: Icon(
                                Icons.bookmark_border,
                                color: FlutterFlowTheme.of(context).black600,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              StreamBuilder<List<PostsRecord>>(
                                stream: queryPostsRecord(
                                  queryBuilder: (postsRecord) =>
                                      postsRecord.where('post_user',
                                          isEqualTo: currentUserReference),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  List<PostsRecord> gridViewPostsRecordList =
                                      snapshot.data!;
                                  return GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount: gridViewPostsRecordList.length,
                                    itemBuilder: (context, gridViewIndex) {
                                      final gridViewPostsRecord =
                                          gridViewPostsRecordList[
                                              gridViewIndex];
                                      var rc = RandomColor.getColor(Options(
                                          luminosity: Luminosity.dark,
                                          format: Format.hex));

                                      return InkWell(
                                        onLongPress: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                child: PostOptionsWidget(
                                                  posref: gridViewPostsRecord
                                                      .reference,
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        },
                                        child: gridViewPostsRecord.postPhoto !=
                                                ''
                                            ? Image.network(
                                                gridViewPostsRecord.postPhoto!,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                width: 100,
                                                height: 100,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: toColor(rc),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                                child: Text(
                                                  gridViewPostsRecord
                                                      .postTitle!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white70,
                                                          fontSize: 14),
                                                )),
                                      );
                                    },
                                  );
                                },
                              ),
                              StreamBuilder<List<PostsRecord>>(
                                stream: queryPostsRecord(
                                  queryBuilder: (postsRecord) =>
                                      postsRecord.where('bookmarks',
                                          arrayContains: currentUserReference),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  List<PostsRecord>
                                      bookmarkGridViewPostsRecordList =
                                      snapshot.data!;
                                  return GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        bookmarkGridViewPostsRecordList.length,
                                    itemBuilder:
                                        (context, bookmarkGridViewIndex) {
                                      final bookmarkGridViewPostsRecord =
                                          bookmarkGridViewPostsRecordList[
                                              bookmarkGridViewIndex];
                                      return InkWell(
                                        onTap: () async {
                                          isLoading = true;
                                          selected =
                                              bookmarkGridViewPostsRecord.iid!;
                                          setState(() {});

                                          context.pushNamed(
                                            'postDetail',
                                            queryParams: {
                                              'postRef': serializeParam(
                                                bookmarkGridViewPostsRecord.iid,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  const TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType
                                                        .rightToLeft,
                                              ),
                                            },
                                          );

                                          isLoading = false;
                                        },
                                        onLongPress: () async {
                                          isLoading = false;
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                child: PostOptionsWidget(
                                                  posref:
                                                      bookmarkGridViewPostsRecord
                                                          .reference,
                                                ),
                                              );
                                            },
                                          ).then((value) => setState(() {}));
                                        },
                                        child: (isLoading &&
                                                (bookmarkGridViewPostsRecord
                                                        .iid ==
                                                    selected))
                                            ? Image.asset(
                                                'assets/images/98288-loading.gif',
                                                width: 48,
                                                height: 48,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                bookmarkGridViewPostsRecord
                                                    .postPhoto!,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
