import * as functions from 'firebase-functions'

import { getFileEditDate, DataResponse } from './getFileEditDate'

export const mapItems = functions.https.onRequest(async (request, response) => {
  const date = request.query.date?.toString() || ''

  try {
    const result = await getFileEditDate(date, 'map_items.json')

    functions.logger.log({
      requestedDate: date,
      updateNeeded: result.data.length !== 0,
    })

    response.send(result)
  } catch (e) {
    functions.logger.error({
      requestedDate: date,
      error: e,
    })

    const error: DataResponse = {
      error: true,
      date: '',
      data: '',
      message: 'Wystąpił niespodziewany błąd',
    }

    response.status(500).send(error)
  }
})
