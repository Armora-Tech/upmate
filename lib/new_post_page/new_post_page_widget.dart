// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/foundation.dart';

import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewPostPageWidget extends StatefulWidget {
  const NewPostPageWidget({
    Key? key,
    this.prevPage,
  }) : super(key: key);

  final String? prevPage;

  @override
  _NewPostPageWidgetState createState() => _NewPostPageWidgetState();
}

class _NewPostPageWidgetState extends State<NewPostPageWidget> {
  bool isMediaUploading = false;
  var uploadedFileBytes = Uint8List.fromList([]);
  TextEditingController? postInpController;
  TextEditingController? descInpController;
  List<String>? choiceChipsValues;
  ApiCallResponse? uploadRes;
  PostsRecord? idpost;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    descInpController = TextEditingController();
    postInpController = TextEditingController();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'newPostPage'});
  }

  @override
  void dispose() {
    descInpController?.dispose();
    postInpController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (kDebugMode) {
      print("INITIAL VALUE: $uploadedFileBytes");
    }
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
        // actions: [
        //   Padding(
        //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
        //     child: FlutterFlowIconButton(
        //       borderColor: Colors.transparent,
        //       borderRadius: 30,
        //       buttonSize: 48,
        //       icon: Icon(
        //         Icons.close_rounded,
        //         color: FlutterFlowTheme.of(context).secondaryText,
        //         size: 30,
        //       ),
        //       onPressed: () async {
        //         Navigator.pop(context);
        //       },
        //     ),
        //   ),
        // ],
        centerTitle: false,
        elevation: 0,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 4, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                final selectedMedia =
                                    await selectMediaWithSourceBottomSheet(
                                  context: context,
                                  maxWidth: 1200.00,
                                  imageQuality: 50,
                                  allowPhoto: true,
                                );
                                if (kDebugMode) {
                                  print("MEDIA RES: $selectedMedia");
                                }
                                if (selectedMedia == null) {
                                  uploadedFileBytes = Uint8List.fromList([]);
                                  setState(() {});
                                }

                                if (selectedMedia != null &&
                                    selectedMedia.every((m) =>
                                        validateFileFormat(
                                            m.storagePath, context))) {
                                  setState(() => isMediaUploading = true);
                                  var selectedMediaBytes = <Uint8List>[];
                                  try {
                                    showUploadMessage(
                                      context,
                                      'Uploading file...',
                                      showLoading: true,
                                    );
                                    selectedMediaBytes = selectedMedia
                                        .map((m) => m.bytes!)
                                        .toList();
                                  } finally {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    isMediaUploading = false;
                                  }
                                  if (selectedMediaBytes.length ==
                                      selectedMedia.length) {
                                    setState(() => uploadedFileBytes =
                                        selectedMediaBytes.first);
                                    showUploadMessage(context, 'Success!');
                                  } else {
                                    if (kDebugMode) {
                                      print("HASILBYTE: $selectedMediaBytes");
                                    }
                                    setState(() {});
                                    showUploadMessage(
                                        context, 'Failed to upload media');
                                    return;
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                constraints: const BoxConstraints(
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
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 6,
                                      color: Color(0x3A000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Stack(
                                    children: [
                                      if (uploadedFileBytes.isNotEmpty)
                                        Image.memory(
                                          uploadedFileBytes,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.fill,
                                        ),
                                      if (uploadedFileBytes.isEmpty)
                                        Text(
                                          'Add photo +',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Nunito',
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: postInpController,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      'postInpController',
                                      const Duration(milliseconds: 2000),
                                      () => setState(() {}),
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter post title',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFBEFEF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFBEFEF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 32, 20, 12),
                                      suffixIcon:
                                          postInpController!.text.isNotEmpty
                                              ? InkWell(
                                                  onTap: () async {
                                                    postInpController?.clear();
                                                    setState(() {});
                                                  },
                                                  child: const Icon(
                                                    Icons.clear,
                                                    color: Color(0xFF757575),
                                                    size: 22,
                                                  ),
                                                )
                                              : null,
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    textAlign: TextAlign.start,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Field is required';
                                      }

                                      if (val.length > 25) {
                                        return 'Maximum 25 characters allowed, currently ${val.length}.';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 12, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: descInpController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter post details here...',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFBEFEF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFBEFEF),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 32, 20, 12),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Field is required';
                                      }

                                      if (val.length > 50) {
                                        return 'Maximum 50 characters allowed, currently ${val.length}.';
                                      }

                                      return null;
                                    },
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
                builder: (context) => FlutterFlowChoiceChips(
                  options: (currentUserDocument?.interests?.toList() ?? [])
                      .map((label) => ChipData(label))
                      .toList(),
                  onChanged: (val) => setState(() => choiceChipsValues = val),
                  selectedChipStyle: ChipStyle(
                    backgroundColor: const Color(0xFF323B45),
                    textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Nunito',
                          color: Colors.white,
                        ),
                    iconColor: Colors.white,
                    iconSize: 18,
                    elevation: 4,
                  ),
                  unselectedChipStyle: ChipStyle(
                    backgroundColor: Colors.white,
                    textStyle: FlutterFlowTheme.of(context).bodyText2.override(
                          fontFamily: 'Nunito',
                          color: const Color(0xFF323B45),
                        ),
                    iconColor: const Color(0xFF323B45),
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 20),
                child: FFButtonWidget(
                  onPressed: () async {
                    var shouldSetState = false;
                    if (choiceChipsValues!.isEmpty) {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            content: const Text(
                                'Kamu harus memilih minimal 1 hashtag'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext),
                                child: const Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                      if (shouldSetState) setState(() {});
                      return;
                    }
                    FFAppState().update(() {
                      FFAppState().tiid = 'PST-${random_data.randomString(
                        6,
                        6,
                        true,
                        true,
                        true,
                      )}';
                    });
                    uploadRes = await ImageKitUploadCall.call(
                      ref: currentUserUid,
                      img: uploadedFileBytes,
                    );
                    shouldSetState = true;

                    final postsCreateData = {
                      ...createPostsRecordData(
                        postPhoto: getJsonField(
                          (uploadRes?.jsonBody ?? ''),
                          r'''$.url''',
                        ),
                        postDescription: descInpController!.text,
                        postUser: currentUserReference,
                        timePosted: getCurrentTimestamp,
                        postTitle: postInpController!.text,
                        iid: FFAppState().tiid,
                      ),
                      'interests': choiceChipsValues,
                    };
                    var postsRecordReference = PostsRecord.collection.doc();
                    await postsRecordReference.set(postsCreateData);
                    idpost = PostsRecord.getDocumentFromData(
                        postsCreateData, postsRecordReference);
                    shouldSetState = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Post created successfully.',
                          style: GoogleFonts.getFont(
                            'Nunito',
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        duration: const Duration(milliseconds: 2000),
                        backgroundColor: const Color(0x00000000),
                      ),
                    );

                    context.goNamed(
                      'mainPage',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                        ),
                      },
                    );

                    if (shouldSetState) setState(() {});
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
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
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
