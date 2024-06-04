//
//  BookmarkParagraphVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 5/9/24.
//

import SnapKit
import UIKit

class BookmarkParagraphVC: UIViewController {
    //MARK: - Properties
    //will get from API
    lazy var paragraphs : [[String:Any]] = []
    
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //writing history title
    lazy var writingHistoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "북마크 단락 내역"
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
        
        let paragraph = paragraphs[cellNum]
        if let writing = paragraph["writing"] as? [String: Any],
           let pkParagraph = paragraph["pk"] as? Int,
           let pkWriting = writing["pk"] as? Int {
            APIManger.shared.callGetRequest(baseEndPoint: .myParagraph, addPath: "?writing_id=\(pkWriting)&paragraph_id=\(pkParagraph)") { JSON in
                
                let VC = CompleteVC()
                VC.paragraphs = [
                    ["pk": JSON["pk"].intValue,
                     "index": JSON["index"].stringValue,
                     "content": JSON["content"].stringValue,
                     "bookmark": JSON["bookmark"].boolValue]
                ]
                
                VC.pkWriting = JSON["writing"]["pk"].intValue
                VC.formatText = JSON["writing"]["format"].stringValue
                VC.purposeText = JSON["writing"]["purpose"].stringValue
                
                VC.completeTitle.text = "북마크 된 단락을 확인하세요"
                VC.toMainButton.setTitle("뒤로 가기", for: .normal)
                VC.toMainButton.removeTarget(VC, action: #selector(VC.toMainButtonTapped), for: .touchUpInside)
                VC.toMainButton.addTarget(VC, action: #selector(VC.backButtonTapped), for: .touchUpInside)
                
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
        else {
            self.showToast(message: "error", duration: 1, delay: 0.5)
        }
    }
    
    func callDeleteAPI() -> Bool {
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
extension BookmarkParagraphVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, moreOptionDelegate {
    //set collectionView
    func setCollectionView() {
        writingHistoryCollectionView.backgroundColor = .Nuflect.white
        writingHistoryCollectionView.dataSource = self
        writingHistoryCollectionView.delegate = self
        writingHistoryCollectionView.register(BookmarkParagraphCell.self, forCellWithReuseIdentifier: "bookmarkParagraphCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        paragraphs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookmarkParagraphCell", for: indexPath) as! BookmarkParagraphCell
        cell.delegate = self
        cell.bookmarkedParagraphNum = indexPath.item
        
        let paragraph = paragraphs[indexPath.item]
            if let writing = paragraph["writing"] as? [String: Any],
               let format = writing["format"] as? String,
               let purpose = writing["purpose"] as? String {
                cell.formatLabel.text = "Format : \(format)"
                cell.purposeLabel.text = "Purpose : \(purpose)"
            } else {
                cell.formatLabel.text = "Format : N/A"
                cell.purposeLabel.text = "Purpose : N/A"
            }

            cell.paragraphLabel.text = "Paragraph : \(paragraph["index"] as? String ?? "N/A")"
        
        return cell
        
    }
    
    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = CGFloat(135)
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
        case "단락 보기":
            print(cellNum)
            callGetAPI(cellNum: cellNum)
            break
        case "단락 복사":
            print("share")
            //Todo
            //copy?
        case "북마크 해제":
            let alert = UIAlertController(title: "북마크를 해제하시겠습니까?", message: nil, preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "해제", style: .destructive) { [weak self] _ in
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
        paragraphs.remove(at: index)
        writingHistoryCollectionView.reloadData()
    }
}
