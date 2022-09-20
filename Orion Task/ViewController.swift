//
//  ViewController.swift
//  Orion Task
//
//  Created by Yamoses on 15/09/2022.
//

import UIKit
import WebKit

enum Store {
    static let fullPath = "fullPath"
}

class ViewController: UIViewController {

    @IBOutlet weak var viewA: UIView!
    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var webView: WKWebView!
    var progressView: UIProgressView!
    
    var webviewIsLoaded = false
    let isAllowZoom: Bool = false

    @IBOutlet weak var startWebPageBtn: UIButton!
    private var activityIndicatorContainer: UIView!
        
    fileprivate let urlString = "https://www.apple.com"
    fileprivate let urlFromHistory = UserDefaults.standard.object(forKey: Store.fullPath) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.bounces = false
        webView.allowsBackForwardNavigationGestures = true
        webView.contentMode = .scaleToFill
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new , context: nil)
        webView.scrollView.delegate = self
        checkHistory()
    }
    
    @objc func backAction() -> Void {
        webviewIsLoaded = false
        hideWebview()
        resetDefaults()
    }
    
    func checkHistory() {
        if UserDefaults.standard.object(forKey: Store.fullPath) != nil {
            showWebview()
            goToSite(siteUrl: urlFromHistory ?? "")

        } else {
            hideWebview()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func resetDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
               UserDefaults.standard.removePersistentDomain(forName: appDomain)
           }
    }
        
    @objc private func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @objc private func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    fileprivate func setupUI(hideOrShow: Bool) {
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "BackButton.png"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(UIColor.red, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: nil, action: #selector(goBack))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let forward = UIBarButtonItem(image: UIImage(named: "forward"), style: .plain, target: nil, action: #selector(goForward))
            
        toolbarItems = [back, spacer, progressButton, spacer ,forward]
            
        backbutton.isHidden = hideOrShow
        self.navigationController?.isToolbarHidden = hideOrShow
        self.navigationController?.setNavigationBarHidden(hideOrShow, animated: true)
    }
        
    func showWebview() {
        startWebPageBtn.isHidden = true
        self.view.sendSubviewToBack(viewA)
        self.view.bringSubviewToFront(viewB)
        setupUI(hideOrShow: false)
    }
    
    func hideWebview() {
        startWebPageBtn.isHidden = false
        self.view.sendSubviewToBack(viewB)
        self.view.bringSubviewToFront(viewA)
        setupUI(hideOrShow: true)
    }
    
    func goToSite(siteUrl: String) {
        let url = URL(string: siteUrl )!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @IBAction func starWebPageBtnPressed(_ sender: UIButton) {
        showWebview()
        if webviewIsLoaded {
            self.view.bringSubviewToFront(viewB)
        } else {
            goToSite(siteUrl: urlString)
        }
    }
}

extension ViewController: WKNavigationDelegate, UIScrollViewDelegate {
        
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        webviewIsLoaded = true
        let urlString = webView.url?.absoluteString
        print("MY WEBVIEW URL: \(String(describing: urlString))")
        UserDefaults.standard.setValue(urlString, forKey: Store.fullPath)
    }
        
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.reload()
    }
        
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
}

