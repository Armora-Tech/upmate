import 'package:open_mail_app/open_mail_app.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ConfirmResetPassWidget extends StatefulWidget {
  const ConfirmResetPassWidget({Key? key}) : super(key: key);

  @override
  _ConfirmResetPassWidgetState createState() => _ConfirmResetPassWidgetState();
}

class _ConfirmResetPassWidgetState extends State<ConfirmResetPassWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'confirmResetPass'});
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderWidth: 1,
                    buttonSize: 100,
                    icon: FaIcon(
                      FontAwesomeIcons.solidEnvelopeOpen,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      size: 80,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                  Text(
                    'Cek email anda',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Nunito',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Wrap(
                      spacing: 0,
                      runSpacing: 0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: [
                        AutoSizeText(
                          'Kami telah mengirimkan instruksi untuk \nreset password ke email kamu.',
                          maxLines: 2,
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: FFButtonWidget(
                      onPressed: () async {
                        // Android: Will open mail app or show native picker.
                        // iOS: Will open mail app if single mail app found.
                        var result = await OpenMailApp.openMailApp();

                        // If no mail apps found, show error
                        if (!result.didOpen && !result.canOpen) {
                          showNoMailAppsDialog(context);

                          // iOS: if multiple mail apps found, show dialog to select.
                          // There is no native intent/default app system in iOS so
                          // you have to do it yourself.
                        } else if (!result.didOpen && result.canOpen) {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return MailAppPickerDialog(
                                mailApps: result.options,
                              );
                            },
                          );
                        }
                      },
                      text: 'Buka email',
                      options: FFButtonOptions(
                        width: 130,
                        height: 40,
                        color: FlutterFlowTheme.of(context).primaryColor,
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: InkWell(
                        onTap: () async {
                          context.pushNamed('LoginPage');
                        },
                        child: Text(
                          'Lewati, saya akan konfirmasi nanti',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        )),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Tidak menerima email? \nCek folder spam anda atau',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                      InkWell(
                        onTap: () async {
                          context.pushNamed('resetPassword');
                        },
                        child: Text('\n coba alamat email lain.',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Nunito',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                )),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showNoMailAppsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Open Mail App"),
        content: Text("No mail apps installed"),
        actions: <Widget>[
          FFButtonWidget(
            text: "OK",
            onPressed: () {
              Navigator.pop(context);
            },
            options: FFButtonOptions(
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                )),
          )
        ],
      );
    },
  );
}
