import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_timer.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main_page/main_page_widget.dart';
import '../signup_page/signup_page_widget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  StopWatchTimer? timerController;
  String? timerValue;
  int? timerMilliseconds;
  TextEditingController? inpEmailController;
  TextEditingController? inpPassController;

  late bool inpPassVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    inpEmailController = TextEditingController();
    inpPassController = TextEditingController();
    inpPassVisibility = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    inpEmailController?.dispose();
    inpPassController?.dispose();
    timerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/rafiki.svg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                if ('' == '2')
                  Align(
                    alignment: AlignmentDirectional(-0.1, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: AutoSizeText(
                        'Welcome back!',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Nunito',
                              fontSize: 25,
                            ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      controller: inpEmailController,
                      onChanged: (_) => EasyDebounce.debounce(
                        'inpEmailController',
                        Duration(milliseconds: 2000),
                        () => setState(() {}),
                      ),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: FlutterFlowTheme.of(context).bodyText2,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xB3FBEFEF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xB3FBEFEF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: inpEmailController!.text.isNotEmpty
                            ? InkWell(
                                onTap: () async {
                                  inpEmailController?.clear();
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      controller: inpPassController,
                      obscureText: !inpPassVisibility,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: FlutterFlowTheme.of(context).bodyText2,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xB3FBEFEF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xB3FBEFEF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => inpPassVisibility = !inpPassVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            inpPassVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      final user = await signInWithEmail(
                        context,
                        inpEmailController!.text,
                        inpPassController!.text,
                      );
                      if (user == null) {
                        return;
                      }

                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPageWidget(),
                        ),
                        (r) => false,
                      );
                    },
                    text: 'Sign In',
                    options: FFButtonOptions(
                      width: 273,
                      height: 43,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(150, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (FFAppState().sreset == false)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              if (inpEmailController!.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Email required!',
                                    ),
                                  ),
                                );
                                return;
                              }
                              await resetPassword(
                                email: inpEmailController!.text,
                                context: context,
                              );
                              setState(() => FFAppState().sreset = true);
                              setState(() => FFAppState().nreset =
                                  FFAppState().nreset + 1);
                              timerController?.onExecute.add(
                                StopWatchExecute.start,
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: Color(0xFF505050),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      if (FFAppState().sreset == true)
                        FlutterFlowTimer(
                          timerValue: timerValue ??=
                              StopWatchTimer.getDisplayTime(
                            timerMilliseconds ??= 60000,
                            hours: false,
                            minute: true,
                            second: true,
                            milliSecond: false,
                          ),
                          timer: timerController ??= StopWatchTimer(
                            mode: StopWatchMode.countDown,
                            presetMillisecond: timerMilliseconds ??= 60000,
                            onChange: (value) {
                              setState(() {
                                timerMilliseconds = value;
                                timerValue = StopWatchTimer.getDisplayTime(
                                  value,
                                  hours: false,
                                  minute: true,
                                  second: true,
                                  milliSecond: false,
                                );
                              });
                            },
                          ),
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Nunito',
                                    color: Color(0xFF505050),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                          onEnded: () async {
                            setState(() => FFAppState().sreset = false);
                          },
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: AlignmentDirectional(0, -0.7),
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Divider(
                                  height: 3,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, -0.9),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 100,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'Sign In with',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        final user = await signInWithGoogle(context);
                        if (user == null) {
                          return;
                        }
                        await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPageWidget(),
                          ),
                          (r) => false,
                        );
                      },
                      child: Image.asset(
                        'assets/images/th-1920417626-removebg-preview.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Image.asset(
                      'assets/images/fb_icon-removebg-preview.png',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 300),
                              reverseDuration: Duration(milliseconds: 300),
                              child: SignupPageWidget(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                    ],
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
