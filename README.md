# 📤 ITMS Helper

<img alt="Screenshot" src="https://user-images.githubusercontent.com/11541888/59136187-44879200-8982-11e9-88a0-d1f47f358987.png">

## What's this?
ITMS Helper is a small web app powered by [Vapor 3](https://vapor.codes) that provides a free API to generate and serve custom `.plist` files, useful for <b>OTA</b> (Over-The-Air) deployment of iOS Apps.

## Why did you make this?
The `.plist` files used for OTA deployment <b>must</b> be served with HTTPS protocol, and [Heroku](https://heroku.com) hosting includes it by default.

## What are the requirements?
* A <b>direct link</b> to a `.ipa` file that is already signed for your device. The link can be HTTP, and you can even use a local server to serve the file (e.g `http://127.0.0.1:8080/file.ipa`).
* The <b>bundle identifier</b> of the `.ipa` file you're installing (e.g `com.apple.Maps`).
* The <b>name</b> and <b>version</b> of the app (version is optional). Can be any string.

## How can I use the APIs?
* Send a <b>HTTP GET</b> request to `https://itms-plist-helper.herokuapp.com/request` with parameters `link` (link to the `.ipa` file), `bundle` (bundle identifier), `title` (name of the app) and `version` (bundle version, optional).
* If all parameters are correct, the response will be a <b>JSON</b> object containing a `uuid` field.
* The .plist file will then be located at `https://itms-plist-helper.herokuapp.com/plists/{uuid}.plist`
Note that all `.plist` files are kept on the server for a maximum of 24 hours.

### Example request:
`https://itms-plist-helper.herokuapp.com/request?link=http://example.com/file.ipa&bundle=sample.app.bundle&title=some%20title&version=1.0⁣`

### Example response:
`{ "uuid": "SOME_UUID" }` in JSON format.

### Further steps:
Visit this URL from your device (copy and paste it in Safari) and you'll be prompted to install the app: 
`itms-services://?action=download-manifest&url=https://itms-plist-helper.herokuapp.com/plists/{THAT_UUID}.plist⁣`

## Is there a limit on API requests?
<b>Yes.</b> This app is hosted on [Heroku](https://heroku.com/)'s free tier, so restrictions may apply.

## Can I build and run this project manually?
Of course! Make sure you have [Vapor 3](https://docs.vapor.codes/3.0/install/macos/) installed and run the following commands:
```
$ git clone https://github.com/n3d1117/itms-helper.git
$ cd itms-helper/
$ vapor update && vapor build && vapor run serve
```

## License
See [LICENSE](LICENSE) file for further information. Feel free to contribute in any way you want.
