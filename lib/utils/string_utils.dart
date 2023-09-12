class StringUtil {
  static const baseUrl = "https://pokeapi.co/api/v2";

  static List<String> getParsedUrl(String url) {
    final urlWithoutBase = url.replaceFirst(baseUrl, '');
    final parts = urlWithoutBase.split('/');
    return [parts[1], parts[2]];
  }

  static String capitalizeWords(String string) {
    List<String> words = string.split('-');
    words = words.map((word) => word.capitalize()).toList();
    return words.join(' ');
  }

  static String getImageUrl(int pokemonId) {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png";
  }

  static bool isValidEmail(String value) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value);
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
