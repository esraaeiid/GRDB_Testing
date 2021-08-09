//
//  FriendViewController.swift
//  Coordinators_HWS
//
//  Created by Esraa Eid on 12/02/2021.
//

import UIKit
import Photos
import PhotosUI


class FriendViewController: UIViewController, Storyboarded{
    
    enum cellType {
           case addButton
           case photo(photo: Data?)
       }
    
    weak var coordinator: MainCoordinator?
    var friend: Friend!
    
    var timeZones = [TimeZone]()
    var selectedTimeZone = 0
    var collectionDataSource: [cellType] = [.addButton]
    var configuration = PHPickerConfiguration()
    var selectedImages: [UIImage] = []
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var friendTextView: UITextView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        friendTextView.delegate = self
        setupDateLabel()
        setupCollectionViewFlowLayout()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.friendTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.update(friend: friend)
    }
    
    
    func setupDateLabel(){
        dateFormatter.timeZone = friend.timeZone
        dateFormatter.timeStyle = .short
        dateLabel.text = dateFormatter.string(from: Date())
        friendTextView.text = friend.name
    }
    
    func setupCollectionViewFlowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInsetReference = .fromContentInset
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0)
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.scrollDirection = .horizontal
        imagesCollectionView.collectionViewLayout = flowLayout
        imagesCollectionView.contentInsetAdjustmentBehavior = .always
        imagesCollectionView.isScrollEnabled = true
        imagesCollectionView.showsVerticalScrollIndicator = false
        imagesCollectionView.showsHorizontalScrollIndicator = false
        imagesCollectionView.allowsSelection = true
        imagesCollectionView.bounces = true
        imagesCollectionView.allowsMultipleSelection = false
        
    }
       
    
    
    // MARK: - setup collectionView
    
    func setupCollectionView() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.cellID)
        imagesCollectionView.register(TapImageCollectionViewCell.self, forCellWithReuseIdentifier: TapImageCollectionViewCell.cellID)
    }
    
    
    
 
        
    
    @objc func onTapImageView(){
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }

    
    
    
}


//MARK:- UICollectionViewDelegate

extension FriendViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //size For ItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: 70, height: 70)
    }
    

}

//MARK:- UICollectionViewDataSource

extension FriendViewController: UICollectionViewDataSource {

    //numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDataSource.count
    }
    
    
    //cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = collectionDataSource[indexPath.row]
        switch cellType {
        
        case .addButton:
            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TapImageCollectionViewCell.cellID, for: indexPath) as? TapImageCollectionViewCell else {
                assertionFailure("Couldn't find TapImageCollectionViewCell!")
                return  UICollectionViewCell()
            }
    
            cell.selectImageButton.addTarget(self, action: #selector(onTapImageView), for: .touchUpInside)
            
            return cell
        case .photo(photo: let photo):
            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.cellID, for: indexPath) as? ImageCollectionViewCell else {
                assertionFailure("Couldn't find ImageCollectionViewCell!")
                return  UICollectionViewCell()
                
            }
            let imagesOfConatctSupport = photo
            cell.index = indexPath.row
            cell.delegate = self
            cell.issueImageView.image = UIImage(data: imagesOfConatctSupport ?? Data())
            return cell
        }
        
    }
    
}


extension FriendViewController: PHPickerViewControllerDelegate{
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self)
            { [weak self]  image, error in
                DispatchQueue.main.async {
                  guard let self = self else { return }
                  if let image = image as? UIImage {
                    let dateFromImage = image.jpegData(compressionQuality: 1) ?? Data()
                    self.collectionDataSource.append(.photo(photo: dateFromImage))
                    }
                }
            }
        }
        picker.dismiss(animated: true) {
            self.imagesCollectionView.reloadData()
        }
    }
    

    
}


extension FriendViewController: UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if   friendTextView.isFirstResponder {
            friendTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        // adding a place holder for the textView is empty
        if  friendTextView.text.isEmpty ||
                friendTextView.text == "" ||
                friendTextView.text.trimmingCharacters(in: .whitespaces).isEmpty {
            friendTextView.textColor = .black
            friendTextView.text = "Name your friends……"
        }
     
    }

    /*Enable send Button on Navigation bar when there's text in text view
     and Disable when text view is empty.*/
    func textViewDidChange(_ textView: UITextView) {
        friend.name = textView.text
    }
    
    
}




extension FriendViewController: ImageCollectionViewCellDelegate{
    
    func deleteImageTapped(row: Int) {
        print("delete photo")
    }

}
