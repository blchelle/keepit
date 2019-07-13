//
//  Constants.swift
//  ReconciliationApp
//
//  Created by Brock Chelle on 2019-05-26.
//  Copyright © 2019 Brock Chelle. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct Constants {
    
    struct ID {
        
        struct Storyboard {
            
            static let auth     = "Auth"
            static let tabBar   = "TabBar"
            static let popups   = "Popups"
            static let settings = "Settings"
            
        }
        
        struct Segues {
            
            static let changeName     = "ChangeNameSegue"
            static let changeEmail    = "ChangeEmailSegue"
            static let changePassword = "ChangePasswordSegue"
            
        }
        
        struct VC {

            static let backgroundAuth = "BackgroundAuthVC"
            static let login          = "LoginVC"
            static let createAccount  = "CreateAccountVC"
            static let forgotPassword = "ForgotPasswordVC"
            
            static let tabBar         = "TabBarVC"
            
            static let singleItem     = "SingleItemVC"
            static let updateLocation = "UpdateLocationVC"
            static let noLocation     = "LocationReminderVC"
            static let confirmation   = "ConfirmationVC"
            
            static let settings       = "SettingsVC"
            
        }
        
        struct Cell {
            
            static let item           = "ItemCell"
            static let addItem        = "AddItemCell"
            static let updateLocation = "UpdateLocationCell"
            
            static let settingsHeader = "SettingsHeaderCell"
            
        }
        
        struct Annotation {
            
            static let item = "ItemAnnotation"
            static let user = "UserAnnotation"
            
        }
        
    }
    
    // MARK: - Views
    struct View {
        
        // MARK: - Corner Radius
        struct CornerRadius {
            
            static let standard: CGFloat    = 15
            static let smallButton: CGFloat = 10
            static let bigButton: CGFloat   = 20
            
        }
        
        // MARK: - Width
        struct Width {
            
            static let standard: CGFloat   = min(420, UIScreen.main.bounds.width - 20)
            static let annotation: CGFloat = 40
            
        }
        
        // MARK: - Height
        struct Height {
            
            static let login: CGFloat          = min(240, UIScreen.main.bounds.height - 350)
            static let createAccount: CGFloat  = min(230, UIScreen.main.bounds.height - 350)
            static let forgotPassword: CGFloat = 200
            static let singleItem: CGFloat     = min(700, UIScreen.main.bounds.height - 60)
            static let annotation: CGFloat     = 40
            static let updateLocation: CGFloat = 150
            static let itemHeader: CGFloat     = 200
            
        }
        
    }
    
    // MARK: - Color
    struct Color {
        
        static let floatingView     = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 255/255)
        static let notificationView = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 255/255)
        static let primary          = UIColor(red: 175/255, green: 82/255, blue: 222/255, alpha: 255/255)
        static let settings         = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 255/255)
        static let inactiveButton   = UIColor(red: 175/255, green: 82/255, blue: 222/255, alpha: 120/255)
        
        
        static let success          = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 255/255)
        static let error            = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 255/255)
    
    }
    
    // MARK: - Error Handling Messages
    struct ErrorMessage {
        
        static let accountDisabled         = "This account has been disabled"
        static let emailAlreadyRegistered  = "This Email already in use"
        static let emailMissing            = "An Email must be provided"
        static let emailNotRegistered      = "This Email is not registered"
        static let invalidEmail            = "This Email has an invalid format"
        static let networkError            = "Unable to connect to the server"
        static let weakPassword            = "Password needs at least 6 characters"
        static let wrongPassword           = "Incorrect password"
        
    }
    
    // MARK: - Keys for database and local storage
    struct Key {
        
        struct User {
            
            static let users         = "Users"
            static let userID        = "User ID"
            static let firstName     = "First Name"
            static let lastName      = "Last Name"
            static let email         = "Email"
            
        }
        
        struct Item {
            
            static let id             = "Item ID"
            static let items          = "Items"
            static let name           = "Item Name"
            static let movement       = "Is Moved Often"
            static let lastUpdateDate = "Last Updated"
            static let location       = "Location"
            static let imageURL       = "Image URL"
            
        }
    
    }
    
    struct Map {
    
        static let defaultSpan: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
    }
    
}
