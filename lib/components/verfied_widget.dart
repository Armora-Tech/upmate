// ignore_for_file: library_private_types_in_public_api

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerfiedWidget extends StatefulWidget {
  const VerfiedWidget({Key? key}) : super(key: key);

  @override
  _VerfiedWidgetState createState() => _VerfiedWidgetState();
}

class _VerfiedWidgetState extends State<VerfiedWidget> {
  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
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
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                context.pushNamed('surveyPage');

                FFAppState().update(() {
                  FFAppState().isFirstOpen = true;
                });
              },
              text: 'Get started!',
              options: FFButtonOptions(
                width: 170,
                height: 40,
                color: const Color(0xFF3B5159),
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      lineHeight: 1,
                    ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
