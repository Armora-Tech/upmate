import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'dart:ui';
import '../flutter_flow/custom_functions.dart' as functions;
import '../flutter_flow/random_data_util.dart' as random_data;
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({Key? key}) : super(key: key);

  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  bool isMediaUploading = false;
  String uploadedFileUrl = '';

  Completer<UsersRecord>? _documentRequestCompleter;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((currentUserDocument?.interests?.toList() ?? []).length > 0) {
        return;
      }

      context.goNamed('surveyPage');

      return;
    });

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'mainPage'});
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<UsersRecord>(
      future: (_documentRequestCompleter ??= Completer<UsersRecord>()
            ..complete(UsersRecord.getDocumentOnce(currentUserReference!)))
          .future,
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
        final mainPageUsersRecord = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          drawer: Drawer(
            elevation: 16,
            child: Stack(
              children: [
                if (FFAppState().mainMenu == 'normal')
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF293235), Color(0xFF293235)],
                            stops: [0, 1],
                            begin: AlignmentDirectional(0, -1),
                            end: AlignmentDirectional(0, 1),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 60, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final selectedMedia =
                                      await selectMediaWithSourceBottomSheet(
                                    context: context,
                                    allowPhoto: true,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    setState(() => isMediaUploading = true);
                                    var downloadUrls = <String>[];
                                    try {
                                      showUploadMessage(
                                        context,
                                        'Uploading file...',
                                        showLoading: true,
                                      );
                                      downloadUrls = (await Future.wait(
                                        selectedMedia.map(
                                          (m) async => await uploadData(
                                              m.storagePath, m.bytes),
                                        ),
                                      ))
                                          .where((u) => u != null)
                                          .map((u) => u!)
                                          .toList();
                                    } finally {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      isMediaUploading = false;
                                    }
                                    if (downloadUrls.length ==
                                        selectedMedia.length) {
                                      setState(() =>
                                          uploadedFileUrl = downloadUrls.first);
                                      showUploadMessage(context, 'Success!');
                                    } else {
                                      setState(() {});
                                      showUploadMessage(
                                          context, 'Failed to upload media');
                                      return;
                                    }
                                  }

                                  final usersUpdateData = createUsersRecordData(
                                    photoUrl: uploadedFileUrl,
                                  );
                                  await currentUserReference!
                                      .update(usersUpdateData);
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2, 0, 0, 0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => Container(
                                        width: 50,
                                        height: 50,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          valueOrDefault<String>(
                                            currentUserPhoto,
                                            'https://imgs.search.brave.com/8AotVXoc6x4ddoAEx14QkNkHX1ctJ-6AdqBVxI83jy8/rs:fit:415:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5u/dm1TaXN5V0FmTWxT/Ung4Z19MM3pBQUFB/QSZwaWQ9QXBp',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Text(
                                    currentUserDisplayName,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                child: Text(
                                  currentUserEmail,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () async {
                                context.pushNamed('premiumPage');
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: 'Premium',
                                    icon: FaIcon(
                                      FontAwesomeIcons.star,
                                      color: Colors.black,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.black,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                context.pushNamed(
                                  'accountPage',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.leftToRight,
                                    ),
                                  },
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      context.pushNamed(
                                        'accountPage',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.leftToRight,
                                          ),
                                        },
                                      );
                                    },
                                    text: 'Akun',
                                    icon: FaIcon(
                                      FontAwesomeIcons.userCircle,
                                      color: Colors.black,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.black,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                FFAppState().update(() {
                                  FFAppState().mainMenu = 'privacy';
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      FFAppState().update(() {
                                        FFAppState().mainMenu = 'privacy';
                                      });
                                    },
                                    text: 'Privasi',
                                    icon: FaIcon(
                                      FontAwesomeIcons.lock,
                                      color: Colors.black,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.black,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                context.pushNamed(
                                  'bookmarkPage',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.leftToRight,
                                    ),
                                  },
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      context.pushNamed(
                                        'bookmarkPage',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.leftToRight,
                                          ),
                                        },
                                      );
                                    },
                                    text: 'Bookmarks',
                                    icon: FaIcon(
                                      FontAwesomeIcons.solidBookmark,
                                      color: Colors.black,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.black,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Pengaturan',
                                  icon: FaIcon(
                                    FontAwesomeIcons.cog,
                                    color: Colors.black,
                                  ),
                                  options: FFButtonOptions(
                                    height: 40,
                                    color: Color(0x00FFFFFF),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Colors.black,
                                        ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                FFAppState().update(() {
                                  FFAppState().mainMenu = 'helpMenu';
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      FFAppState().update(() {
                                        FFAppState().mainMenu = 'helpMenu';
                                      });
                                    },
                                    text: 'Pusat Bantuan',
                                    icon: FaIcon(
                                      FontAwesomeIcons.questionCircle,
                                      color: Colors.black,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.black,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                context.pushNamed(
                                  'appInfo',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.scale,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  },
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      context.pushNamed(
                                        'appInfo',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.scale,
                                            alignment: Alignment.bottomCenter,
                                          ),
                                        },
                                      );
                                    },
                                    text: 'Info Aplikasi',
                                    icon: FaIcon(
                                      FontAwesomeIcons.infoCircle,
                                      color: Colors.black,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.black,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                    showLoadingIndicator: false,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFD9D9D9),
                            ),
                            InkWell(
                              onTap: () async {
                                GoRouter.of(context).prepareAuthEvent();
                                await signOut();

                                context.goNamedAuth('LoginPage', mounted);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      GoRouter.of(context).prepareAuthEvent();
                                      await signOut();

                                      context.goNamedAuth('LoginPage', mounted);
                                    },
                                    text: 'Keluar',
                                    icon: FaIcon(
                                      FontAwesomeIcons.signOutAlt,
                                      color: Colors.black,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.black,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (FFAppState().mainMenu == 'privacy')
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        FFAppState().update(() {
                                          FFAppState().mainMenu = 'normal';
                                        });
                                      },
                                      text: '',
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                      options: FFButtonOptions(
                                        height: 40,
                                        color: Color(0x00FFFFFF),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Nunito',
                                              color: Colors.black,
                                            ),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      showLoadingIndicator: false,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Privacy',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Nunito',
                                          fontSize: 20,
                                        ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          FFAppState().update(() {
                            FFAppState().mainMenu = 'profileMenu';
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color(0x411D2429),
                                offset: Offset(0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 8, 4, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Profile Photo',
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle1
                                              .override(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF090F13),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 8, 0),
                                            child: AutoSizeText(
                                              'Everyone',
                                              textAlign: TextAlign.start,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF7C8791),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color(0xFF57636C),
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (FFAppState().mainMenu == 'helpMenu')
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      FFAppState().update(() {
                                        FFAppState().mainMenu = 'normal';
                                      });
                                    },
                                    text: '',
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color:
                                          FlutterFlowTheme.of(context).black600,
                                      size: 15,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Colors.white,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    showLoadingIndicator: false,
                                  ),
                                ),
                                Text(
                                  'Pusat Bantuan',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Nunito',
                                        fontSize: 20,
                                      ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await launchURL('https://upmate.armora-tech.com/tos');
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Icon(
                                  Icons.description_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    'Terms and Conditions',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Nunito',
                                          fontSize: 20,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: FutureBuilder<List<UsersRecord>>(
                          future: queryUsersRecordOnce(
                            queryBuilder: (usersRecord) => usersRecord.where(
                                'email',
                                isEqualTo: 'care@armora-tech.com'),
                            singleRecord: true,
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
                            List<UsersRecord> csContainerUsersRecordList =
                                snapshot.data!;
                            final csContainerUsersRecord =
                                csContainerUsersRecordList.isNotEmpty
                                    ? csContainerUsersRecordList.first
                                    : null;
                            return InkWell(
                              onTap: () async {
                                context.pushNamed(
                                  'chatPage',
                                  queryParams: {
                                    'chatUser': serializeParam(
                                      csContainerUsersRecord,
                                      ParamType.Document,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    'chatUser': csContainerUsersRecord,
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Icon(
                                        FFIcons
                                            .kdlbeatsnoopcomBb958e199ce43eabfeAdobeExpress,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                        child: Text(
                                          'Armoriz Care',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          setState(() => _documentRequestCompleter = null);
                          await waitForDocumentRequestCompleter();
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      borderWidth: 1,
                                      buttonSize: 44,
                                      icon: Icon(
                                        Icons.menu_rounded,
                                        color: Color(0xFF101213),
                                        size: 24,
                                      ),
                                      onPressed: () async {
                                        scaffoldKey.currentState!.openDrawer();
                                      },
                                    ),
                                    AuthUserStreamWidget(
                                      builder: (context) => Text(
                                        FFAppState().isFirstOpen
                                            ? 'Selamat Datang'
                                            : currentUserDisplayName,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Nunito',
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => InkWell(
                                          onTap: () async {
                                            context.pushNamed(
                                              'accountPage',
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType
                                                          .leftToRight,
                                                ),
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              valueOrDefault<String>(
                                                currentUserPhoto,
                                                'https://imgs.search.brave.com/8AotVXoc6x4ddoAEx14QkNkHX1ctJ-6AdqBVxI83jy8/rs:fit:415:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5u/dm1TaXN5V0FmTWxT/Ung4Z19MM3pBQUFB/QSZwaWQ9QXBp',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 16, 16, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (FFAppState().isFirstOpen)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            2, 0, 0, 0),
                                        child: AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            currentUserDisplayName,
                                            style: FlutterFlowTheme.of(context)
                                                .title1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Colors.black,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (FFAppState().isFirstOpen)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  child: Text(
                                    'Ikuti orang, forum, event, atau topik yang anda tertarik untuk melihat postingan yang mereka bagikan',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: Color(0xFF57636C),
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 20, 24, 0),
                                child: Text(
                                  'Popular',
                                  textAlign: TextAlign.justify,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: AuthUserStreamWidget(
                                  builder: (context) =>
                                      FutureBuilder<List<InterestsRecord>>(
                                    future: queryInterestsRecordOnce(
                                      queryBuilder: (interestsRecord) =>
                                          interestsRecord.whereNotIn(
                                              'name',
                                              functions.hashtagInterest(
                                                  (currentUserDocument
                                                              ?.interests
                                                              ?.toList() ??
                                                          [])
                                                      .toList())),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                              color: Color(0x004B39EF),
                                            ),
                                          ),
                                        );
                                      }
                                      List<InterestsRecord>
                                          popularRowInterestsRecordList =
                                          snapshot.data!;
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              popularRowInterestsRecordList
                                                  .length, (popularRowIndex) {
                                            final popularRowInterestsRecord =
                                                popularRowInterestsRecordList[
                                                    popularRowIndex];
                                            return Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xFFF5F5F5),
                                              child: Container(
                                                width: 200,
                                                height: 250,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      valueOrDefault<String>(
                                                        popularRowInterestsRecord
                                                            .photoUrl,
                                                        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.P1Bkvj-lYAfpGLFTdbDnqQAAAA%26pid%3DApi&f=1&ipt=8982699812119b9ba99b42d4d88c6a1cc7ea3d20e29b9f9ce5935efa6280a85b&ipo=images',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 5, 0, 0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0x983D3D3D),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                            color: Color(
                                                                0x983D3D3D),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(5,
                                                                      0, 5, 0),
                                                          child: Text(
                                                            'Topik',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 11,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1, 1),
                                                      child: ClipRRect(
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                            sigmaX: 2,
                                                            sigmaY: 2,
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0x80272727),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  popularRowInterestsRecord
                                                                      .name!,
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
                                                                if ('0' == '1')
                                                                  Text(
                                                                    'Diikuti oleh Percy Hedinson, Riska Nur, Lia Dahlia dan 9 Lainnya',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    if (valueOrDefault<
                                                                            bool>(
                                                                        currentUserDocument
                                                                            ?.isPremium,
                                                                        false)) {
                                                                      if ((currentUserDocument?.interests?.toList() ?? [])
                                                                              .length >=
                                                                          8) {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              content: Text('Kmu cuma bisa punya 8 tag interest'),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        return;
                                                                      }
                                                                    } else {
                                                                      if ((currentUserDocument?.interests?.toList() ?? [])
                                                                              .length >=
                                                                          4) {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              content: Text('Kmu cuma bisa punya 4  tag interest'),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: Text('Ok'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        return;
                                                                      }
                                                                    }

                                                                    final usersUpdateData =
                                                                        {
                                                                      'interests':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        functions
                                                                            .sintenrest(popularRowInterestsRecord.name!)
                                                                      ]),
                                                                    };
                                                                    await currentUserReference!
                                                                        .update(
                                                                            usersUpdateData);

                                                                    final interestsUpdateData =
                                                                        {
                                                                      'followers':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        currentUserReference
                                                                      ]),
                                                                    };
                                                                    await popularRowInterestsRecord
                                                                        .reference
                                                                        .update(
                                                                            interestsUpdateData);
                                                                  },
                                                                  text: 'Ikuti',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: 130,
                                                                    height: 40,
                                                                    color: Color(
                                                                        0xFF475054),
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle2
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 20, 24, 0),
                                child: Text(
                                  'Orang dengan interest sama',
                                  textAlign: TextAlign.justify,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: AuthUserStreamWidget(
                                  builder: (context) =>
                                      FutureBuilder<List<UsersRecord>>(
                                    future: queryUsersRecordOnce(
                                      queryBuilder: (usersRecord) =>
                                          usersRecord.whereArrayContainsAny(
                                              'interests',
                                              (currentUserDocument?.interests
                                                      ?.toList() ??
                                                  [])),
                                      limit: 10,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                            ),
                                          ),
                                        );
                                      }
                                      List<UsersRecord>
                                          peoplereccRowUsersRecordList =
                                          snapshot.data!
                                              .where((u) =>
                                                  u.uid != currentUserUid)
                                              .toList();
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(
                                              peoplereccRowUsersRecordList
                                                  .length,
                                              (peoplereccRowIndex) {
                                            final peoplereccRowUsersRecord =
                                                peoplereccRowUsersRecordList[
                                                    peoplereccRowIndex];
                                            return Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              child: Container(
                                                width: 200,
                                                height: 250,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      valueOrDefault<String>(
                                                        peoplereccRowUsersRecord
                                                            .photoUrl,
                                                        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.VORoQXOzfnrc1yOV4anzxQHaHa%26pid%3DApi%26h%3D160&f=1&ipt=6e1ae93c3fc52057f78d8a58710494b23a6881a41b9dd2185da8e430dfe53e1e&ipo=images',
                                                      ),
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    width: 0,
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1, 1),
                                                      child: ClipRRect(
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                            sigmaX: 2,
                                                            sigmaY: 2,
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0x80272727),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  peoplereccRowUsersRecord
                                                                      .displayName!,
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
                                                                  functions.joinLString(
                                                                      peoplereccRowUsersRecord
                                                                          .interests!
                                                                          .toList(),
                                                                      ' | ')!,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 1,
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
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20,
                                                                          5,
                                                                          20,
                                                                          0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () {
                                                                      print(
                                                                          'Button pressed ...');
                                                                    },
                                                                    text:
                                                                        'Chat',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          40,
                                                                      color: Color(
                                                                          0xFF475054),
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .subtitle2
                                                                          .override(
                                                                            fontFamily:
                                                                                'Nunito',
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBtnText,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: AuthUserStreamWidget(
                                  builder: (context) =>
                                      StreamBuilder<List<PostsRecord>>(
                                    stream: queryPostsRecord(
                                      queryBuilder: (postsRecord) => postsRecord
                                          .whereArrayContainsAny(
                                              'interests',
                                              (currentUserDocument?.interests
                                                      ?.toList() ??
                                                  []))
                                          .orderBy('time_posted',
                                              descending: true),
                                      limit: 50,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                            ),
                                          ),
                                        );
                                      }
                                      List<PostsRecord>
                                          personalizedColumnPostsRecordList =
                                          snapshot.data!;
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                            personalizedColumnPostsRecordList
                                                .length,
                                            (personalizedColumnIndex) {
                                          final personalizedColumnPostsRecord =
                                              personalizedColumnPostsRecordList[
                                                  personalizedColumnIndex];
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xFFC8C8C8),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(24, 0,
                                                                    0, 0),
                                                        child: Container(
                                                          width: 34,
                                                          height: 34,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            valueOrDefault<
                                                                String>(
                                                              personalizedColumnPostsRecord
                                                                  .postPhoto,
                                                              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.VORoQXOzfnrc1yOV4anzxQHaHa%26pid%3DApi%26h%3D160&f=1&ipt=6e1ae93c3fc52057f78d8a58710494b23a6881a41b9dd2185da8e430dfe53e1e&ipo=images',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5, 0, 0, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              personalizedColumnPostsRecord
                                                                  .postTitle!
                                                                  .maybeHandleOverflow(
                                                                      maxChars:
                                                                          20),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                            FutureBuilder<
                                                                UsersRecord>(
                                                              future: UsersRecord
                                                                  .getDocumentOnce(
                                                                      personalizedColumnPostsRecord
                                                                          .postUser!),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryColor,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                final textUsersRecord =
                                                                    snapshot
                                                                        .data!;
                                                                return Text(
                                                                  '${textUsersRecord.displayName} | ${functions.joinLString(personalizedColumnPostsRecord.interests!.toList(), ', ')}'
                                                                      .maybeHandleOverflow(
                                                                    maxChars:
                                                                        30,
                                                                    replacement:
                                                                        '…',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (personalizedColumnPostsRecord
                                                            .postPhoto !=
                                                        null &&
                                                    personalizedColumnPostsRecord
                                                            .postPhoto !=
                                                        '')
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                24, 5, 24, 5),
                                                    child: Image.network(
                                                      personalizedColumnPostsRecord
                                                          .postPhoto!,
                                                      width: double.infinity,
                                                      height: 200,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24, 0, 24, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      if (random_data
                                                              .randomInteger(
                                                                  0, 10) ==
                                                          11)
                                                        Expanded(
                                                          child: Wrap(
                                                            spacing: 0,
                                                            runSpacing: 0,
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .start,
                                                            direction:
                                                                Axis.horizontal,
                                                            runAlignment:
                                                                WrapAlignment
                                                                    .start,
                                                            verticalDirection:
                                                                VerticalDirection
                                                                    .down,
                                                            clipBehavior:
                                                                Clip.none,
                                                            children: [
                                                              Visibility(
                                                                visible: personalizedColumnPostsRecord
                                                                            .postPhoto ==
                                                                        null ||
                                                                    personalizedColumnPostsRecord
                                                                            .postPhoto ==
                                                                        '',
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          5),
                                                                  child: Text(
                                                                    personalizedColumnPostsRecord
                                                                        .postDescription!
                                                                        .maybeHandleOverflow(
                                                                      maxChars:
                                                                          100,
                                                                      replacement:
                                                                          '…',
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                    maxLines: 3,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Visibility(
                                                                visible: personalizedColumnPostsRecord
                                                                            .postPhoto ==
                                                                        null ||
                                                                    personalizedColumnPostsRecord
                                                                            .postPhoto ==
                                                                        '',
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          5,
                                                                          0,
                                                                          5),
                                                                  child: Text(
                                                                    'selengkapnya',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              ToggleIcon(
                                                                onPressed:
                                                                    () async {
                                                                  setState(() => FFAppState()
                                                                          .unused =
                                                                      !FFAppState()
                                                                          .unused);
                                                                },
                                                                value:
                                                                    FFAppState()
                                                                        .unused,
                                                                onIcon: Icon(
                                                                  Icons
                                                                      .share_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 25,
                                                                ),
                                                                offIcon: Icon(
                                                                  Icons
                                                                      .share_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 25,
                                                                ),
                                                              ),
                                                              Text(
                                                                '0',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
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
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        ToggleIcon(
                                                          onPressed: () async {
                                                            final bookmarksElement =
                                                                currentUserReference;
                                                            final bookmarksUpdate = personalizedColumnPostsRecord
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
                                                            final postsUpdateData =
                                                                {
                                                              'bookmarks':
                                                                  bookmarksUpdate,
                                                            };
                                                            await personalizedColumnPostsRecord
                                                                .reference
                                                                .update(
                                                                    postsUpdateData);
                                                          },
                                                          value: personalizedColumnPostsRecord
                                                              .bookmarks!
                                                              .toList()
                                                              .contains(
                                                                  currentUserReference),
                                                          onIcon: Icon(
                                                            Icons
                                                                .bookmark_outlined,
                                                            color: Colors.black,
                                                            size: 25,
                                                          ),
                                                          offIcon: Icon(
                                                            Icons
                                                                .bookmark_border_outlined,
                                                            color: Colors.black,
                                                            size: 25,
                                                          ),
                                                        ),
                                                        Text(
                                                          formatNumber(
                                                            personalizedColumnPostsRecord
                                                                .bookmarks!
                                                                .toList()
                                                                .length,
                                                            formatType:
                                                                FormatType
                                                                    .compact,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          'postDetail',
                                                          queryParams: {
                                                            'postRef':
                                                                serializeParam(
                                                              personalizedColumnPostsRecord
                                                                  .iid,
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .rightToLeft,
                                                            ),
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            context.pushNamed(
                                                              'postDetail',
                                                              queryParams: {
                                                                'postRef':
                                                                    serializeParam(
                                                                  personalizedColumnPostsRecord
                                                                      .iid,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                              extra: <String,
                                                                  dynamic>{
                                                                kTransitionInfoKey:
                                                                    TransitionInfo(
                                                                  hasTransition:
                                                                      true,
                                                                  transitionType:
                                                                      PageTransitionType
                                                                          .rightToLeft,
                                                                ),
                                                              },
                                                            );
                                                          },
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            9,
                                                                            9,
                                                                            9,
                                                                            9),
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    context
                                                                        .pushNamed(
                                                                      'postDetail',
                                                                      queryParams:
                                                                          {
                                                                        'postRef':
                                                                            serializeParam(
                                                                          personalizedColumnPostsRecord
                                                                              .iid,
                                                                          ParamType
                                                                              .String,
                                                                        ),
                                                                      }.withoutNulls,
                                                                      extra: <
                                                                          String,
                                                                          dynamic>{
                                                                        kTransitionInfoKey:
                                                                            TransitionInfo(
                                                                          hasTransition:
                                                                              true,
                                                                          transitionType:
                                                                              PageTransitionType.rightToLeft,
                                                                        ),
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    FFIcons
                                                                        .kbubble,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 24,
                                                                  ),
                                                                ),
                                                              ),
                                                              FutureBuilder<
                                                                  List<
                                                                      CommentsRecord>>(
                                                                future:
                                                                    queryCommentsRecordOnce(
                                                                  parent: personalizedColumnPostsRecord
                                                                      .reference,
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryColor,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<CommentsRecord>
                                                                      textCommentsRecordList =
                                                                      snapshot
                                                                          .data!;
                                                                  return InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      context
                                                                          .pushNamed(
                                                                        'postDetail',
                                                                        queryParams:
                                                                            {
                                                                          'postRef':
                                                                              serializeParam(
                                                                            personalizedColumnPostsRecord.iid,
                                                                            ParamType.String,
                                                                          ),
                                                                        }.withoutNulls,
                                                                        extra: <
                                                                            String,
                                                                            dynamic>{
                                                                          kTransitionInfoKey:
                                                                              TransitionInfo(
                                                                            hasTransition:
                                                                                true,
                                                                            transitionType:
                                                                                PageTransitionType.rightToLeft,
                                                                          ),
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      formatNumber(
                                                                        personalizedColumnPostsRecord
                                                                            .numComments!,
                                                                        formatType:
                                                                            FormatType.compact,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                'Nunito',
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        if (personalizedColumnPostsRecord
                                                            .likes!
                                                            .toList()
                                                            .contains(
                                                                currentUserReference)) {
                                                          final postsUpdateData =
                                                              {
                                                            'likes': FieldValue
                                                                .arrayRemove([
                                                              currentUserReference
                                                            ]),
                                                          };
                                                          await personalizedColumnPostsRecord
                                                              .reference
                                                              .update(
                                                                  postsUpdateData);
                                                        } else {
                                                          final postsUpdateData =
                                                              {
                                                            'likes': FieldValue
                                                                .arrayRemove([
                                                              currentUserReference
                                                            ]),
                                                          };
                                                          await personalizedColumnPostsRecord
                                                              .reference
                                                              .update(
                                                                  postsUpdateData);
                                                        }
                                                      },
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          ToggleIcon(
                                                            onPressed:
                                                                () async {
                                                              final likesElement =
                                                                  currentUserReference;
                                                              final likesUpdate = personalizedColumnPostsRecord
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
                                                              final postsUpdateData =
                                                                  {
                                                                'likes':
                                                                    likesUpdate,
                                                              };
                                                              await personalizedColumnPostsRecord
                                                                  .reference
                                                                  .update(
                                                                      postsUpdateData);
                                                            },
                                                            value: personalizedColumnPostsRecord
                                                                .likes!
                                                                .toList()
                                                                .contains(
                                                                    currentUserReference),
                                                            onIcon: Icon(
                                                              Icons.favorite,
                                                              color: Color(
                                                                  0xFFFF0808),
                                                              size: 25,
                                                            ),
                                                            offIcon: Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              size: 25,
                                                            ),
                                                          ),
                                                          Text(
                                                            formatNumber(
                                                              personalizedColumnPostsRecord
                                                                  .likes!
                                                                  .toList()
                                                                  .length,
                                                              formatType:
                                                                  FormatType
                                                                      .compact,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24, 0, 24, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Wrap(
                                                          spacing: 0,
                                                          runSpacing: 0,
                                                          alignment:
                                                              WrapAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .start,
                                                          direction:
                                                              Axis.horizontal,
                                                          runAlignment:
                                                              WrapAlignment
                                                                  .start,
                                                          verticalDirection:
                                                              VerticalDirection
                                                                  .down,
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          5),
                                                              child: Text(
                                                                personalizedColumnPostsRecord
                                                                    .postDescription!
                                                                    .maybeHandleOverflow(
                                                                        maxChars:
                                                                            50),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (personalizedColumnPostsRecord
                                                        .numComments! >
                                                    5)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                24, 0, 24, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      5, 0, 5),
                                                          child: Text(
                                                            'Lihat semua ${personalizedColumnPostsRecord.numComments.toString()} komentar'
                                                                .maybeHandleOverflow(
                                                              maxChars: 100,
                                                              replacement: '…',
                                                            ),
                                                            maxLines: 3,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: Color(
                                                                      0xFF767676),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                FutureBuilder<
                                                    List<CommentsRecord>>(
                                                  future:
                                                      queryCommentsRecordOnce(
                                                    parent:
                                                        personalizedColumnPostsRecord
                                                            .reference,
                                                    queryBuilder:
                                                        (commentsRecord) =>
                                                            commentsRecord
                                                                .orderBy('date',
                                                                    descending:
                                                                        true),
                                                    limit: 3,
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
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<CommentsRecord>
                                                        columnCommentsRecordList =
                                                        snapshot.data!;
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: List.generate(
                                                          columnCommentsRecordList
                                                              .length,
                                                          (columnIndex) {
                                                        final columnCommentsRecord =
                                                            columnCommentsRecordList[
                                                                columnIndex];
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24,
                                                                          0,
                                                                          24,
                                                                          0),
                                                              child: FutureBuilder<
                                                                  UsersRecord>(
                                                                future: UsersRecord
                                                                    .getDocumentOnce(
                                                                        columnCommentsRecord
                                                                            .userRef!),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryColor,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  final rowUsersRecord =
                                                                      snapshot
                                                                          .data!;
                                                                  return Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            15,
                                                                        height:
                                                                            15,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            rowUsersRecord.photoUrl,
                                                                            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.VORoQXOzfnrc1yOV4anzxQHaHa%26pid%3DApi%26h%3D160&f=1&ipt=6e1ae93c3fc52057f78d8a58710494b23a6881a41b9dd2185da8e430dfe53e1e&ipo=images',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          rowUsersRecord
                                                                              .displayName!,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Nunito',
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          columnCommentsRecord
                                                                              .text!
                                                                              .maybeHandleOverflow(
                                                                            maxChars:
                                                                                15,
                                                                            replacement:
                                                                                '…',
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      if (functions
                                                                              .scount(columnCommentsRecord.text!) >
                                                                          20)
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            'Selengkapnya',
                                                                            maxLines:
                                                                                1,
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Nunito',
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24,
                                                                          0,
                                                                          24,
                                                                          7),
                                                              child: Text(
                                                                dateTimeFormat(
                                                                  'relative',
                                                                  columnCommentsRecord
                                                                      .date!,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  ),
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
          ),
        );
      },
    );
  }

  Future waitForDocumentRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _documentRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
