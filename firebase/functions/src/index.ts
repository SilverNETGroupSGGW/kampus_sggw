import * as functions from 'firebase-functions'

import { getFileUpdate, DataResponse } from './getFileEditDate'

export const mapItems = functions.https.onRequest(async (request, response) => {
  const token = request.query.token?.toString() || ''
  // parseInt aby nie bawić się w walidacje. `|| 1` aby NaN zastąpić 1
  // NIE POZWALAĆ NA WSZYSTKO, bo można wtedy pobrać inne pliki !!!
  const version = parseInt(request.query.version?.toString() || '1') || 1

  try {
    const result = await getFileUpdate(token, `map_items_${version}.json`, version)

    functions.logger.log({
      version,
      requestedToken: token,
      updateNeeded: result.data.length !== 0,
    })

    response.send(result)
  } catch (e) {
    functions.logger.error({
      version,
      requestedToken: token,
      error: e,
    })

    const error: DataResponse = {
      version,
      error: true,
      oldToken: token,
      token: '',
      data: '',
      message: 'Wystąpił niespodziewany błąd',
    }

    response.status(500).send(error)
  }
})
