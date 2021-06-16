import UIKit
import DDRouter

import RxSwift
import RxCocoa

class QuotesViewController: UIViewController {
    private let bag = DisposeBag()

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var vm: QuotesViewModel!

    // networking
    private let router = Router<TestEndpoint, ErrorModel>()

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.isHidden = true
        activityIndicator.startAnimating()

        quoteLabel.text = "DDRouter Test App"
        authorLabel.text = "Programmer quotes"

        // Do any additional setup after loading the view.
        button.rx.tap
            .do(
                onNext: {
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = false
                        self.activityIndicator.startAnimating()
                        self.button.isEnabled = false
                    }
                }
            )
            .flatMap(getRandomQuote)
            .catchError {
                print("error: \($0)") // todo
                return .just(
                    ResponseModel(
                        id: 0,//"",
                        title: "Quote not found, please try again later."))
    //                    author: ""))
            }
            .debug()
            .subscribe(
                onNext: { result in
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        self.button.isEnabled = true
                        self.quoteLabel.text = result.title
                        self.authorLabel.text = ""//"\(result.id)"//result.author
                    }
                }
            )
            .disposed(by: bag)
    }

    func getRandomQuote() -> Single<ResponseModel> {
        return router.request(.random)
    }
}
