//
//  WritingHistoryVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 5/9/24.
//

import SnapKit
import UIKit

class WritingHistoryVC: UIViewController {
    //MARK: - Properties
    //will get from API
    lazy var writings : [[String:Any]] = []
    
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //writing history title
    lazy var writingHistoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "글 작성 내역"
        label.numberOfLines = 1
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //writing history collectionView
    lazy var writingHistoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    //MARK: - Define Method
    @objc func backButtonTapped() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    func callGetAPI(cellNum: Int) {
        let pkWriting = writings[cellNum]["pk"] as? Int ?? 0
        APIManger.shared.callGetRequest(baseEndPoint: .myWriting, addPath: "?writing_id=\(pkWriting)") { JSON in
            do {
                // Convert JSON data to Swift objects
                if let jsonArray = try JSONSerialization.jsonObject(with: JSON["paragraphs"].rawData(), options: []) as? [[String: Any]] {
                    print(jsonArray)
                    // Now jsonArray is of type [[String: String]]
                    
                    let VC = CompleteVC()
                    VC.pkWriting = JSON["pk"].intValue
                    VC.formatText = JSON["format"].stringValue
                    VC.purposeText = JSON["purpose"].stringValue
                    VC.paragraphs = jsonArray
                    
                    VC.toMainButton.setTitle("뒤로 가기", for: .normal)
                    VC.toMainButton.removeTarget(VC, action: #selector(VC.toMainButtonTapped), for: .touchUpInside)
                    VC.toMainButton.addTarget(VC, action: #selector(VC.backButtonTapped), for: .touchUpInside)
                    
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            } catch {
                print("Error converting JSON to Swift objects: \(error)")
            }
        }
        
    }
    
    //Delete writing. 성공 여부로 view에서 삭제 동작 결정
    func callDeleteAPI(cellNum: Int, completion: @escaping (Bool) -> Void) {
        guard let pkWriting = writings[cellNum]["pk"] as? Int else {
            completion(false)
            return
        }

        APIManger.shared.callDeleteRequest(baseEndPoint: .myWriting, addPath: "?writing_id=\(pkWriting)") { statusCode in
            guard statusCode == 200 || statusCode == 202
            else {
                completion(false)
                return
            }
            completion(true)
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    //MARK: - Set Ui
    func setView() {
        setNavigationBar()
        addSubView()
        setCollectionView()
        self.view.backgroundColor = UIColor.Nuflect.white
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        
        //back (left)
        let back = UIImage(systemName: "chevron.backward")
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 20), false, 0.0)
        back?.draw(in: CGRect(x: 0, y: 0, width: 20, height: 20))
        let resizedBack = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let backImage = resizedBack?.withRenderingMode(.alwaysOriginal)

        let leftButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))

        navigationItem.leftBarButtonItem = leftButton
        
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Nuflect.white // 배경색 변경
        navigationBar.tintColor = .clear
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }
    
    func addSubView() {
        [navigationBar, writingHistoryTitleLabel, writingHistoryCollectionView].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 35
        let top = 20
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        writingHistoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        writingHistoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(writingHistoryTitleLabel.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-top)
        }
    }
}

//set collectionView and delegates
extension WritingHistoryVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, moreOptionDelegate {
    //set collectionView
    func setCollectionView() {
        writingHistoryCollectionView.backgroundColor = .Nuflect.white
        writingHistoryCollectionView.dataSource = self
        writingHistoryCollectionView.delegate = self
        writingHistoryCollectionView.register(WritingHistoryCell.self, forCellWithReuseIdentifier: "writingHistoryCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        writings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "writingHistoryCell", for: indexPath) as! WritingHistoryCell
        cell.delegate = self
        cell.writingNum = indexPath.item
        cell.formatLabel.text! = "Format : " + (writings[indexPath.item]["format"] as? String ?? "")
        cell.purposeLabel.text! = "Purpose : " + (writings[indexPath.item]["purpose"] as? String ?? "")
        
        return cell
        
    }
    
    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = CGFloat(100)
        return CGSize(width: width, height: height)
    }
    
    
    
    //cell touch action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        callGetAPI(cellNum: indexPath.item)
    }
    
    //for more option button
    func moreOptionTapped(cellNum: Int, selectedOption: String) {
        print(String(cellNum) + " " + selectedOption)
        switch selectedOption {
        case "글 보기":
            callGetAPI(cellNum: cellNum)
            break
        case "글 복사":
            print("copy")
            self.showToast(message: "미구현", duration: 1, delay: 0.5)
            //copy?
        case "글 삭제":
            let alert = UIAlertController(title: "작성 내역을 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
                self?.callDeleteAPI(cellNum: cellNum) { success in
                    if success {
                        self!.deleteWriting(at: cellNum)
                        self!.showToast(message: "삭제 완료", duration: 1, delay: 0.5)
                    } else {
                        self!.showToast(message: "error", duration: 1, delay: 0.5)
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
            
        default:
            print("error")
        }
    }
    
    // Function to delete a writing
    func deleteWriting(at index: Int) {
        writings.remove(at: index)
        writingHistoryCollectionView.reloadData()
    }
}
