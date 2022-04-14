//
//  ViewController.swift
//  UIScrollView-StickyHeader
//
//  Created by Seunghun Yang on 2022/04/12.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        return imageView
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()
    
    private let headerPlaceholderView: UIView = UIView()
    
    private let someView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let someOtherView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()
    
    private var isHeaderPinned: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(view)
        }
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        contentView.addSubview(headerPlaceholderView)
        headerPlaceholderView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        contentView.addSubview(someView)
        someView.snp.makeConstraints { make in
            make.top.equalTo(headerPlaceholderView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1200)
        }
        
        contentView.addSubview(someOtherView)
        someOtherView.snp.makeConstraints { make in
            make.top.equalTo(someView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1200)
            make.bottom.equalToSuperview()
        }
    }
    
    private func pinHeader() {
        headerView.removeFromSuperview()
        view.addSubview(headerView)
        headerView.snp.remakeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        isHeaderPinned = true
    }
    
    private func unpinHeader() {
        headerView.removeFromSuperview()
        contentView.addSubview(headerView)
        headerView.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        isHeaderPinned = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold = imageView.frame.height - view.safeAreaInsets.top
        
        if scrollView.contentOffset.y > threshold && !isHeaderPinned {
            pinHeader()
        } else if scrollView.contentOffset.y <= threshold && isHeaderPinned {
            unpinHeader()
        }
    }
}
