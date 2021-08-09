//
//  TextCollectionViewCell.swift
//  Coordinators_HWS
//
//  Created by Esraa Eid on 09/08/2021.
//

import UIKit

protocol ImageCollectionViewCellDelegate: AnyObject {
    func deleteImageTapped(row: Int)
}


class ImageCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "ImageCollectionViewCell"
    //MARK:- Instances
      var index: Int = 0
      weak var delegate: ImageCollectionViewCellDelegate?
      
      // MARK: - Properties
      var issueImageView: UIImageView = {
          var imageView = UIImageView()
          imageView.contentMode = .scaleAspectFill
        return imageView
      }()
      
      let deleteImageButton: UIButton = {
          let button = UIButton(type: .system)
          button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
          button.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
          button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
          button.backgroundColor = .white
          button.layer.masksToBounds = true
          button.layer.cornerRadius = button.frame.height / 2
          button.clipsToBounds = true
          button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
          return button
      }()
      
      // MARK: - setup views properties
      
      func setupViews() {
          contentView.backgroundColor = .white
          contentView.addSubview(issueImageView)
          contentView.addSubview(deleteImageButton)
          
          issueImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor,
                            bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 0))
          
          deleteImageButton.anchor(top: issueImageView.topAnchor, leading: nil,
                            bottom: nil, trailing: issueImageView.trailingAnchor,
                            padding: .init(top: 4, left: 0, bottom: 0, right: 4))
          deleteImageButton.constrainWidth(constant: 16)
          deleteImageButton.constrainHeight(constant: 16)
      }
      
    
      
      
  //MARK:- Objc functions
      
      @objc func deleteImageButtonTapped(_ sender: UIButton) {
          delegate?.deleteImageTapped(row: index)
      }
      

      func viewActions(){
          deleteImageButton.addTarget(self, action: #selector(deleteImageButtonTapped(_:)), for: .touchUpInside)
      }

      
      // MARK: - Initializer
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          setupViews()
          viewActions()
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
      }
      
      override func layoutSubviews() {
          super.layoutSubviews()
      }
}
