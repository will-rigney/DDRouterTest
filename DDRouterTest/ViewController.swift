//
//  ViewController.swift
//  DDRouterTest
//
//  Created by Rigney, Will (AU - Sydney) on 16/9/19.
//  Copyright © 2019 Will Rigney. All rights reserved.
//

import UIKit
import DDRouter

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let bag = DisposeBag()

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // networking
    let router = Router<TestEndpoint>()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndicator.stopAnimating()

        self.quoteLabel.text = "DDRouter Test App"
        self.authorLabel.text = "Programmer quotes"

        // Do any additional setup after loading the view.
        self.button.rx.tap
            .do { self.activityIndicator.startAnimating() }
            .flatMap(self.getRandomQuote)
            // todo: catch error!
            .subscribe(onNext: { result in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.quoteLabel.text = result.en
                    self.authorLabel.text = result.author
                }
            })
            .disposed(by: self.bag)
    }

    func getRandomQuote() -> Single<ResponseModel> {
        return self.router.request(.random)
    }
}

