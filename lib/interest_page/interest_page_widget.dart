import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class InterestPageWidget extends StatefulWidget {
  const InterestPageWidget({
    Key? key,
    this.ijob,
  }) : super(key: key);

  final String? ijob;

  @override
  _InterestPageWidgetState createState() => _InterestPageWidgetState();
}

class _InterestPageWidgetState extends State<InterestPageWidget> {
  List<String>? choiceChipsValues;
  List<String>? otherChoiceValues;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((currentUserDocument?.interests?.toList() ?? []).length != 0) {
        context.goNamed('mainPage');

        return;
      } else {
        return;
      }
    });

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'interestPage'});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<UtilsRecord>>(
      future: queryUtilsRecordOnce(
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
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ),
          );
        }
        List<UtilsRecord> interestPageUtilsRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final interestPageUtilsRecord = interestPageUtilsRecordList.isNotEmpty
            ? interestPageUtilsRecordList.first
            : null;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tag Interest',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Nunito',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              lineHeight: 2,
                            ),
                      ),
                      Wrap(
                        spacing: 0,
                        runSpacing: 0,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Dapatkan rekomendasi konten hasil personalisasi Anda. Anda dapat memilih hingga 4 opsi',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Nunito',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          Visibility(
                            visible: widget.ijob != 'Other',
                            child: StreamBuilder<List<InterestsRecord>>(
                              stream: queryInterestsRecord(
                                queryBuilder: (interestsRecord) =>
                                    interestsRecord.where('jobs',
                                        arrayContains: functions.getIndex(
                                            interestPageUtilsRecord!.joblist!
                                                .toList(),
                                            widget.ijob!)),
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
                                    choiceChipsInterestsRecordList =
                                    snapshot.data!;
                                return FlutterFlowChoiceChips(
                                  options: choiceChipsInterestsRecordList
                                      .map((e) => e.name!)
                                      .toList()
                                      .map((label) => ChipData(label))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => choiceChipsValues = val),
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).btnColors,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle1
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                    iconColor: Colors.black,
                                    iconSize: 18,
                                    elevation: 4,
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Nunito',
                                          fontSize: 18,
                                        ),
                                    iconColor: Color(0xFF323B45),
                                    iconSize: 18,
                                    elevation: 0,
                                  ),
                                  chipSpacing: 20,
                                  multiselect: true,
                                  initialized: choiceChipsValues != null,
                                  alignment: WrapAlignment.start,
                                );
                              },
                            ),
                          ),
                          Visibility(
                            visible: widget.ijob == 'Other',
                            child: StreamBuilder<List<InterestsRecord>>(
                              stream: queryInterestsRecord(),
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
                                    otherChoiceInterestsRecordList =
                                    snapshot.data!;
                                return FlutterFlowChoiceChips(
                                  options: otherChoiceInterestsRecordList
                                      .map((e) => e.name!)
                                      .toList()
                                      .map((label) => ChipData(label))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => otherChoiceValues = val),
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).btnColors,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle1
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                    iconColor: Colors.black,
                                    iconSize: 18,
                                    elevation: 4,
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor: Colors.white,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Nunito',
                                          fontSize: 18,
                                        ),
                                    iconColor: Color(0xFF323B45),
                                    iconSize: 18,
                                    elevation: 0,
                                  ),
                                  chipSpacing: 20,
                                  multiselect: true,
                                  initialized: otherChoiceValues != null,
                                  alignment: WrapAlignment.start,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            var _shouldSetState = false;
                            if (choiceChipsValues!.length > 4) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    content: Text(
                                        'Kamu hanya bisa memilih 4 tag interest'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (_shouldSetState) setState(() {});
                              return;
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    content: Text(
                                        otherChoiceValues!.length.toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              final usersUpdateData = {
                                'interests': widget.ijob != 'Other'
                                    ? functions.normInterests(
                                        choiceChipsValues!.toList())
                                    : functions.normInterests(
                                        otherChoiceValues!.toList()),
                              };
                              await currentUserReference!
                                  .update(usersUpdateData);
                              _shouldSetState = true;

                              context.goNamed('mainPage');
                            }

                            if (_shouldSetState) setState(() {});
                          },
                          text: 'Next',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 40,
                            color: Color(0xFF3B5159),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
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
            ),
          ),
        );
      },
    );
  }
}
