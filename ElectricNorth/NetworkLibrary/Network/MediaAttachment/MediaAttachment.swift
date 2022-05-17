//
//  Media.swift
//  VomobileOfficeApp
//
//  Created by Zohaib on 17/06/2021.
//

import UIKit

struct MediaAttachment: Codable{
    let parameterName: String
    let fileName: String
    let data: Data
    let mimeType: String
    
    init?(withMedia data:Data, filename:String = "\(arc4random()).jpeg", mimeType:MediaMimeType ,forKey parameterName: String) {
        self.parameterName = parameterName
        self.fileName = "\(filename)"
        self.mimeType = mimeType.rawValue
        self.data = data
    }
}

public enum MediaMimeType : String
{
    // images mime type
    case gif = "image/gif"
    case jpeg = "image/jpeg"
    case pjpeg = "image/pjpeg"
    case png = "image/png"
    case svgxml = "image/svg+xml"
    case tiff = "image/tiff"
    case bmp = "image/bmp"

    // document mime type
    case csv = "text/csv"
    case wordDocument = "application/msword"
    case pdf = "application/pdf"
    case richTextFormat = "application/rtf"
    case plainText = "text/plain"

}
