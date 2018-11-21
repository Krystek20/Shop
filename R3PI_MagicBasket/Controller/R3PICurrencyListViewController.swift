import UIKit

final class R3PICurrencyListViewController: UITableViewController {

    var didSelectCurrency: (R3PICurrency) -> () = { _ in }
    var didUpdateCurrencyList: ([R3PICurrency]) -> () = { _ in }
    
    var apiClient: R3PIApiClientProtocol = R3PIApiClient()
    let currencyListDataSource = R3PICurrencyListDataSource()
    var activityIndicatorView = UIActivityIndicatorView.currencyListIndicatorView

    var timer: Timer? = nil
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = currencyListDataSource
        tableView.backgroundView = activityIndicatorView
        onActivityIndicatorView()
        fetchCurrencyList()
    }
    
    func onActivityIndicatorView() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        tableView.isUserInteractionEnabled = false
        for cell in tableView.visibleCells {
            cell.alpha = 0.25
        }
    }
    
    func offActivityIndicatorView() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
        
        tableView.isUserInteractionEnabled = true
        for cell in tableView.visibleCells {
            cell.alpha = 1
        }
    }
    
    func fetchCurrencyList() {
        apiClient.getCurrencyList({ [weak self] in self?.loadCurrencyList($0) })
    }
    
    private func loadCurrencyList(_ list: [R3PICurrency]) {
        offActivityIndicatorView()
        currencyListDataSource.currencyList.removeAll()
        currencyListDataSource.currencyList = list
        tableView.reloadData()
        
        didUpdateCurrencyList(currencyListDataSource.currencyList)
        setupTimerIfNotExist()
    }
    
    private func setupTimerIfNotExist() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [weak self] in self?.reloadCurrencyList(with: $0)})
        }
    }
    
    private func reloadCurrencyList(with timer: Timer) {
        onActivityIndicatorView()
        fetchCurrencyList()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        didSelectCurrency(currencyListDataSource.currencyList[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
}
