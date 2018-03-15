import Heimdallr
import SwiftyJSON

protocol OAuth2Delegate: class {
    func oauth2DidLoginSuccessed(_ accessToken: String)
    func oauth2DidLoginFailed(_ error: NSError)
}

class OAuth2 {
    weak var delegate: OAuth2Delegate?
    
    var deviceToken: String? {
        didSet {
            submitDeviceToken()
        }
    }
    
    fileprivate let accessTokenStore: OAuthAccessTokenKeychainStore
    
    fileprivate let heimdallr: Heimdallr
    
    fileprivate(set) var accessToken: String? {
        get { return APIRequest.shared.accessToken }
        set { APIRequest.shared.accessToken = newValue }
    }
    
    fileprivate(set) var currentUser: User? {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name.userChanged, object: nil)
        }
    }
    
    fileprivate(set) var unreadNotificationCount: Int = 0 {
        didSet {
            if unreadNotificationCount != oldValue {
                NotificationCenter.default.post(name: NSNotification.Name.userUnreadNotificationChanged, object: nil)
            }
        }
    }
    
    static fileprivate let _shared = OAuth2()
    
    static var shared: OAuth2 {
        return _shared
    }
    
    init() {
        accessTokenStore = OAuthAccessTokenKeychainStore(service: "org.ruby-china.turbolinks-app.oauth")
        heimdallr = Heimdallr(tokenURL: URL(string: "\(ROOT_URL)/oauth/token")!, credentials: OAuthClientCredentials(id: OAUTH_CLIENT_ID, secret: OAUTH_SECRET), accessTokenStore: accessTokenStore)
        
        accessToken = accessTokenStore.retrieveAccessToken()?.accessToken
        if (accessToken != nil) {
            if let userData = UserDefaults.standard.data(forKey: "loginUserJSON") {
                do {
                    let jsonObject = try JSON(data: userData)
                    currentUser = User(json: jsonObject)
                    refreshUnreadNotifications()
                } catch {
                }
            }
            
            reloadCurrentUser()
        }
    }
    
    func login(_ username: String, password: String) {
        heimdallr.requestAccessToken(username: username, password: password) { result in
            switch result {
            case .success:
                guard let accessToken = self.accessTokenStore.retrieveAccessToken()?.accessToken else {
                    log.info("Login is successful but the access_Token is missing")
                    let err = NSError(domain: "customize", code: -1, userInfo: [NSLocalizedDescriptionKey: "get accessToken failed".localized])
                    
                    DispatchQueue.main.async {
                        self.delegate?.oauth2DidLoginFailed(err)
                    }
                    return
                }
                log.info("Login successed. accessToken=\(accessToken)")
                self.accessToken = accessToken
                self.submitDeviceToken()
                self.reloadCurrentUser() { (response, user) in
                    switch response.result {
                    case .success(_):
                        if user != nil {
                            self.delegate?.oauth2DidLoginSuccessed(accessToken)
                        } else {
                            self.delegate?.oauth2DidLoginFailed(NSError(domain: "customize", code: -1, userInfo: [NSLocalizedDescriptionKey: "no user information was returned".localized]))
                        }
                    case .failure(let err):
                        self.delegate?.oauth2DidLoginFailed(err as NSError)
                    }
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    self.delegate?.oauth2DidLoginFailed(err)
                }
            }
        }
    }
    
    var isLogined: Bool {
        return accessToken != nil && currentUser != nil
    }
    
    fileprivate func submitDeviceToken() {
        if let deviceToken = deviceToken , isLogined {
            DeviseService.create(deviceToken)
        }
    }
    
    fileprivate func reloadCurrentUser(callback: ((APICallbackResponse, User?) -> ())? = nil) {
        UsersService.me { (response, user) in
            switch response.result {
            case .success(let data) where user != nil:
                self.currentUser = user!
                log.info(self.currentUser)
                UserDefaults.standard.setValue(data, forKey: "loginUserJSON")
                UserDefaults.standard.synchronize()
            default:
                break
            }
            callback?(response, user)
        }
    }
    
    func refreshUnreadNotifications() {
        if !isLogined {
            unreadNotificationCount = 0
            return
        }
        APIRequest.shared.get("/api/v3/notifications/unread_count", parameters: nil) { [weak self] (response, result) in
            if let result = result, !result.isEmpty {
                let unreadCount = result["count"].intValue
                log.info(["Unread notification count", unreadCount])
                self?.unreadNotificationCount = unreadCount
            }
        }
    }
    
    func logout() {
        if let deviceToken = deviceToken , isLogined {
            DeviseService.destroy(deviceToken)
        }
        
        heimdallr.clearAccessToken()
        accessToken = nil
        currentUser = nil
        unreadNotificationCount = 0
        UserDefaults.standard.removeObject(forKey: "loginUserJSON")
        UserDefaults.standard.synchronize()
        
        NotificationCenter.default.post(name: NSNotification.Name.userSignout, object: nil)
    }
}
