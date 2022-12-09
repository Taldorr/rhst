import 'package:flutter/material.dart';
import 'package:rhst/util/storage_service.dart';

class ResolvedImage extends StatelessWidget {
  final String path;
  const ResolvedImage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fileFuture = StorageService.resolveFile(path);
    return FutureBuilder<FirebaseFile>(
      future: fileFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            final file = snapshot.data!;
            return Image.network(
              file.url,
              fit: BoxFit.cover,
            );
        }
      },
    );
  }
}
