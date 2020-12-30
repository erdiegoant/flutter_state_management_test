import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:state_management_test/ui/stacked_views/login/login_viewmodel.dart';

class StackedLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stacked Login'),
      ),
      body: Center(
        child: _LoginBody(),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.futureToRun(),
      builder: (_, model, child) {
        return model.isBusy
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    _EmailInput(),
                    SizedBox(height: 20),
                    _PasswordInput(),
                    SizedBox(height: 20),
                    _SubmitForm(),
                  ],
                ),
              );
      },
    );
  }
}

class _EmailInput extends HookViewModelWidget<LoginViewModel> {
  _EmailInput({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(_, LoginViewModel model) {
    var text = useTextEditingController(text: model.email);

    return Column(
      children: [
        Text('Email'),
        TextField(
          controller: text,
          onChanged: model.setEmail,
          textAlignVertical: TextAlignVertical.center,
        ),
      ],
    );
  }
}

class _PasswordInput extends HookViewModelWidget<LoginViewModel> {
  _PasswordInput({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(_, LoginViewModel model) {
    var text = useTextEditingController(text: model.password);

    return Column(
      children: [
        Text('Password'),
        TextField(
          controller: text,
          onChanged: model.setPassword,
          textAlignVertical: TextAlignVertical.center,
          obscureText: true,
        ),
      ],
    );
  }
}

class _SubmitForm extends ViewModelWidget<LoginViewModel> {
  @override
  Widget build(_, LoginViewModel model) {
    return RaisedButton(
      onPressed: model.loginUser,
      child: Text('Login'),
    );
  }
}
