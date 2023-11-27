// import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mush_room/feature/domain/parameters/login_params.dart';
import 'package:mush_room/feature/gui/components/widgets/app_router.dart';
import 'package:mush_room/feature/gui/presenters/bloc/login_page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_module.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode usernameFocus = FocusNode(); // Create a FocusNode
  FocusNode passwordFocus = FocusNode();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hidePasswordText = true;

  final _loginBloc = getIt<LoginPageBloc>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginPageBloc, LoginPageState>(
      bloc: _loginBloc,
      listener: (context, state) {
        // TODO: implement listener
        print(state);
        if (state is LoginSuccessState) {
          AutoRouter.of(context).navigate(HomeRoute());
        }
        if (state is LoginErrorState) {
          print(state.message);
        }
        if (state is LoginNoCredentialState) {
          print("init ${state}");
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 50, left: 50, right: 50),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "WELCOME TO MUSH ROOM",
                  style: TextStyle(fontSize: 20),
                ),
                Column(
                  children: [
                    TextFormField(
                      focusNode: usernameFocus,
                      controller: username,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_sharp,
                          color: usernameFocus.hasFocus
                              ? Colors.blueAccent
                              : Colors.black54,
                        ),
                        labelText: 'Username',
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF000000),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      focusNode: passwordFocus,
                      controller: password,
                      obscureText: hidePasswordText,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: passwordFocus.hasFocus
                              ? Colors.blueAccent
                              : Colors.black54,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePasswordText = !hidePasswordText;
                            });
                          },
                          icon: Icon(
                            hidePasswordText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 24,
                            color: passwordFocus.hasFocus
                                ? Colors.blueAccent
                                : Colors.black54,
                          ),
                        ),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF000000),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text("Forget Password?")),
                        IconButton(
                            onPressed: () {
                              LoginParams params = LoginParams(
                                  username: username.text,
                                  password: password.text);

                              _loginBloc.add(GetLoginParamsEvent(params));
                            },
                            icon:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      ],
                    )
                  ],
                ),
              ],
            )),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Do you have an acount?"),
              TextButton(
                  onPressed: () {
                    AutoRouter.of(context).navigate(HomeRoute());
                  },
                  child: const Text("create..."))
            ],
          ),
        );
      },
    );
  }
}
