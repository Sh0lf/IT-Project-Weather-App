
import 'package:http/http.dart' as http;



Future<void> _loadData() async {
  // fonction pour récuperer les différentes infos
  http.Response response = await http
      .get(Uri.parse(
      "http://api.weatherapi.com/v1/current.json?key=fea69b4e481a47d5972153151212709&q=Paris"))
      .timeout(
    const Duration(seconds: 2),
    onTimeout: () {
      // au bout de 2secondes d'attente, on dit stop
      return http.Response('Error', 503); // on renvoie un code d'erreur 500
    },
  );

  if (response.statusCode == 200) {
    // si le code de retour est 200
    var results = jsonDecode(response.body);
    setState(() {
      // on modifie les variables avec les valeurs de l'API
      this.temp = results['current']['temp_c'];
      this.description = results['current']['condition']['text'];
      this.humidity = results['current']['humidity'];
      this.windSpeed = results['current']['wind_kph'];
      this.updateTime = results['current']['last_updated'];
      this.region = results['location']["region"];
    });
  } else {
    // sinon on affiche un message
    Fluttertoast.showToast(
        msg: "Error : the server is not responding",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}