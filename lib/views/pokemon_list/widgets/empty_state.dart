part of '../pokemon_list_view.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/image_empty_data.png',
            width: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          const Text(
            'No data available',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
