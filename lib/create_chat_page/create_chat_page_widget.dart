import 'package:marquee_widget/marquee_widget.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';

class CreateChatPageWidget extends StatefulWidget {
  const CreateChatPageWidget({Key? key}) : super(key: key);

  @override
  _CreateChatPageWidgetState createState() => _CreateChatPageWidgetState();
}

class _CreateChatPageWidgetState extends State<CreateChatPageWidget> {
  List<UsersRecord> simpleSearchResults = [];
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'createChatPage'});
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          buttonSize: 24,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF95A1AC),
            size: 24,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mulai obrolan pribadi',
              style: FlutterFlowTheme.of(context).subtitle1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF95A1AC),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              'Pilih satu orang untuk memulai.',
              style: FlutterFlowTheme.of(context).bodyText2.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF1A1F24),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFDBE2E7),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(0),
            ),
            alignment: AlignmentDirectional(0, 0),
            child: TextFormField(
              controller: textController,
              onChanged: (_) => EasyDebounce.debounce(
                'textController',
                Duration(milliseconds: 2000),
                () async {
                  await queryUsersRecordOnce()
                      .then(
                        (records) => simpleSearchResults = TextSearch(
                          records
                              .map(
                                (record) => TextSearchItem(
                                    record, [record.displayName!]),
                              )
                              .toList(),
                        )
                            .search(textController!.text)
                            .map((r) => r.object)
                            .take(50)
                            .toList(),
                      )
                      .onError((_, __) => simpleSearchResults = [])
                      .whenComplete(() => setState(() {}));
                },
              ),
              obscureText: false,
              decoration: InputDecoration(
                hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF95A1AC),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                contentPadding: EdgeInsetsDirectional.fromSTEB(24, 14, 0, 0),
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: Color(0xFF95A1AC),
                  size: 24,
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF95A1AC),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          Expanded(
            child: AuthUserStreamWidget(
              builder: (context) => StreamBuilder<List<UsersRecord>>(
                stream: queryUsersRecord(
                  queryBuilder: (usersRecord) =>
                      usersRecord.whereArrayContainsAny('interests',
                          (currentUserDocument?.interests?.toList() ?? [])),
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
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  List<UsersRecord> listViewNormalUsersRecordList = snapshot
                      .data!
                      .where((u) => u.uid != currentUserUid)
                      .toList();
                  if (simpleSearchResults.length > 0) {
                    listViewNormalUsersRecordList = simpleSearchResults;
                  }
                  return Column(children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewNormalUsersRecordList.length,
                      itemBuilder: (context, listViewNormalIndex) {
                        final listViewNormalUsersRecord =
                            listViewNormalUsersRecordList[listViewNormalIndex];

                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                          child: InkWell(
                              onTap: () async {
                                if (Navigator.of(context).canPop()) {
                                  context.pop();
                                }
                                context.pushNamed(
                                  'chatPage',
                                  queryParams: {
                                    'chatUser': serializeParam(
                                      listViewNormalUsersRecord,
                                      ParamType.Document,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    'chatUser': listViewNormalUsersRecord,
                                  },
                                );
                              },
                              child: Container(
                                child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: Container(
                                      // direction: Axis.horizontal,
                                      // crossAxisAlignment:
                                      //     WrapCrossAlignment.center,
                                      // alignment: WrapAlignment.spaceBetween,
                                      child: Row(
                                        children: [
                                          Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Color(0xFF4E39F9),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 2, 2, 2),
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    listViewNormalUsersRecord
                                                        .photoUrl!,
                                                    'https://ik.imagekit.io/mofh0plv6/emptyProfile__JVYIERtk.webp?tr=w-50,h-50',
                                                  ),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              // child:
                                              // Center(
                                              child: Marquee(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  listViewNormalUsersRecord
                                                      .displayName!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1,
                                                ),
                                                Text(functions.joinLString(
                                                    listViewNormalUsersRecord
                                                        .interests!
                                                        .where((e) =>
                                                            currentUserDocument!
                                                                .interests!
                                                                .contains(e))
                                                        .toList(),
                                                    ', ')!),
                                              ],
                                            ),
                                          )
                                              // )
                                              ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.chevron_right_outlined,
                                                color: Colors.black,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              )),
                        );
                      },
                    ))
                  ]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
