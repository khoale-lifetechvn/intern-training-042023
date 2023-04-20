import 'package:flutter/material.dart';
import 'package:task_firebase/ui/base_widget/form_data.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/base_widget/lf_text_field.dart';
import 'package:task_firebase/ui/base_widget/title_logo_item.dart';
import 'package:task_firebase/ui/presentation/register_view/controller/register_controller.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController controller = RegisterController();

  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(title: 'Sign Up'),
      backgroundColor: ColorManager.greyBG,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: AppPadding.p30,
          left: AppPadding.p16,
          right: AppPadding.p16,
        ),
        child: Column(
          children: [
            const TitleLogoItem(),
            const SizedBox(height: 16),
            //Form
            signIn()
          ],
        ),
      ),
    );
  }

  Widget signIn() {
    return FormData(
        title: 'Sign Up',
        onSubmit: () {
          controller.signUp();
        },
        list: listTFF);
  }

  List<Widget> get listTFF => [
        LFTextFormField(
          label: 'Email',
          onSaved: (p0) => controller.email = p0,
        ),
        LFTextFormField(
          label: 'Password',
          obscureText: true,
          onChanged: (p0) => _password = p0,
        ),
        LFTextFormField(
          label: 'Confirm Password',
          obscureText: true,
          validator: (v) => _password != v ? 'Confirm password invalid' : null,
          onSaved: (p0) => controller.password = p0,
        ),
        LFTextFormField(
          label: 'UserName',
          onSaved: (p0) => controller.name = p0,
        ),
        LFTextFormField(
          label: 'Dbo',
          onSaved: (p0) => controller.dbo = p0,
        )
      ];
}
