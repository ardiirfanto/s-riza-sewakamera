import 'package:s_riza_sewakamera/services/auth_services.dart';

void main() {
  print("Cek API");
  AuthServices api = new AuthServices();

  api.login("budi", "coba").then((value) {
    print(value);
  });
}
