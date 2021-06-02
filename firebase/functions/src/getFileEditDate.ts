import { app } from './app'

export interface DataResponse {
  error: boolean
  date: string
  data: string
  message: string
}

export async function getFileEditDate(
  givenDate: string,
  file: string
): Promise<DataResponse> {
  const fileBucket = app
    .storage()
    .bucket('gs://kampus-sggw-2021.appspot.com')
    .file(file)

  const metadata = await fileBucket.getMetadata()

  const editDate: string = metadata[0].timeCreated

  if (editDate !== givenDate) {
    const content = await fileBucket.download()

    return {
      error: false,
      date: editDate,
      data: content[0].toString(),
      message: 'Update potrzebny',
    }
  }

  return {
    error: false,
    date: editDate,
    data: '',
    message: 'Update zbędny',
  }
}
