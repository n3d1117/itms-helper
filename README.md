# 📤 ITMS Helper

## What's this?
ITMS Helper provides a free API to generate and serve custom `.plist` files, useful for <b>OTA</b> (Over-The-Air) deployment of iOS Apps.

## Why did you make this?
The `.plist` files used for OTA deployment <b>must</b> be served with HTTPS protocol, and [Vapor Cloud](https://vapor.cloud/) hosting includes it by default.

## What are the requirements?
* A <b>direct link</b> to a `.ipa` file that is already signed for your device. The link can be HTTP, and you can even use a local server to serve the file (e.g `http://127.0.0.1:8080/file.ipa`).
* The <b>bundle identifier</b> of the `.ipa` file you're installing (e.g `com.apple.Maps`).
* The <b>name</b> of the app. Can be any string.

## How can I use the APIs?
* Send a <b>HTTP GET</b> request to `https://itms-plist-helper.vapor.cloud/request` with parameters `link` (link to the `.ipa` file), `bundle` (bundle identifier) and `title` (name of the app).
* If all parameters are correct, the response will be a <b>JSON</b> object containing a `uuid` field.
* The .plist file will then be located at `https://itms-plist-helper.vapor.cloud/plists/{uuid}.plist`
Note that all `.plist` files are kept on the server for a maximum of 24 hours.

### Example request:
`https://itms-plist-helper.vapor.cloud/request?link=http://example.com/file.ipa&bundle=sample.app.bundle&title=some%20title⁣`

### Example response:
`{ "uuid": "SOME_UUID" }` in JSON format.

### Further steps:
Visit this URL from your device (copy and paste it in Safari) and you'll be prompted to install the app: 
`itms-services://?action=download-manifest&url=https://itms-plist-helper.vapor.cloud/plists/{THAT_UUID}.plist⁣`

## Is there a limit on API requests?
Yes. This app is hosted on [Vapor Cloud](https://vapor.cloud/)'s free tier, which allows up to 2,000 requests per month.

## License
See [LICENSE](LICENSE) file for further information. Feel free to contribute in any way you want.
