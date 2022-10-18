import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingPageWidget extends StatefulWidget {
  const RatingPageWidget({Key? key}) : super(key: key);

  @override
  _RatingPageWidgetState createState() => _RatingPageWidgetState();
}

class _RatingPageWidgetState extends State<RatingPageWidget> {
  TextEditingController? textController;
  double? ratingBarValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ratingPage'});
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        automaticallyImplyLeading: true,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 24,
        ),
        title: Text(
          'Rate Us !',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Nunito',
                color: FlutterFlowTheme.of(context).textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      onRatingUpdate: (newValue) =>
                          setState(() => ratingBarValue = newValue),
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF3E500),
                      ),
                      direction: Axis.horizontal,
                      initialRating: ratingBarValue ??= 4,
                      unratedColor: Color(0xFF9E9E9E),
                      itemCount: 5,
                      itemSize: 40,
                      glowColor: Color(0xFFF3E500),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: TextFormField(
                            controller: textController,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Tell us your opinion...',
                              hintStyle: FlutterFlowTheme.of(context).bodyText2,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).textColor,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).textColor,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            maxLines: 5,
                          ),
                        ),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        final ratingsCreateData = createRatingsRecordData(
                          star: ratingBarValue?.round(),
                          comment: textController!.text,
                          user: currentUserReference,
                        );
                        await RatingsRecord.collection
                            .doc()
                            .set(ratingsCreateData);
                        Navigator.pop(context);
                      },
                      text: 'Send',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: FlutterFlowTheme.of(context).btnColors,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
