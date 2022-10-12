import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerfiedWidget extends StatefulWidget {
  const VerfiedWidget({Key? key}) : super(key: key);

  @override
  _VerfiedWidgetState createState() => _VerfiedWidgetState();
}

class _VerfiedWidgetState extends State<VerfiedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Color(0xFFF5F5F5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 150,
              height: 150,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/check-removebg-preview.png',
              ),
            ),
            Text(
              'Verified!',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              'You have succesfully verified \nthe account',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Nunito',
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                },
                text: 'Get started!',
                options: FFButtonOptions(
                  width: 170,
                  height: 40,
                  color: Color(0xFF3B5159),
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        lineHeight: 1,
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
    );
  }
}
