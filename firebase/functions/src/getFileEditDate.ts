import { app } from './app'

export interface DataResponse {
  error: boolean
  oldToken: string
  token: string
  data: string
  message: string
}

export async function getFileUpdate(
  givenToken: string,
  file: string
): Promise<DataResponse> {
  const fileBucket = app
    .storage()
    .bucket('gs://kampus-sggw-2021.appspot.com')
    .file(file)

  const metadata = await fileBucket.getMetadata()

  // Wszystkie metadane pliku https://firebase.google.com/docs/storage/web/file-metadata#file_metadata_properties
  const currentToken: string = metadata[0].md5Hash

  if (currentToken !== givenToken) {
    const content = await fileBucket.download()

    return {
      error: false,
      oldToken: givenToken,
      token: currentToken,
      data: content[0].toString(),
      message: 'Update potrzebny',
    }
  }

  return {
    error: false,
    oldToken: givenToken,
    token: currentToken,
    data: '',
    message: 'Update zbędny',
  }
}
