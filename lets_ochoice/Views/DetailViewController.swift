//
//  DetailViewController.swift
//  lets_ochoice
//
//  Created by homechoic on 1/25/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let id: Int

        init(id: Int) {
            self.id = id
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        
        print("Received ID: \(id)")
        fetchDetailData(for: id)
    }
    
    private func fetchDetailData(for id: Int) {
            // id를 기반으로 API 호출 또는 데이터 로드
            print("Fetching data for id: \(id)")
        }
}
