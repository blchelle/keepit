//
//  Constants.swift
//  ReconciliationApp
//
//  Created by Brock Chelle on 2019-05-26.
//  Copyright © 2019 Brock Chelle. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct ID {
        
        // MARK: - Storyboard VCIDs
        struct VC {
            
            // Storyboard Identifiers
            static let backgroundAuth = "BackgroundAuthVC"
            static let login          = "LoginVC"
            static let createAccount  = "CreateAccountVC"
            static let forgotPassword = "ForgotPasswordVC"
            static let addItem        = "AddItemVC"
            static let tabBar         = "TabBarVC"
            
        }
        
        // MARK: - Segue IDs
        struct Segue {
            
            static let loggedIn       = "LoggedIn"
            static let accountCreated = "AccountCreated"
            
        }
        
        // MARK: - Cell ID's
        struct Cell {
            static let item     = "ItemCell"
            static let addItem  = "AddItemCell"
        }
        
    }
    
    // MARK: - Views
    struct View {
        
        // MARK: - Corner Radius
        struct CornerRadius {
            static let standard: CGFloat = 15
            static let button: CGFloat   = 10
        }
        
        // MARK: - Width
        struct Width {
            static let standard: CGFloat          = min(400, UIScreen.main.bounds.width - 20)
        }
        
        // MARK: - Height
        struct Height {
            static let login: CGFloat         = min(240, UIScreen.main.bounds.height - 350)
            static let createAccount: CGFloat = min(230, UIScreen.main.bounds.height - 350)
            static let addItem: CGFloat       = min(340, UIScreen.main.bounds.height - 220)
        }
        
        // MARK: - Y
        struct Y {
            static let error: CGFloat = UIScreen.main.bounds.height * 0.3
        }
        
    }
    
    // MARK: - Color
    struct Color {
        
        static let floatingView   = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 204/255)
        static let primary         = UIColor(red: 175/255, green: 82/255, blue: 222/255, alpha: 255/255)
        static let inactiveButton = UIColor(red: 175/255, green: 82/255, blue: 222/255, alpha: 120/255)
        
        static let success         = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 255/255)
        static let error           = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 255/255)
    
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
            
            static let items         = "Items"
            static let name      = "Item Name"
            static let movement  = "Is Moved Often"
            static let location  = "Location"
            static let imageURL  = "Image URL"
            
        }
    
    }
    
}
