import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestPageWidget extends StatefulWidget {
  const InterestPageWidget({Key? key}) : super(key: key);

  @override
  _InterestPageWidgetState createState() => _InterestPageWidgetState();
}

class _InterestPageWidgetState extends State<InterestPageWidget> {
  List<String>? choiceChipsValues;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'interestPage'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'Dapatkan rekomendasi konten hasil personalisasi Anda. Anda dapat memilih hingga 4 opsi',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    StreamBuilder<List<InterestsRecord>>(
                      stream: queryInterestsRecord(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                            ),
                          );
                        }
                        List<InterestsRecord> choiceChipsInterestsRecordList =
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
                            backgroundColor: Colors.white,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                            iconColor: Colors.black,
                            iconSize: 18,
                            elevation: 4,
                          ),
                          unselectedChipStyle: ChipStyle(
                            backgroundColor: Colors.white,
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF323B45),
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
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
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
                        return;
                      } else {
                        final usersUpdateData = {
                          'interests': functions
                              .normInterests(choiceChipsValues!.toList()),
                        };
                        await currentUserReference!.update(usersUpdateData);
                        await AddUserCall.call(
                          uid: currentUserUid,
                          interests: functions.joinLString(
                              functions
                                  .normInterests(choiceChipsValues!.toList())
                                  .toList(),
                              ';'),
                        );
                        await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NavBarPage(initialPage: 'mainPage'),
                          ),
                          (r) => false,
                        );
                        return;
                      }
                    },
                    text: 'Next',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40,
                      color: Color(0xFF3B5159),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
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
    );
  }
}
