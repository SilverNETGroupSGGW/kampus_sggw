# Funkcja Firebase do aktualizacji mapItems

Funkcja jest napisana w TS ( https://typescriptlang.org/ ) na platformę nodejs ( https://nodejs.org/en/ )

Instalacja narzędzi firebase
```
npm i -g firebase-tools
```

Może wymagać również Google Cloud SDK 
> https://cloud.google.com/sdk/docs/install

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
> http://localhost:5001/kampus-sggw-2021/us-central1/mapItems?date=2021-05-23T18:42:45.758Z

## Deploy do firebase
```
npm run deploy
```

lub

```
firebase deploy
```

# Użycie

> /mapItems?date=[Data ostatniej aktualizacji]

Przykładowo
> /mapItems?date=2021-05-23T18:42:45.758Z

Na produkcji
> https://us-central1-kampus-sggw-2021.cloudfunctions.net/mapItems?date=2021-05-23T18:42:45.758Z

Zwraca

```
interface DataResponse {
  error: boolean
  date: string
  data: string
  message: string
}
```

error = false - wszystko zadziało ok <br />
date = aktualna data ważności <br />
data = dane jeżeli query.date == date pusty string w przeciwnym wypadku string z zawartością pliku <br />
message = info co się zadziało <br />
