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
    lazy var writingFormats : [String] = []
    lazy var writingpurposes : [String] = []
    
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
    
    func callGetAPI() {
        let pkWriting = 0
        // ?writing_id{pk:int}&?paragraph_id{pk:int}
        APIManger.shared.callGetRequest(baseEndPoint: .myWriting, addPath: "?writing_id\(pkWriting)") { JSON in
            let numOfWritings = JSON.count
            print(numOfWritings)
            
            do {
                // Convert JSON data to Swift objects
                if let jsonArray = try JSONSerialization.jsonObject(with: JSON.rawData(), options: []) as? [[String: String]] {
                    print(jsonArray)
                    // Now jsonArray is of type [[String: String]]
                    //Todo : 이대로 파싱 안됨. 내부에 paragraphs 정보가 있어버림
                    
                    let VC = CompleteVC()
                    //VC.format
                    //VC.purpose
                    //VC.paragraphs
                    VC.saveButton.isHidden = true
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            } catch {
                print("Error converting JSON to Swift objects: \(error)")
            }
        }
        
    }
    
    //Delete writing. 성공 여부로 view에서 삭제 동작 결정
    func callDeleteAPI() -> Bool {
        func callGetAPI() {
            let pkWriting = 0
            // ?writing_id{pk:int}
            APIManger.shared.callDeleteRequest(baseEndPoint: .myWriting, addPath: "?writing_id\(pkWriting)") { JSON,n  in
                let numOfWritings = JSON.count
                print(numOfWritings)
                
                do {
                    // Convert JSON data to Swift objects
                    if let jsonArray = try JSONSerialization.jsonObject(with: JSON.rawData(), options: []) as? [[String: String]] {
                        print(jsonArray)
                        // Now jsonArray is of type [[String: String]]
                        //Todo : 이대로 파싱 안됨. 내부에 paragraphs 정보가 있어버림
                        
                        let VC = BookmarkParagraphVC()
                        //Todo : paragraps를 어떻게 저장할 것인가.
    //                    VC.paragraphs = jsonArray
                        self.navigationController?.pushViewController(VC, animated: true)
                        
                    }
                } catch {
                    print("Error converting JSON to Swift objects: \(error)")
                }
            }
            
            let VC = CompleteVC()
            //VC.format
            //VC.purpose
            //VC.paragraphs
            VC.saveButton.isHidden = true
            navigationController?.pushViewController(VC, animated: true)
        }
        
        return true
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
        writingFormats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "writingHistoryCell", for: indexPath) as! WritingHistoryCell
        cell.delegate = self
        cell.writingNum = indexPath.item
        cell.formatLabel.text! = "Format : " + writingFormats[indexPath.item]
        cell.purposeLabel.text! = "Purpose : " + writingpurposes[indexPath.item]
        
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
        callGetAPI()
    }
    
    //for more option button
    func moreOptionTapped(cellNum: Int, selectedOption: String) {
        print(String(cellNum) + " " + selectedOption)
        switch selectedOption {
        case "글 보기":
            callGetAPI()
            break
        case "글 복사":
            print("copy")
            //Todo
            //copy?
        case "글 삭제":
            let alert = UIAlertController(title: "작성 내역을 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
                if self!.callDeleteAPI() {
                    self?.deleteWriting(at: cellNum)
                    
                    return
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
        writingFormats.remove(at: index)
        writingpurposes.remove(at: index)
        writingHistoryCollectionView.reloadData()
    }
}
