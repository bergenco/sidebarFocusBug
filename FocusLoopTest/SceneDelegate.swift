import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let primaryCollectionView = UINavigationController(rootViewController: SidebarCollectionView(nibName: nil, bundle: nil))
        let secondaryViewController = FocusingViewController(title: "Secondary")

        // Create the split view controller
        let splitViewController = UISplitViewController(style: .doubleColumn)
        splitViewController.setViewController(primaryCollectionView, for: .primary)
        splitViewController.setViewController(secondaryViewController, for: .secondary)
        splitViewController.show(.primary)
        splitViewController.showsSecondaryOnlyButton = true
        splitViewController.primaryBackgroundStyle = .sidebar
        splitViewController.displayModeButtonVisibility = .always

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = splitViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

