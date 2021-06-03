# Funkcja Firebase do aktualizacji mapItems

Funkcja jest napisana w TS ( https://typescriptlang.org/ ) na platformę nodejs ( https://nodejs.org/en/ )

Instalacja narzędzi firebase
```
npm i -g firebase-tools
```

Może wymagać również Google Cloud SDK 
> https://cloud.google.com/sdk/docs/install

## Przejście do podprojektu
```
cd firebase/functions
```

## Logowanie
```
firebase login
```

## Instalacja zależności - lokalnie
```
npm i
```

## Uruchomienie developerskie - lokalnie
```
npm run serve
```

Endpoint dostępny w:
> http://localhost:5001/kampus-sggw-2021/us-central1/mapItems?token=mGl0bnenMANgd9CUpeg3Pw==

## Deploy do firebase
```
npm run deploy
```

lub

```
firebase deploy
```

# Użycie

> /mapItems?token=[Token aktualizacji]

Przykładowo
> /mapItems?token=mGl0bnenMANgd9CUpeg3Pw==

Na produkcji
> https://us-central1-kampus-sggw-2021.cloudfunctions.net/mapItems?token=mGl0bnenMANgd9CUpeg3Pw==

Zwraca

```
interface DataResponse {
  error: boolean
  oldToken: string
  token: string
  data: string
  message: string
}
```

error = false - wszystko zadziało ok <br />
oldToken = stary token, taki jak został odczytany <br />
token = aktualny token <br />
data = dane jeżeli query.token == token pusty string w przeciwnym wypadku string z zawartością pliku <br />
message = info co się zadziało <br />
