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

        self.activityIndicator.isHidden = true
        self.activityIndicator.startAnimating()

        self.quoteLabel.text = "DDRouter Test App"
        self.authorLabel.text = "Programmer quotes"

        // Do any additional setup after loading the view.
        self.button.rx.tap
            .do(onNext: {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                    self.button.isEnabled = false
                }
            })
            .flatMap(self.getRandomQuote)
            .catchErrorJustReturn(
                ResponseModel(
                    _id: "",
                    en: "Quote not found, please try again later.",
                    author: "")
            )
            .subscribe(onNext: { result in
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.button.isEnabled = true
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

