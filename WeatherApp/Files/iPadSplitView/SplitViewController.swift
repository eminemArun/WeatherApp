import UIKit

class SplitViewController: UISplitViewController {
    override func viewDidLoad() {
        delegate = self
        preferredDisplayMode = .allVisible
    }
}

extension SplitViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
