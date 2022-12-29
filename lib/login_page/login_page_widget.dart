import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_timer.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  int timerMilliseconds = 60000;
  String timerValue = StopWatchTimer.getDisplayTime(
    60000,
    hours: false,
    milliSecond: false,
  );
  StopWatchTimer timerController =
      StopWatchTimer(mode: StopWatchMode.countDown);

  TextEditingController? inpEmailController;
  TextEditingController? inpPassController;
  late bool inpPassVisibility;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    inpEmailController = TextEditingController();
    inpPassController = TextEditingController();
    inpPassVisibility = false;
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'LoginPage'});
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    inpEmailController?.dispose();
    inpPassController?.dispose();
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    //return WillPopScope here
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: SingleChildScrollView(
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
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Nunito',
                                    fontSize: 25,
                                  ),
                            ),
                          ),
                        ),
                      Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFBEFEF),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFBEFEF),
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
                                    suffixIcon:
                                        inpEmailController!.text.isNotEmpty
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
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Field is required';
                                    }

                                    if (!RegExp(kTextValidatorEmailRegex)
                                        .hasMatch(val)) {
                                      return 'Has to be a valid email address.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                              child: Container(
                                width: 300,
                                child: TextFormField(
                                  controller: inpPassController,
                                  obscureText: !inpPassVisibility,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle:
                                        FlutterFlowTheme.of(context).bodyText2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFBEFEF),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFBEFEF),
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
                                        () => inpPassVisibility =
                                            !inpPassVisibility,
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
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Field is required';
                                    }

                                    if (val.length < 8) {
                                      return 'Requires at least 8 characters.';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (formKey.currentState == null ||
                                !formKey.currentState!.validate()) {
                              return;
                            }

                            GoRouter.of(context).prepareAuthEvent();

                            final user = await signInWithEmail(
                              context,
                              inpEmailController!.text,
                              inpPassController!.text,
                            );
                            if (user == null) {
                              return;
                            }

                            context.goNamedAuth('mainPage', mounted);
                          },
                          text: 'Sign In',
                          options: FFButtonOptions(
                            width: 273,
                            height: 43,
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(150, 0, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (FFAppState().sreset == false)
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: InkWell(
                                  onTap: () async {
                                    if (inpEmailController!.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                    FFAppState().update(() {
                                      FFAppState().sreset = true;
                                      FFAppState().nreset =
                                          FFAppState().nreset + 1;
                                    });
                                    timerController.onExecute
                                        .add(StopWatchExecute.start);
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
                                initialTime: timerMilliseconds,
                                getDisplayTime: (value) =>
                                    StopWatchTimer.getDisplayTime(
                                  value,
                                  hours: false,
                                  milliSecond: false,
                                ),
                                timer: timerController,
                                onChanged: (value, displayTime, shouldUpdate) {
                                  timerMilliseconds = value;
                                  timerValue = displayTime;
                                  if (shouldUpdate) setState(() {});
                                },
                                onEnded: () async {
                                  FFAppState().update(() {
                                    FFAppState().sreset = false;
                                  });
                                },
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: Color(0xFF505050),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    50, 0, 50, 0),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 50),
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
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
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
                          if (isAndroid && !FFAppState().unused)
                            InkWell(
                              onTap: () async {
                                try {
                                  FFAppState().update(() {
                                    FFAppState().unused = true;
                                  });
                                  GoRouter.of(context).prepareAuthEvent();
                                  final user = await signInWithGoogle(context);
                                  debugPrint("USERSTATUS: " + user.toString());
                                  if (user == null) {
                                    FFAppState().update(() {
                                      FFAppState().unused = false;
                                    });
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          content: Text(
                                              'Login gagal, silahkan mencoba beberapa saat lagi.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return;
                                  }
                                  FFAppState().update(() {
                                    FFAppState().unused = false;
                                  });

                                  context.goNamedAuth('mainPage', mounted);
                                } catch (err) {
                                  FFAppState().update(() {
                                    FFAppState().unused = false;
                                  });
                                }
                              },
                              child: Image.asset(
                                'assets/images/th-1920417626-removebg-preview.png',
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                          if (FFAppState().unused)
                            InkWell(
                              child: Image.asset(
                                'assets/images/98288-loading.gif',
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                          if (isiOS)
                            InkWell(
                              onTap: () async {
                                FFAppState().update(() {
                                  FFAppState().unused = true;
                                });
                                GoRouter.of(context).prepareAuthEvent();
                                final user = await signInWithApple(context);
                                if (user == null) {
                                  return;
                                }
                                FFAppState().update(() {
                                  FFAppState().unused = false;
                                });

                                context.goNamedAuth('mainPage', mounted);
                              },
                              child: Image.asset(
                                'assets/images/Apple-Logo.webp',
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                          InkWell(
                            onTap: () async {
                              FFAppState().update(() {
                                FFAppState().unused = true;
                              });
                              GoRouter.of(context).prepareAuthEvent();
                              final user = await signInWithFacebook(context);
                              if (user == null) {
                                return;
                              }
                              FFAppState().update(() {
                                FFAppState().unused = false;
                              });

                              context.goNamedAuth('mainPage', mounted);
                            },
                            child: Image.asset(
                              'assets/images/fb_icon-removebg-preview.png',
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            InkWell(
                              onTap: () async {
                                context.pushNamed(
                                  'SignupPage',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.bottomToTop,
                                    ),
                                  },
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
            ],
          ),
        ),
      ),
    );
  }
}
