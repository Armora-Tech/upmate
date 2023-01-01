import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/chats_options_widget.dart';
import '../flutter_flow/chat/index.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AllChatPageWidget extends StatefulWidget {
  const AllChatPageWidget({Key? key}) : super(key: key);

  @override
  _AllChatPageWidgetState createState() => _AllChatPageWidgetState();
}

class _AllChatPageWidgetState extends State<AllChatPageWidget> {
  List<UsersRecord>? algoliaSearchResults = [];
  TextEditingController? textController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'allChatPage'});
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

    return StreamBuilder<List<ChatsRecord>>(
      stream: queryChatsRecord(
        queryBuilder: (chatsRecord) => chatsRecord
            .where('users', arrayContains: currentUserReference)
            .orderBy('last_message_time', descending: true),
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
        List<ChatsRecord> allChatPageChatsRecordList = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: ChatsOptionsWidget(),
                  );
                },
              ).then((value) => setState(() {}));
            },
            backgroundColor: Color(0xFF5ABBDE),
            elevation: 8,
            child: InkWell(
              onTap: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: ChatsOptionsWidget(),
                    );
                  },
                ).then((value) => setState(() {}));
              },
              child: Icon(
                Icons.add,
                color: FlutterFlowTheme.of(context).primaryBtnText,
                size: 24,
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Color(0xFFEEF0F5),
            automaticallyImplyLeading: false,
            actions: [],
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    'Chats',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Nunito',
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
              centerTitle: false,
              expandedTitleScale: 1.0,
              titlePadding: EdgeInsetsDirectional.fromSTEB(10, 0, 20, 10),
            ),
            elevation: 0,
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: TextFormField(
                            controller: textController,
                            onChanged: (_) => EasyDebounce.debounce(
                              'textController',
                              Duration(milliseconds: 2000),
                              () => setState(() {}),
                            ),
                            onFieldSubmitted: (_) async {
                              setState(() => algoliaSearchResults = null);
                              await UsersRecord.search(
                                term: textController!.text,
                              )
                                  .then((r) => algoliaSearchResults = r)
                                  .onError((_, __) => algoliaSearchResults = [])
                                  .whenComplete(() => setState(() {}));
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Color(0xFFC4C8D2),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 20,
                              ),
                              suffixIcon: textController!.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () async {
                                        textController?.clear();
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
                                    )
                                  : null,
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                      if (textController!.text == null ||
                          textController!.text == '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: Builder(
                            builder: (context) {
                              final normalList =
                                  allChatPageChatsRecordList.toList();
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: normalList.length,
                                itemBuilder: (context, normalListIndex) {
                                  final normalListItem =
                                      normalList[normalListIndex];
                                  return StreamBuilder<FFChatInfo>(
                                    stream: FFChatManager.instance.getChatInfo(
                                        chatRecord: normalListItem),
                                    builder: (context, snapshot) {
                                      final chatInfo = snapshot.data ??
                                          FFChatInfo(normalListItem);
                                      return FFChatPreview(
                                        onTap: () => context.pushNamed(
                                          'chatPage',
                                          queryParams: {
                                            'chatUser': serializeParam(
                                              chatInfo.otherUsers.length == 1
                                                  ? chatInfo
                                                      .otherUsersList.first
                                                  : null,
                                              ParamType.Document,
                                            ),
                                            'chatRef': serializeParam(
                                              chatInfo.chatRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'chatUser':
                                                chatInfo.otherUsers.length == 1
                                                    ? chatInfo
                                                        .otherUsersList.first
                                                    : null,
                                          },
                                        ),
                                        lastChatText:
                                            chatInfo.chatPreviewMessage(),
                                        lastChatTime:
                                            normalListItem.lastMessageTime,
                                        seen: normalListItem.lastMessageSeenBy!
                                            .contains(currentUserReference),
                                        title: chatInfo.chatPreviewTitle(),
                                        userProfilePic:
                                            chatInfo.chatPreviewPic(),
                                        color: Color(0xFFEEF0F5),
                                        unreadColor: Colors.blue,
                                        titleTextStyle: GoogleFonts.getFont(
                                          'DM Sans',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        dateTextStyle: GoogleFonts.getFont(
                                          'DM Sans',
                                          color: Color(0x73000000),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                        previewTextStyle: GoogleFonts.getFont(
                                          'DM Sans',
                                          color: Color(0x73000000),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                3, 3, 3, 3),
                                        borderRadius: BorderRadius.circular(0),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      if (textController!.text != null &&
                          textController!.text != '')
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                          child: StreamBuilder<List<ChatsRecord>>(
                            stream: queryChatsRecord(
                              queryBuilder: (chatsRecord) => chatsRecord.where(
                                  'users',
                                  arrayContains: functions.newCustomFunction(
                                      'B9Wv8E6YXRZY2EEqUazd2fr4UuB3')),
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
                              List<ChatsRecord> listViewChatsRecordList =
                                  snapshot.data!;
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewChatsRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewChatsRecord =
                                      listViewChatsRecordList[listViewIndex];
                                  return StreamBuilder<FFChatInfo>(
                                    stream: FFChatManager.instance.getChatInfo(
                                        chatRecord: listViewChatsRecord),
                                    builder: (context, snapshot) {
                                      final chatInfo = snapshot.data ??
                                          FFChatInfo(listViewChatsRecord);
                                      return FFChatPreview(
                                        onTap: () => context.pushNamed(
                                          'chatPage',
                                          queryParams: {
                                            'chatUser': serializeParam(
                                              chatInfo.otherUsers.length == 1
                                                  ? chatInfo
                                                      .otherUsersList.first
                                                  : null,
                                              ParamType.Document,
                                            ),
                                            'chatRef': serializeParam(
                                              chatInfo.chatRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'chatUser':
                                                chatInfo.otherUsers.length == 1
                                                    ? chatInfo
                                                        .otherUsersList.first
                                                    : null,
                                          },
                                        ),
                                        lastChatText:
                                            chatInfo.chatPreviewMessage(),
                                        lastChatTime:
                                            listViewChatsRecord.lastMessageTime,
                                        seen: listViewChatsRecord
                                            .lastMessageSeenBy!
                                            .contains(currentUserReference),
                                        title: chatInfo.chatPreviewTitle(),
                                        userProfilePic:
                                            chatInfo.chatPreviewPic(),
                                        color: Color(0xFFEEF0F5),
                                        unreadColor: Colors.blue,
                                        titleTextStyle: GoogleFonts.getFont(
                                          'DM Sans',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        dateTextStyle: GoogleFonts.getFont(
                                          'DM Sans',
                                          color: Color(0x73000000),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                        previewTextStyle: GoogleFonts.getFont(
                                          'DM Sans',
                                          color: Color(0x73000000),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                3, 3, 3, 3),
                                        borderRadius: BorderRadius.circular(0),
                                      );
                                    },
                                  );
                                },
                              );
                            },
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
  }
}
