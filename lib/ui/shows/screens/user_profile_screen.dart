import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/common/utility/state/consumer_listener.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/source_remote/auth/auth_repository.dart';
import 'package:tv_shows/ui/login_register/components/general_dialog.dart';
import 'package:tv_shows/ui/login_register/screens/login_screen.dart';
import 'package:tv_shows/ui/shows/provider/user_profile_screen_provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfileScreenProvider>(
      create: (context) => UserProfileScreenProvider(context.read<AuthRepository>()),
      builder: (context, child) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: ConsumerListener<UserProfileScreenProvider>(
              listener: (context, provider) {
                if (provider.user == null) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                  return;
                }

                provider.state.maybeWhen(
                  orElse: () {},
                  failure: (exception) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return GeneralDialog(
                          title: 'Error',
                          message: '$exception',
                        );
                      },
                    );
                  },
                  success: (_) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const GeneralDialog(title: 'Success', message: 'Profile info updated successfully');
                      },
                    );
                  },
                );
              },
              builder: (context, provider) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Center(
                        child: SizedBox(
                          height: 150.0,
                          width: 150.0,
                          child: _ProfilePicture(provider: provider),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: _TextField(
                        provider.user?.email,
                        onChanged: (value) => provider.updatedEmail = value,
                      ),
                    ),
                    const SizedBox(height: 41.0),
                    OutlinedButton.icon(
                      onPressed: () async {
                        if (Form.of(context)?.validate() ?? false) {
                          await provider.onUpdatePressed();
                        }
                      },
                      icon: provider.state.maybeWhen(
                        orElse: () => Container(),
                        loading: () => const CircularProgressIndicator(),
                      ),
                      label: const Text('Update'),
                    ),
                    const SizedBox(height: 17.0),
                    ElevatedButton(
                      onPressed: () async {
                        await provider.onLogoutPressed();
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _ProfilePicture extends StatefulWidget {
  const _ProfilePicture({Key? key, required this.provider}) : super(key: key);

  final UserProfileScreenProvider provider;

  @override
  State<_ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<_ProfilePicture> with TickerProviderStateMixin {
  late Widget _currentAvatar;

  final BoxFit _fit = BoxFit.cover;

  @override
  void initState() {
    super.initState();
    _currentAvatar = Image.network(
      widget.provider.user!.imageUrl!,
      fit: _fit,
      errorBuilder: (context, object, stacktrace) {
        return Image.asset(
          Assets.images.icProfilePlaceholderLarge.path,
          fit: _fit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConsumerListener<UserProfileScreenProvider>(
      listener: (context, provider) {
        if (provider.user?.imageUrl != null) {
          _currentAvatar = Image.network(provider.user!.imageUrl!);
        }
      },
      builder: (context, provider) {
        return GestureDetector(
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
            if (image == null) {
              return;
            }
            provider.temporaryImageFile = File(image.path);
            setState(() {
              _currentAvatar = Image.file(
                File(image.path),
                fit: _fit,
                key: ValueKey(image.name),
              );
            });
          },
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(40),
                child: AnimatedSwitcher(
                  child: _currentAvatar,
                  duration: const Duration(milliseconds: 800),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField(this._initialValue, {Key? key, required this.onChanged}) : super(key: key);

  final ValueChanged<String> onChanged;
  final String? _initialValue;

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address';
    } else {
      if (!EmailValidator.validate(value)) {
        return 'Enter a valid email address';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: _initialValue,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => _validateEmail(value ?? ''),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        hintText: 'email@example.com',
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
