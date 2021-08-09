//
//  TapImageCollectionViewCell.swift
//  Coordinators_HWS
//
//  Created by Esraa Eid on 09/08/2021.
//

import UIKit

class TapImageCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "TapImageCollectionViewCell"
  
    let selectImageButton: UIButton = {
        var button = UIButton(type: .system)
        let galleryImage = UIImage(systemName: "camera")
        button.setImage(galleryImage, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    

    

   // MARK: - setup views properties

    func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(selectImageButton)
   
        
        selectImageButton.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor,
                          bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    
    


    // MARK: - Initializer

       override init(frame: CGRect) {
           super.init(frame: frame)
        setupViews()
       }

       required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
       }

       override func layoutSubviews() {
        super.layoutSubviews()
       }

}
