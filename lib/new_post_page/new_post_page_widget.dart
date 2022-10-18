import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPostPageWidget extends StatefulWidget {
  const NewPostPageWidget({Key? key}) : super(key: key);

  @override
  _NewPostPageWidgetState createState() => _NewPostPageWidgetState();
}

class _NewPostPageWidgetState extends State<NewPostPageWidget> {
  bool isMediaUploading = false;
  String uploadedFileUrl = '';

  TextEditingController? textController1;
  TextEditingController? textController2;
  List<String>? choiceChipsValues;
  PostsRecord? idpost;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'newPostPage'});
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Create Post',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.94,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: InkWell(
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
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              constraints: BoxConstraints(
                                maxWidth: double.infinity,
                                maxHeight: double.infinity,
                              ),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: Image.network(
                                    '',
                                  ).image,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 6,
                                    color: Color(0x3A000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Stack(
                                  children: [
                                    if (uploadedFileUrl != null &&
                                        uploadedFileUrl != '')
                                      Image.network(
                                        uploadedFileUrl,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    Text(
                                      'Add photo +',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .grayIcon,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: textController1,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter post title',
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            20, 32, 20, 12),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: textController2,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter post details here...',
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            20, 32, 20, 12),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AuthUserStreamWidget(
              child: FlutterFlowChoiceChips(
                options: (currentUserDocument?.interests?.toList() ?? [])
                    .map((label) => ChipData(label))
                    .toList(),
                onChanged: (val) => setState(() => choiceChipsValues = val),
                selectedChipStyle: ChipStyle(
                  backgroundColor: Color(0xFF323B45),
                  textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                  iconColor: Colors.white,
                  iconSize: 18,
                  elevation: 4,
                ),
                unselectedChipStyle: ChipStyle(
                  backgroundColor: Colors.white,
                  textStyle: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF323B45),
                      ),
                  iconColor: Color(0xFF323B45),
                  iconSize: 18,
                  elevation: 4,
                ),
                chipSpacing: 20,
                multiselect: true,
                initialized: choiceChipsValues != null,
                alignment: WrapAlignment.start,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 20),
              child: FFButtonWidget(
                onPressed: () async {
                  setState(
                      () => FFAppState().tiid = 'PST-${random_data.randomString(
                            6,
                            6,
                            true,
                            true,
                            true,
                          )}');

                  final postsCreateData = {
                    ...createPostsRecordData(
                      postPhoto: uploadedFileUrl,
                      postDescription: textController2!.text,
                      postUser: currentUserReference,
                      timePosted: getCurrentTimestamp,
                      postTitle: textController1!.text,
                      iid: FFAppState().tiid,
                    ),
                    'interests': choiceChipsValues,
                  };
                  var postsRecordReference = PostsRecord.collection.doc();
                  await postsRecordReference.set(postsCreateData);
                  idpost = PostsRecord.getDocumentFromData(
                      postsCreateData, postsRecordReference);
                  await AddPostCall.call(
                    iid: FFAppState().tiid,
                    name: textController1!.text,
                    owner: currentUserUid,
                    desc: textController2!.text,
                    tsmt: getCurrentTimestamp.toString(),
                    tags:
                        functions.joinLString(choiceChipsValues!.toList(), ';'),
                    image: uploadedFileUrl,
                  );
                  Navigator.pop(context);

                  setState(() {});
                },
                text: 'Create Post',
                options: FFButtonOptions(
                  width: 270,
                  height: 50,
                  color: FlutterFlowTheme.of(context).btnColors,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                  elevation: 3,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
