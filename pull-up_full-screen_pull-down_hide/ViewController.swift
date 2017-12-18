//
//  ViewController.swift
//  pull-up_full-screen_pull-down_hide
//
//  Created by 李懿哲 on 18/12/2017.
//  Copyright © 2017 Garken. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate {
    
    // MARK: -
    
    var contentView: UIView!
    var tableView: UITableView!
    
    let fixedTopSpace: Float = 100
    
    var topConstraint: Constraint? = nil
    
    var isFullScreen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add a show btn
        let showBtn = UIButton.init(type: .roundedRect)
        view.addSubview(showBtn)
        showBtn.setTitle("弹出来", for: .normal)
        showBtn.setTitleColor(UIColor.black, for: .normal)
        showBtn.addTarget(self, action: #selector(showTheView), for: .touchUpInside)
        showBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        /**
         initial showView
         */
        contentView = UIView.init()
        contentView.backgroundColor = UIColor.orange
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
        makeBotConstraintToZero()
        
        // add table view
        tableView = UITableView.init()
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func showTheView() {
        UIView.animate(withDuration: 0.3) {
            self.topConstraint?.deactivate()
            self.contentView.snp.makeConstraints { (make) in
                if #available(iOS 11, *) {
                    self.topConstraint = make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(self.fixedTopSpace).constraint
                } else {
                    self.topConstraint = make.top.equalToSuperview().offset(self.fixedTopSpace).constraint
                }
            }
            self.contentView.superview?.layoutIfNeeded()
        }
        
    }
    
    @objc func fullScreen() {
        self.isFullScreen = true
        UIView.animate(withDuration: 0.25) {
            self.topConstraint?.update(offset: 0)
            self.contentView.superview?.layoutIfNeeded()
            
        }
    }
    
    @objc func hideTheView() {
        isFullScreen = false
        UIView.animate(withDuration: 0.31) {
            self.topConstraint?.deactivate()
            self.makeBotConstraintToZero()
            self.contentView.superview?.layoutIfNeeded()
        }
    }
    
    func makeBotConstraintToZero() {
        contentView.snp.makeConstraints { (make) in
            topConstraint = make.top.equalTo(self.view.snp.bottom).constraint
        }
    }
    
    
    // MARK: - table view dataSource delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = String(indexPath.row)
        return cell!
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(velocity.y)
        if velocity.y > 0 {
            if !isFullScreen {
                print("进入全屏")
                fullScreen()
            }
        } else  {
            print(scrollView.contentOffset.y)
            if scrollView.contentOffset.y <= 0 {
                print("I will hide~")
                hideTheView()
            }
        }
    }
    

}

