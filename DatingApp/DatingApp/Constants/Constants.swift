//
//  Constants.swift
//  BiduSwiftUI
//
//  Created by Radley Hoang on 12/09/2021.
//

import UIKit
import SwiftUI

let __SCREEN_WIDTH__ = UIScreen.main.bounds.width
let __SCREEN_HEIGHT__ = UIScreen.main.bounds.height

struct K {
    enum Fonts: String {
        case lexendBlack = "Lexend-Black"
        case lexendBold = "Lexend-Bold"
        case lexendExtraBold = "Lexend-ExtraBold"
        case lexendExtraLight = "Lexend-ExtraLight"
        case lexendLight = "Lexend-Light"
        case lexendMedium = "Lexend-Medium"
        case lexendRegular = "Lexend-Regular"
        case lexendSemiBold = "Lexend-SemiBold"
        case lexendThin = "Lexend-Thin"
    }
    
    struct Constants {
        static let DefaultColor: Color = Color(Asset.Colors.Global.grayF2F2F7.color)
        static let NavigationHeight: CGFloat = 44
        static let ScreenPadding: CGFloat = 20
        static let PagingLimit: Int = 10
        
        struct EditProfile {
            static let ImageColumns: CGFloat = 3
            static let ItemOffset: CGFloat = 12
            static let TotalOffset: CGFloat = K.Constants.ScreenPadding * 2 + K.Constants.EditProfile.ItemOffset * (K.Constants.EditProfile.ImageColumns - 1)
        }
    }
    
    struct API {
        struct HeaderKey {
            static let AcceptLanguage = "Accept-Language"
        }
        
        struct URL {
            static var BaseUrl: String {
                get {
                    if let newUrl = Helper.getLocalValue(withKey: "SERVER_IP") {
                        return "http://\(newUrl):3000/api/"
                    } else {
                        return LiveUrl
                    }
                }
            }
            static var SocketUrl: String {
                return BaseUrl.replacingOccurrences(of: "/api/", with: "")
            }
            static let StagingUrl = "http://localhost:3000/api/"
            static let LocalUrl = "http://192.168.1.9:3000/api/"
            static let LiveUrl = "https://make-friend.herokuapp.com/api/"
            
            static let InterestedTag = "interested-tags"
            static let Auth = "auth"
            static let Register = Auth + "/register"
            static let Login = Auth + "/login"
            static let User = "user"
            static let Upload = "upload"
            static let Recs = "recs"
            static let Chat = "chat"
        }
        
        struct ParameterKeys {
            static let _Id = "_id"
            static let Id = "id"
            static let Name = "name"
            static let Email = "email"
            static let Password = "password"
            static let Phone = "phone"
            static let DateOfBirth = "date_of_birth"
            static let CreatedAt = "createdAt"
            static let UpdatedAt = "updatedAt"
        }
    }
    
    struct UserDefaults {
        static let Token = "token"
        static let User = "user"
    }
    
    struct KeyPaths {
        static let DidSignupSuccess = "DidSignupSuccess"
    }
}

// MARK: - Notification Name
extension Notification.Name {
    static let UserIsInvalid = Notification.Name("UserIsInvalid")
    static let UpdateMandatoryInformationSuccess = Notification.Name("UpdateMandatoryInformationSuccess")
    static let GetProfileUserFailed = Notification.Name("GetProfileUserFailed")
    static let GetProfileUserSuccess = Notification.Name("GetProfileUserSuccess")
    static let ChangedLocationPermission = Notification.Name("ChangedLocationPermission")
    static let GetRecommendUserAndUpdateLocation = Notification.Name("GetRecommendUserAndUpdateLocation")
    static let DidGotMatch = Notification.Name("DidGotMatch")
    static let DismissGotMatchScreen = Notification.Name("DismissGotMatchScreen")
    static let DidReceivedMessage = Notification.Name("DidReceivedMessage")
    static let UpdateLastMessage = Notification.Name("UpdateLastMessage")
    static let DidUpdateProfileSuccess = Notification.Name("DidUpdateProfileSuccess")
    static let DidUpdateInterestedTagsSuccess = Notification.Name("DidUpdateInterestedTagsSuccess")
    static let DidChooseImageForUpdatingSuccess = Notification.Name("DidChooseImageForUpdatingSuccess")
    static let DidChooseImageForDeletingSuccess = Notification.Name("DidChooseImageForDeletingSuccess")
    static let DidSocketConnectSuccess = Notification.Name("DidSocketConnectSuccess")
    static let DismissDetailProfileView = Notification.Name("DismissDetailProfileView")
    static let DidReadMessageSuccess = Notification.Name("DidReadMessageSuccess")
    static let NotifyTypingMessage = Notification.Name("NotifyTypingMessage")
    static let NotifyStopTypingMessage = Notification.Name("NotifyStopTypingMessage")
    static let DidReportUserSuccess = Notification.Name("DidReportUserSuccess")
    static let DidVerifyPhoneSuccess = Notification.Name("DidVerifyPhoneSuccess")
    static let DidLikeOrDislikeSuccess = Notification.Name("DidLikeOrDislikeSuccess")
}
