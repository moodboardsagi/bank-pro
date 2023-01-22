import 'package:bank_pro/blocs/auth/auth_bloc.dart';
import 'package:bank_pro/shared/shared_methods.dart';
import 'package:bank_pro/shared/theme.dart';
import 'package:bank_pro/ui/widgets/buttons.dart';
import 'package:bank_pro/ui/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPinPage extends StatefulWidget {
  const ProfileEditPinPage({super.key});

  @override
  State<ProfileEditPinPage> createState() => _ProfileEditPinPageState();
}

class _ProfileEditPinPageState extends State<ProfileEditPinPage> {
  final oldController = TextEditingController(text: '');
  final newController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit PIN',
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/profile-edit-success', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      title: 'Old PIN',
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      controller: oldController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // NOTE: PASSWORD INPUT
                    CustomFormField(
                      title: 'New PIN',
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      controller: newController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                      title: 'Update Now',
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthUpdatePin(
                                oldController.text,
                                newController.text,
                              ),
                            );
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
