import '../account_page/account_page_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../interest_page/interest_page_widget.dart';
import '../login_page/login_page_widget.dart';
import '../rating_page/rating_page_widget.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({Key? key}) : super(key: key);

  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  bool isMediaUploading = false;
  String uploadedFileUrl = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((currentUserDocument?.interests?.toList() ?? []).length > 0) {
        return;
      }

      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => InterestPageWidget(),
        ),
        (r) => false,
      );
    });

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'mainPage'});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference!),
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
            child: Column(
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
                                selectedMedia.every((m) => validateFileFormat(
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
                              if (downloadUrls.length == selectedMedia.length) {
                                setState(
                                    () => uploadedFileUrl = downloadUrls.first);
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
                            await currentUserReference!.update(usersUpdateData);
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                              child: AuthUserStreamWidget(
                                child: Container(
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
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: AuthUserStreamWidget(
                            child: Text(
                              currentUserDisplayName,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          child: Text(
                            currentUserEmail,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
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
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RatingPageWidget(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Rate Us',
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
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountPageWidget(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AccountPageWidget(),
                                      ),
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
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
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
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
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
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: FFButtonWidget(
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
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
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
                                    fontFamily: 'Poppins',
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
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'FAQ',
                            icon: FaIcon(
                              FontAwesomeIcons.solidQuestionCircle,
                              color: Colors.black,
                            ),
                            options: FFButtonOptions(
                              height: 40,
                              color: Color(0x00FFFFFF),
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Poppins',
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
                      Divider(
                        thickness: 1,
                        color: Color(0xFFD9D9D9),
                      ),
                      InkWell(
                        onTap: () async {
                          await signOut();
                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPageWidget(),
                            ),
                            (r) => false,
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                await signOut();
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPageWidget(),
                                  ),
                                  (r) => false,
                                );
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
                                      fontFamily: 'Poppins',
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
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
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
                                  Text(
                                    'Selamat Datang',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Nunito',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 0),
                                    child: AuthUserStreamWidget(
                                      child: InkWell(
                                        onTap: () async {
                                          scaffoldKey.currentState!
                                              .openDrawer();
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 16, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        2, 0, 0, 0),
                                    child: AuthUserStreamWidget(
                                      child: Text(
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
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
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
                                child: StreamBuilder<List<InterestsRecord>>(
                                  stream: queryInterestsRecord(
                                    queryBuilder: (interestsRecord) =>
                                        interestsRecord.whereNotIn(
                                            'name',
                                            (currentUserDocument?.interests
                                                    ?.toList() ??
                                                [])),
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
                                    List<InterestsRecord>
                                        rowInterestsRecordList = snapshot.data!;
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                            rowInterestsRecordList.length,
                                            (rowIndex) {
                                          final rowInterestsRecord =
                                              rowInterestsRecordList[rowIndex];
                                          return Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Color(0xFFF5F5F5),
                                            child: Container(
                                              width: 200,
                                              height: 250,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    valueOrDefault<String>(
                                                      rowInterestsRecord
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
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x983D3D3D),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              Color(0x983D3D3D),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5, 0, 5, 0),
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
                                                    child: ClipRect(
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
                                                                rowInterestsRecord
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
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                ),
                                                              FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  final usersUpdateData =
                                                                      {
                                                                    'interests':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      rowInterestsRecord
                                                                          .name
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
                                                                  await rowInterestsRecord
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
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
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
                                  EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
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
                            if ('0' == '1')
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Color(0xFFF5F5F5),
                                        child: Container(
                                          width: 200,
                                          height: 250,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: CachedNetworkImageProvider(
                                                'data:image/png;base64,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',
                                              ),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 0, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x983D3D3D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                      color: Color(0x983D3D3D),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 5, 0),
                                                    child: Text(
                                                      'Topik',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(1, 1),
                                                child: ClipRect(
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                      sigmaX: 2,
                                                      sigmaY: 2,
                                                    ),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x80272727),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'UI/UX Design',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBtnText,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          Text(
                                                            'Diikuti oleh Percy Hedinson, Riska Nur, Lia Dahlia dan 9 Lainnya',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              print(
                                                                  'Button pressed ...');
                                                            },
                                                            text: 'Ikuti',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 130,
                                                              height: 40,
                                                              color: Color(
                                                                  0xFF475054),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
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
                                      ),
                                      Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Color(0xFFF5F5F5),
                                        child: Container(
                                          width: 200,
                                          height: 250,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: CachedNetworkImageProvider(
                                                'data:image/png;base64,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',
                                              ),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 0, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x983D3D3D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                      color: Color(0x983D3D3D),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 5, 0),
                                                    child: Text(
                                                      'Topik',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(1, 1),
                                                child: ClipRect(
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                      sigmaX: 2,
                                                      sigmaY: 2,
                                                    ),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x80272727),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'UI/UX Design',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBtnText,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          Text(
                                                            'Diikuti oleh Percy Hedinson, Riska Nur, Lia Dahlia dan 9 Lainnya',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                          FFButtonWidget(
                                                            onPressed: () {
                                                              print(
                                                                  'Button pressed ...');
                                                            },
                                                            text: 'Ikuti',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 130,
                                                              height: 40,
                                                              color: Color(
                                                                  0xFF475054),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
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
                                      ),
                                    ],
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
          ),
        );
      },
    );
  }
}
