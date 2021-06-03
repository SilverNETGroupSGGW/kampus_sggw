import * as functions from 'firebase-functions'

import { getFileUpdate, DataResponse } from './getFileEditDate'

export const mapItems = functions.https.onRequest(async (request, response) => {
  const token = request.query.token?.toString() || ''

  try {
    const result = await getFileUpdate(token, 'map_items.json')

    functions.logger.log({
      requestedToken: token,
      updateNeeded: result.data.length !== 0,
    })

    response.send(result)
  } catch (e) {
    functions.logger.error({
      requestedToken: token,
      error: e,
    })

    const error: DataResponse = {
      error: true,
      oldToken: token,
      token: '',
      data: '',
      message: 'Wystąpił niespodziewany błąd',
    }

    response.status(500).send(error)
  }
})
