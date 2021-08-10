//
//  ViewController.swift
//  APIKit-demo
//
//  Created by k-aoki on 2021/08/06.
//

import UIKit
import APIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    func request() {
        let request = RateLimitRequest()
        
        Session.send(request) { result in
            
            switch result {
                
            case .success(let rateLimit):
                print("limit: \(rateLimit.limit)")
                print("remaining: \(rateLimit.remaining)")
                
            case .failure(let error):
                switch error {
                case .connectionError(_): break
                case .requestError(_): break
                case .responseError(_): break
                }
                print("error: \(error)")
            }
        }
    }
}

