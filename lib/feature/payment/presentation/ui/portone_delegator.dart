
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/config/router/app_router.dart';

class PortoneDelegator extends StatelessWidget {
  const PortoneDelegator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portone Delegator'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()  {

            // portone V1 payments
            // final result = await Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Payment()),
            // );
            //
            // print('[portone delegator] : ');
            // result.forEach((key, value) {
            //   print('$key: $value');
            // });

            context.push(AppRoutes.tossPayment);

          },
          child: const Text('Go to Payment'),
        ),
      ),
    );
  }
}
