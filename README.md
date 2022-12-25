# Kampus SGGW

## Gałęzie main i dev
Na gałęzi ```main``` mamy wersję aplikacji, która jest aktualnie na App Store i Google Play. Jest to aktualny release. Wszystkie pull requesty wykonujemy do gałęzi ```dev```. Tam znajduje się aktualnie rozwijany kod aplikacji.

## Klucze API
Do odpalenia apki potrzebne są klucze API do Google Maps, bez nich nie wyświetli wam się mapka w aplikacji. 
Ze względów bezpieczeństwa nie udostępniamy ich publicznie w repozytorium, aby je dostać wystarczy poprosić na Discordzie. Po uzyskaniu klucza są 2 metody dodania go do kodu.

### Automatyczne dodanie klucza
W Git Bash należy przejść do katalogu ze sklonowanym repozytorium (katalog z folderem `.git`) i wywołać komendę:
```
bash set_map_key.sh -k otrzymany_klucz
```
Należy sprawdzić czy dodano klucz oraz czy Git Bash lub Git Kraken nie wyśledziły zmian w plikach
```
/android/app/src/main/AndroidManifest.xml
/ios/Runner/AppDelegate.swift
/web/index.html
```
Jeżeli przy wywoływaniu skryptu zostanie wpisany niepoprawny klucz trzeba wywołać po ponowanie z opcjami -k *poprawny klucz* -r *niepoprawny klucz*.
```
bash set_map_key.sh -k poprawny_klucz -r niepoprawny_klucz
```

### Manualne dodanie klucza
W katalogu repozytorium odpalić te 3 komendy.
```
git update-index --skip-worktree android/app/src/main/AndroidManifest.xml
git update-index --skip-worktree ios/Runner/AppDelegate.swift
git update-index --skip-worktree web/index.html
```
Dzięki nim możemy wpisać klucze do odpowiednich plików, a Git nie będzie próbował zsynchronizować
ich z repozytorium.

Następnie wpisujemy otrzymane klucze w niżej podanych plikach, zastępując teksty `MAPS_KEY_HERE`:
```
/android/app/src/main/AndroidManifest.xml
/ios/Runner/AppDelegate.swift
/web/index.html
```
Teraz zbudowana aplikacja powinna działać prawidłowo.  
Prosimy bardzo uważać, żeby przypadkiem nie pushnąć commita z kluczami, bo będziemy musieli je zmieniać.

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

## Null safety
Najnowsza wersja kodu jest oparta o mechanizm null safety. Domyślnie, wszystkie typy są nie-nullowalne,. Aby wartość zmiennej danego typu mogła być ```null```, należy wcześniej oznaczyć typ jako nullable poprzez ```?```. Wraz z implementacją null safety dochodzą 4 operatory i słowa kluczowe: ```?```, ```!```, ```late``` i ```late final```.

Zwracajcie na to uwagę w kodzie, wiele oryginalnych typów nie przyjmie już ```null``` jako wartości. Większość argumentów dostanie adnotację ```required```. 

Tłumaczenie zasad null safety w Darcie: https://dart.dev/null-safety/understanding-null-safety
