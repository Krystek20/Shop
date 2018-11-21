import UIKit

class R3PISummaryViewController: UIViewController {

    @IBOutlet weak var summaryView: R3PISummaryView!
    var exchnagePrice: R3PIExchnagePrice? = nil
    
    var apiClient: R3PIApiClientProtocol = R3PIApiClient()
    var timer: Timer? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        summaryView.priceLabel.text = exchnagePrice?.stringValue
        setupTimerIfNotExist()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
        timer = nil
    }
    
    private func setupTimerIfNotExist() {
        if timer == nil && exchnagePrice?.price.symbol != exchnagePrice?.currency.symbol {
            timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [weak self] in self?.reloadCurrencyList(with: $0)})
        }
    }
    
    private func reloadCurrencyList(with timer: Timer) {
        summaryView.onActivityIndicatorView()
        fetchCurrencyList()
    }
    
    func fetchCurrencyList() {
        apiClient.getCurrencyList({ [weak self] in self?.updateCurrentCurrency($0) })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R3PIConst.R3PI_CONST_CURRENCY_LIST_SEGUE_IDENTIFIER, let navigationController = segue.destination as? UINavigationController, let currencyListViewController = navigationController.viewControllers.first as? R3PICurrencyListViewController {
            
            currencyListViewController.didUpdateCurrencyList = { [weak self] in self?.updateCurrentCurrency($0) }
            currencyListViewController.didSelectCurrency = { [weak self] in self?.changeCurrency($0) }
        }
    }
    
    private func updateCurrentCurrency(_ currencyList: [R3PICurrency]) {
        summaryView.offActivityIndicatorViewIfOn()
        if let currency = currencyList.first(where: { $0 == exchnagePrice?.currency }) {
            changeCurrency(currency)
        }
    }
    
    private func changeCurrency(_ currency: R3PICurrency) {
        exchnagePrice = exchnagePrice?.setCurrency(currency) ?? nil
    }
    
    @IBAction func doneAction(_ sender: R3PIAcceptButton) {
        dismiss(animated: true)
    }

}
