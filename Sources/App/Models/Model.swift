//
//  Model.swift
//  App
//
//  Created by ned on 07/06/2019.
//

import Vapor

// Response struct
struct Response: Content {
    var uuid: String
}

enum Util {

    // Returns /Public/plists/ folder URL
    static func getPlistsFolder() -> URL {
        return URL(fileURLWithPath: DirectoryConfig.detect().workDir).appendingPathComponent("Public/plists", isDirectory: true)
    }

    // Returns plist file Data with given bundle and url string
    static func getPlist(bundle: String, link: String, title: String) -> Data {
        let stringData = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>items</key>
            <array>
                <dict>
                    <key>assets</key>
                    <array>
                        <dict>
                            <key>kind</key>
                            <string>software-package</string>
                            <key>url</key>
                            <string>\(link)</string>
                        </dict>
                    </array>
                    <key>metadata</key>
                    <dict>
                        <key>bundle-identifier</key>
                        <string>\(bundle)</string>
                        <key>bundle-version</key>
                        <string>1.0</string>
                        <key>kind</key>
                        <string>software</string>
                        <key>title</key>
                        <string>\(title)</string>
                    </dict>
                </dict>
            </array>
        </dict>
        </plist>
        """
        return Data(stringData.utf8)
    }
}

