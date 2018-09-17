import StoreKit
import UIKit

class ViewController: UIViewController {
    let appId = 363_590_051
    let appName = "NetFlix".lowercased()

    @IBAction func storeLinkTapped(_: Any) { useStoreLink() }
    @IBAction func storeKitTapped(_: Any) { useStoreKit() }
}

// MARK: - Store Link

extension ViewController {
    func useStoreLink() {
        let url = URL(string: "itms-apps://itunes.apple.com/us/app/\(appName)/id\(appId)?mt=8")!
        // also works with:
        // let url = URL(string: "itms-apps://appstore.com/\(appName)")!
        // let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)?mt=8")!

        let app = UIApplication.shared

        // Might need to add "itms-apps" to LSApplicationQueriesSchemes array Info.plist
        if app.canOpenURL(url) {
            app.open(url, options: [.universalLinksOnly: false]) { success in
                print("success: \(success)")
            }
        } else {
            print("Can't handle \(url)")
            // OSStatus error -10814 (kLSApplicationNotFoundErr)
            // No application in the Launch Services database matches the input criteria (osstatus.com)
        }
    }
}

// MARK: - Store Kit

extension ViewController {
    func useStoreKit() {
        let storeVC = SKStoreProductViewController()
        storeVC.delegate = self
        let identifier = appId
        present(storeVC, animated: true) {
            storeVC.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: identifier])
        }
    }
}

extension ViewController: SKStoreProductViewControllerDelegate {
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.presentingViewController?.dismiss(animated: true)
    }
}
