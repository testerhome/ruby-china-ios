import UIKit

#if DEBUG1
    let ROOT_URL = "http://localhost:3000"
    let OAUTH_CLIENT_ID = "1c58e228"
    let OAUTH_SECRET = "6d2c9cbef3e4baa56e1cf1d0db41d213105221aeff01281ac7009d21af810c58"
#else
    let ROOT_URL = "https://testerhome.com"
    let OAUTH_CLIENT_ID = "64db4322"
    let OAUTH_SECRET = "d9166ffd033340479545132cb4572d91b13da15f3a6ed3001fc1905e389f8b7c"
#endif

let COPYRIGHT_URL = "https://github.com/ruby-china/ruby-china-ios/blob/master/LICENSE.md"
let PROJECT_URL = "https://github.com/ruby-china/ruby-china-ios"

let APP_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let USER_AGENT = "turbolinks-app, testerhome, official, iOS, version:" + APP_VERSION

// Blue Theme
let BLACK_COLOR = UIColor(red: 0.04, green: 0.02, blue: 0.02, alpha: 1.0)
let PRIMARY_COLOR = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
//let NAVBAR_BG_COLOR = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
//let NAVBAR_BORDER_COLOR = UIColor(red:0.25, green:0.32, blue:0.61, alpha:1.0)
//let NAVBAR_TINT_COLOR = UIColor(red:1.00, green:1.00, blue:0.93, alpha:1.0)
//let TABBAR_BG_COLOR = UIColor(red:0.88, green:0.96, blue:1.00, alpha:1.0)

// Red Theme
//let BLACK_COLOR = UIColor(red: 0.04, green: 0.02, blue: 0.02, alpha: 1.0)
//let PRIMARY_COLOR = UIColor(red: 0.91, green: 0.33, blue: 0.23, alpha: 1.0)
//let NAVBAR_BG_COLOR = PRIMARY_COLOR
//let SIDEMENU_NAVBAR_BG_COLOR = UIColor(red: 0.74, green: 0.24, blue: 0.13, alpha: 1.0)
//let SIDEMENU_BG_COLOR = UIColor(red: 0.95, green: 0.94, blue: 0.94, alpha: 1.0)
//let NAVBAR_BORDER_COLOR = UIColor(red: 0.72, green: 0.30, blue: 0.26, alpha: 1.0)
//let NAVBAR_TINT_COLOR = UIColor(red: 1.00, green: 1.00, blue: 0.98, alpha: 1.0)
//let SEGMENT_BG_COLOR = UIColor(red: 0.23, green: 0.05, blue: 0.02, alpha: 1.0)
//let TABBAR_BG_COLOR = UIColor(red: 0.96, green: 0.94, blue: 0.94, alpha: 1.0)

// Blue Theme
//let NAVBAR_BG_COLOR = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
//let NAVBAR_BORDER_COLOR = UIColor(red:0.25, green:0.32, blue:0.61, alpha:1.0)
//let NAVBAR_TINT_COLOR = UIColor(red:1.00, green:1.00, blue:0.93, alpha:1.0)
let SEGMENT_BG_COLOR = UIColor(red:0.10, green:0.14, blue:0.39, alpha:1.0)
//let TABBAR_BG_COLOR = UIColor(red:0.88, green:0.96, blue:1.00, alpha:1.0)
let SIDEMENU_NAVBAR_BG_COLOR = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
let SIDEMENU_BG_COLOR = UIColor(red: 0.95, green: 0.94, blue: 0.94, alpha: 1.0)

let NAVBAR_BG_COLOR = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
let NAVBAR_BORDER_COLOR = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
let NAVBAR_TINT_COLOR = UIColor(red: 1.00, green: 1.00, blue: 0.98, alpha: 1.0)
let TABBAR_BG_COLOR = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)

