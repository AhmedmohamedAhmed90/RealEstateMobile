import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../QrCode/cubit/qr_code_cubit.dart';

class QRCodePage extends StatelessWidget {
  QRCodePage({Key? key}) : super(key: key);

  final TextEditingController visitorNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code'),
      ),
      body: BlocListener<QRCodeCubit, QRCodeState>(
        listener: (context, state) {
          if (state is QRCodeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: visitorNameController,
                decoration: const InputDecoration(
                  labelText: 'Visitor Name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final visitorName = visitorNameController.text;
                  context.read<QRCodeCubit>().generateQRCode(visitorName);
                },
                child: const Text('Generate QR Code'),
              ),
              const SizedBox(height: 20),
              BlocBuilder<QRCodeCubit, QRCodeState>(
                builder: (context, state) {
                  if (state is QRCodeLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is QRCodeGenerated) {
                    return Column(
                      children: [
                        Image.memory(
                          base64Decode(state.qrCode.split(',')[1]),
                        ),
                        const Text('QR Code Generated!'),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
