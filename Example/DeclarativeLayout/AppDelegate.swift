import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let _ = NSClassFromString("XCTest") {
            return true
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = UINavigationController(rootViewController: MenuViewController())
        window?.rootViewController = navController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
                
        return true
    }

}

