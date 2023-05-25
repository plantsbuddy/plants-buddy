import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_buddy/config/routes/app_routes.dart' as app_routes;
import 'package:plants_buddy/core/utils/custom_icons.dart' as custom_icons;
import 'package:plants_buddy/features/authentication/domain/entities/user.dart';
import 'package:plants_buddy/features/authentication/logic/authentication_bloc.dart';
import 'package:plants_buddy/features/authentication/presentation/update_profile_sheet.dart';
import 'package:plants_buddy/features/payment/logic/payment_bloc.dart';
import 'package:plants_buddy/features/suggestions/logic/suggestions_bloc.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.5),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(
                    context.select((AuthenticationBloc bloc) => bloc.state.currentUser)?.profilePicture ?? '',
                    fit: BoxFit.cover,
                    width: 45,
                    height: 45,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.select((AuthenticationBloc bloc) => bloc.state.currentUser!.username),
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        context.select((AuthenticationBloc bloc) => bloc.state.currentUser!.email),
                        style: TextStyle(color: Colors.black26),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state.dialogShowing) {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                            child: Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Updating profile'),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      Future.delayed(const Duration(milliseconds: 300), () => Navigator.of(context).pop());

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Profile updated'),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(milliseconds: 1500),
                        ),
                      );
                    }
                  },
                  listenWhen: (previous, current) => previous.dialogShowing != current.dialogShowing,
                  child: IconButton(
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<AuthenticationBloc>(),
                        child: UpdateProfileSheet(),
                      ),
                    ),
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20),
                foregroundColor: Theme.of(context).colorScheme.error,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
              ).copyWith(
                elevation: ButtonStyleButton.allOrNull(0.0),
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Confirm Logout'),
                    content: Text('Are you sure you want to logout from app?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.read<AuthenticationBloc>().add(AuthenticationLogoutPressed());
                          Navigator.of(context).pushNamed(app_routes.authentication);
                        },
                        child: Text('Logout'),
                        style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                      ),
                    ],
                  );
                },
              ),
              icon: Icon(Icons.logout),
              label: Text('Logout'),
            ),
          ),
          SizedBox(height: 15),
          Flexible(
            child: GridView.count(
              children: [
                if (context.read<AuthenticationBloc>().state.currentUser!.userType == UserType.gardener)
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(app_routes.consultBotanists, arguments: {
                      'authentication_bloc': context.read<AuthenticationBloc>(),
                      'payment_bloc': context.read<PaymentBloc>(),
                    }),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              custom_icons.botanist,
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Divider(
                                height: 1,
                                thickness: 0.1,
                              ),
                            ),
                            Text(
                              'Botanist\nConsultation',
                              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (context.read<AuthenticationBloc>().state.currentUser!.userType == UserType.botanist)
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(app_routes.attendGardeners, arguments: {
                      'authentication_bloc': context.read<AuthenticationBloc>(),
                      'payment_bloc': context.read<PaymentBloc>(),
                    }),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              custom_icons.gardener,
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Divider(
                                height: 1,
                                thickness: 0.1,
                              ),
                            ),
                            Text(
                              'Attend\nGardeners',
                              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(app_routes.suggestions, arguments: context.read<SuggestionsBloc>()),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            custom_icons.plantCare,
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Divider(
                              height: 1,
                              thickness: 0.1,
                            ),
                          ),
                          Text(
                            'Plant\nCare',
                            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(app_routes.chatbot),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            custom_icons.chatbot,
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Divider(
                              height: 1,
                              thickness: 0.1,
                            ),
                          ),
                          Text(
                            'Chatbot',
                            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 20,
              mainAxisSpacing: 25,
              crossAxisCount: 2,
            ),
          ),
        ],
      ),
    );
  }
}
