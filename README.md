# Kampus SGGW

## Jak tłumaczyć apkę
Tłumaczenia należy dodawać do plików znajdujących się w folderze ```assets/translations```.
Poradnik odnośnie tworzenia tłumaczeń znaleźć można tutaj: https://pub.dev/packages/easy_localization

Po dodaniu nowych tłumaczeń należy wykonać w terminalu dwie komendy:

1) ```flutter pub run easy_localization:generate -S assets/translations -O lib/translations```

2) ```flutter pub run easy_localization:generate -S assets/translations -O lib/translations -o locale_keys.g.dart -f keys```

Wygenerują one kod do plików ```codegen_loader.dart``` oraz ```locale_keys.g.dart```, które znajdują się w folderze ```lib/translations```.

Z tego co mi się na razie wydaje tłumaczenia działają tylko wewnątrz metod, które mają przekazywany ```BuildContext```. Jeśli się to potwierdzi to dodam tu informację na ten temat.

## Modyfikowanie modeli
Modele znajdują się w folderze ```lib/model```.
Po każdej modyfikacji modelu np. dodaniu pola czy zmianie typu pola należy w konsoli w folderze ../kampus_sggw wpisać:
```flutter pub run build_runner build```
Polecenie spowoduje update lub wygenerowanie pliku <nazwa_klasy>.g.dart. Pliki te są wykorzystywane przez JsonSerializable i są generowane tylko dla klas, które mają adnotacje @JsonSerializable() przed nazwą klasy.

Poradnik odnośnie generowania plików dla JsonSerializable jest tutaj: https://flutter.dev/docs/development/data-and-backend/json#one-time-code-generation