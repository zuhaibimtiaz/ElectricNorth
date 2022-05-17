//
//  Notification+Extension.swift
//  VomobileOfficeApp
//
//  Created by Nabeel Sohail on 15/07/2021.
//

import Foundation

extension Notification.Name {
    static let FilesButtonClick = Notification.Name("FilesButtonClick")
    static let didRefreshData = Notification.Name("didRefreshData")
    static let didDeleteFile = Notification.Name("didDeleteFile")
    static let didReceiveProgressData = Notification.Name("didReceiveProgressData")
    static let fileSuccessfullyUploadedDone = Notification.Name("fileSuccessfullyUploadedDone")
    static let fileUploadingToClientDone = Notification.Name("fileUploadingToClientDone")
    static let newsAndLinksEditDone = Notification.Name("newsAndLinksEditDone")
    static let anotherUploadToSameClient = Notification.Name("anotherUploadToSameClient")
}
