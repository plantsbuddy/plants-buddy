import 'package:plants_buddy/core/utils/strings.dart';
import '../../logic/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageSignupBotanist extends StatefulWidget {
  const PageSignupBotanist({Key? key}) : super(key: key);

  @override
  State<PageSignupBotanist> createState() => _PageSignupBotanistState();
}

class _PageSignupBotanistState extends State<PageSignupBotanist> {
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController passwordController;
  late final TextEditingController consultationChargesController;
  late final TextEditingController specializationController;
  late final TextEditingController descriptionController;
  late final TextEditingController cityController;
  late final TextEditingController qualificationController;
  late final TextEditingController phoneNumberController;

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    consultationChargesController = TextEditingController();
    specializationController = TextEditingController();
    descriptionController = TextEditingController();
    qualificationController = TextEditingController();
    phoneNumberController = TextEditingController();
    cityController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              TextField(
                autofocus: false,
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: state.signupNameError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: state.signupEmailError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'A verification link will be sent to this email',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: specializationController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Specialization',
                  errorText: state.signupSpecialtyError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: descriptionController,
                textCapitalization: TextCapitalization.words,
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                  labelText: 'Description',
                  errorText: state.signupDescriptionError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Write a short professional description of yourself',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: qualificationController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Qualification',
                  errorText: state.signupQualificationError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: cityController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'City',
                  errorText: state.signupQualificationError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: consultationChargesController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Consultation charges',
                  errorText: state.signupConsultationChargesError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: phoneNumberController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  errorText: state.signupPhoneNumberError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                autofocus: false,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: state.signupPasswordError,
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.passwordVisible ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationPasswordVisibilityToggled()),
                  ),
                ),
                obscureText: state.passwordVisible,
              ),
              SizedBox(height: 5),
              Text(
                'Must be at least 8 characters long, contain at least one letter, alphabet, and special character',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 25),
              ElevatedButton(
                child: Text('SIGN UP'),
                onPressed: () => context.read<AuthenticationBloc>().add(
                      AuthenticationSignupBotanistPressed(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        description: descriptionController.text,
                        phoneNumber: phoneNumberController.text,
                        qualification: qualificationController.text,
                        specialty: specializationController.text,
                        city: cityController.text,
                        consultationCharges: consultationChargesController.text,
                      ),
                    ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    specializationController.dispose();
    qualificationController.dispose();
    descriptionController.dispose();
    consultationChargesController.dispose();
    phoneNumberController.dispose();
    cityController.dispose();
    super.dispose();
  }
}
