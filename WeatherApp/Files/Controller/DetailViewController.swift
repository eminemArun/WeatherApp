import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!
    let detailCellReuseIdentifier = "DetailCellReuseIdentifier"
    var selectedLocation: String?
    private var weatherViewModel :WeatherViewModel!
    private var service: Service!
    private var locationInfo:[LocationInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUIAndService()
    }
    
    func loading(_ loading:Bool) {
       if loading{
        self.view.activityStartAnimating()
       }else{
          self.view.activityStopAnimating()
       }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.loading(false)
    }
    private func updateUIAndService() {
        guard let location = selectedLocation else{
            return
        }
        service = Service(networking: Network())
        self.weatherViewModel = WeatherViewModel(service: service)
        self.weatherViewModel.delegate = self
        self.title = "Tomorrow weather in \(location)"
        //First get woeid for selected location
        self.weatherViewModel.searchLocationFor(location)
        self.loading(true)

    }
}

// Extension for web sevice delegates
extension DetailViewController:WeatherViewModelDelegate{
    func locationInfo(_ info: [LocationInfo]?) {
      guard let info = info else {
        self.loading(false)
        return
      }
        self.loading(false)
        self.locationInfo = info
        self.tableView.reloadData()
    }
    
    func locationSearchData(_ locationSearch: LocationSearch?) {
        guard let locationSearch = locationSearch else {
            self.loading(false)
            return
        }
        //(woeid)/(date)/ for getting weather data
        let query = "\(String(locationSearch.woeid))/\(tommorow())/"
        self.weatherViewModel.getLocationInfoFor(query)
    }
}

extension DetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let locationInfo = self.locationInfo else {
            return 0
        }
        return locationInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellReuseIdentifier, for: indexPath) as! DetailTableViewCell
        
        let locationData = self.locationInfo?[indexPath.section]
        cell.summaryLabel.text = locationData?.weather_state_name
        cell.windDirectionCompass.text = locationData?.wind_direction_compass
        if let minTemp = locationData?.min_temp, let maxTemp = locationData?.max_temp {
            cell.minTempLabel.text = String(minTemp)
            cell.maxTempLabel.text = String(maxTemp)
        }
        if let weatherUrl = locationData?.weather_state_abbr,let url = URL(string: iconPreURL + weatherUrl + ".png"){
            cell.weatherIcon.load(url:url)
        }

        return cell
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let applicableDate = self.locationInfo?[section] else{
            return nil
        }
        return String("ID: \(applicableDate.id)")

      }
}
