//
//  MemoCell.swift
//  EverMemo
//
//  Created by  李俊 on 15/8/5.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

import UIKit

class MemoCell: UICollectionViewCell, UIGestureRecognizerDelegate {

  var deleteMemo: ((_ memo: Memo) -> ())?
  var memo: Memo? {
    didSet {
      contentLabel.text = memo!.text
      contentLabel.preferredMaxLayoutWidth = itemWidth - 2 * margin
    }
  }

  private let contentLabel: MemoLabel = {
    let label = MemoLabel()
    label.numberOfLines = 0
    label.preferredMaxLayoutWidth = itemWidth - 2 * margin
    label.font = UIFont.systemFont(ofSize: 15)
    label.verticalAlignment = .top
    label.sizeToFit()
    return label
  }()
  private var getsureRecognizer: UIGestureRecognizer?
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.white
    getsureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
    getsureRecognizer?.delegate = self
    contentView.addGestureRecognizer(getsureRecognizer!)
    setUI()

    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowOpacity = 0.2
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUI() {
    contentView.addSubview(contentLabel)
    contentLabel.translatesAutoresizingMaskIntoConstraints = false

    contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 5))
    contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 5))
    contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -5))
    contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -5))
  }

  @objc private func longPress() {
    // 添加一个判断,防止触发两次
    if let memo = memo, getsureRecognizer?.state == .began {
      deleteMemo?(memo)
    }
  }

  override func prepareForReuse() {
    deleteMemo = nil
  }
}
