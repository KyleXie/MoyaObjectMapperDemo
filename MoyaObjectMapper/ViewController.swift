//
//  ViewController.swift
//  MoyaObjectMapper
//
//  Created by Kyle Xie on 3/7/16.
//  Copyright © 2016 DecentFox Studio. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {
    @IBOutlet weak var getUserBtn: UIButton!
    @IBOutlet weak var getUsersBtn: UIButton!

    @IBOutlet weak var resultTextView: UITextView!

    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let userName = self.viewModel.user.producer
            .filter { $0?.username != nil }
            .map { "单个用户:\($0!.username!)" }
        let userNames = self.viewModel.users.producer
            .filter { $0.count > 0 }
            .map({ (users) -> String? in
                let names = users.flatMap({(user) -> String? in
                    return user.username
                })
                return names.reduce("", combine: {(names, name) -> String in
                    return "\(names)\n\(name)"
                })
            })
            .filter { $0 != nil }
            .map { "多个用户：\n \($0!)" }

        let (signal, observer) = SignalProducer<SignalProducer<String, NoError>, NoError>.buffer(5)
        signal.flatten(.Merge).startWithNext { next in self.resultTextView.text = next }
        observer.sendNext(userName)
        observer.sendNext(userNames)
        observer.sendCompleted()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onGetUser(sender: AnyObject) {
        viewModel.getUser("User1").start()
    }

    @IBAction func onGetUsers(sender: AnyObject) {
        viewModel.getUsers(5).start()
    }
}

