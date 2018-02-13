//
//  QuotesViewController.swift
//  Pensamentos
//
//  Created by Guilherme Bury on 11/02/2018.
//  Copyright © 2018 Guilherme Bury. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {

    @IBOutlet weak var imageViewPicture: UIImageView!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelQuote: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    
    let config = Configuration.instance
    
    let quotesManager = QuotesManager()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil,
                                               queue: nil) { (notification) in self.formatView()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }

    func formatView() {
        view.backgroundColor = config.colorScheme == 0 ? .white : UIColor(red: 156.0/255.0, green: 68.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        labelQuote.textColor = config.colorScheme == 0 ? .black : .white
        labelAuthor.textColor = config.colorScheme == 0 ? UIColor(red: 192.0/255.0, green: 96.0/255.0, blue: 49.0/255.0, alpha: 1.0) : .yellow
        prepareQuote()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepareQuote()
    }
    
    //action to be repeated in x seconds
    func prepareQuote() {
        //invalidate before schedule
        timer?.invalidate()
        if config.autoRefresh {
            timer = Timer.scheduledTimer(withTimeInterval: config.timeInterval, repeats: true) { (timer) in
                //self 'cause is inside a closure
                self.showRandomQuote();
            }
            //See a quote now, not only after x seconds
        }
        showRandomQuote()
    }
    
    func showRandomQuote() {
        let quote = quotesManager.getRandomQuote()
        labelQuote.text = quote.quote
        labelAuthor.text = quote.author
        imageViewPicture.image = UIImage(named: quote.image)
        imageViewBackground.image = imageViewPicture.image
        
        //animation with transparence and move the text
        labelQuote.alpha = 0.0
        labelAuthor.alpha = 0.0
        imageViewPicture.alpha = 0.0
        imageViewBackground.alpha = 0.0
        constraintTop.constant = 50
        //elements position 'cause a constraint changed
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.5) {
            self.labelQuote.alpha = 1.0
            self.labelAuthor.alpha = 1.0
            self.imageViewPicture.alpha = 1.0
            self.imageViewBackground.alpha = 0.25
            self.constraintTop.constant = 10
            self.view.layoutIfNeeded()
        }
    }
}
