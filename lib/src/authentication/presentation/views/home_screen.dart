import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_tutorial/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:tdd_tutorial/src/authentication/presentation/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is UserCreted) {
          getUsers();
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) =>
                    AddUserDialog(nameController: nameController));
          },
          icon: const Icon(Icons.add),
          label: const Text('Add User'),
        ),
        body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
          if (state is GettingUsers) {
            return const LoadingColumn(message: 'Fetching Users');
          } else if (state is CreatingUser) {
            return const LoadingColumn(message: 'Creating User');
          } else if (state is UsersLoaded) {
            return Center(
              child: Center(
                child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return ListTile(
                        leading: Image.network(user.avatar),
                        title: Text(user.name),
                        subtitle: Text(user.createdAt.substring(10)),
                      );
                    }),
              ),
            );
          }
          return SizedBox.shrink();
        }),
      ),
    );
  }
}
