//
//  ViewController.swift
//  tvOS
//
//  Created by Isaac Overacker on 4/15/16.
//
//

import UIKit
import Moya

class ViewController: UIViewController {

    var gitHubAPI: MoyaProvider<GitHub>!

    @IBOutlet weak var zenLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gitHubAPI = MoyaProvider<GitHub>(plugins: [
            NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func zenButtonTriggered(sender: UIButton) {
        gitHubAPI.request(.Zen) { result in
            switch result {
            case let .Success(response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    self.zenLabel.text = try response.mapString()
                } catch {
                    print("Non-success status code returned from zen.")
                }
            case let .Failure(error):
                print("Failed to fetch zen from GitHub: \(error)")
            }
        }
    }
}

