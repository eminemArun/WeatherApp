import UIKit

class HomeViewController: UIViewController {

    private let cities = weatherCities
    @IBOutlet private var tableView:UITableView!
    let homeCellReuseIdentifier = "HomeCellReuseIdentifier"
    let detailViewSegue = "ShowDetailViewSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUIAndService()
       
    }
    
    private func updateUIAndService() {
        self.title = "Cities";
        //AccessibilityIdentifier for UITestCase
        self.tableView.accessibilityIdentifier = "cityTableView"
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            // for ipad right view will be empty so loading first weather details of city
            performSegue(withIdentifier: detailViewSegue, sender: self.cities[0])
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? DetailViewController{
            viewController.selectedLocation = sender as? String
        }
    }
}

extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailViewSegue, sender: self.cities[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = self.cities[indexPath.row]
        return cell
    }
    
}

