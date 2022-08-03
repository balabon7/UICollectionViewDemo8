//
//  BaseCollectionViewController.swift
//  UICollectionViewDemo
//
//  Created by alenpaulkevin on 2017/6/20.
//  Copyright © 2017年 alenpaulkevin. All rights reserved.
//

import UIKit

private let baseCellID = "baseCellID"
private let baseReuseHeaderID = "baseReuseHeaderID"
private let baseReuseFooterID = "baseReuseFooterID"

class BaseCollectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "основное использование"
        setUpView()
    }
    
    private func setUpView() {
        // 创建flowLayout对象
    let layout = UICollectionViewFlowLayout()
    let margin: CGFloat = 8
    let itemW = (view.bounds.width - margin * 4) / 3
    let itemH = itemW
    layout.itemSize = CGSize(width: itemW, height: itemH)
    
    // 最小行间距
    layout.minimumLineSpacing = margin
    
    // 最小item之间的距离
    layout.minimumInteritemSpacing = margin
    
    // 每组item的边缘切距
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
    
    // 滚动方向
    layout.scrollDirection = .vertical
    
    // 创建collection
    let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    // 注册cell
    collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: baseCellID)
    
    // Зарегистрируйте представления head и tail, они должны наследоваться от UICollectionReuseView.
        collectionView.register(UINib(nibName: "BaseHeaderAndFooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: baseReuseHeaderID)
        collectionView.register(UINib(nibName: "BaseHeaderAndFooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: baseReuseFooterID)
        
        view.addSubview(collectionView)
    }
}

extension BaseCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 + section * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: baseCellID, for: indexPath) as! BaseCollectionViewCell
        cell.cellIndex = indexPath.item
        return cell
    }
    
    // протокол источника данных заголовка и хвоста
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: baseReuseHeaderID, for: indexPath) as! BaseHeaderAndFooterCollectionReusableView
            header.backgroundColor = .purple
            header.textLabel.text = "Нет. \(indexPath.section) руководитель группы"
            return header
        }
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: baseReuseFooterID, for: indexPath) as! BaseHeaderAndFooterCollectionReusableView
        footer.textLabel.text = "Нет. \(indexPath.section) хвост группы"
        footer.backgroundColor = .lightGray
        return footer
    }
}

extension BaseCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("выбран\(indexPath.section)группа\(indexPath.item) индивидуальный");
    }
    
    //  Реализуйте следующие три метода, долгое нажатие откроет меню редактирования.
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
    }
}

// MARK: - flowLayout协议
extension BaseCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // Размер и ширина шапки раздела не будут затронуты, если она фиксированная, то лучше задать ее напрямую, а не использовать метод прокси.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: CGFloat(36 + 10 * section))
    }
    
    // На размер и ширину нижнего колонтитула раздела это не повлияет, если он фиксированный, то лучше задать его напрямую, а не использовать метод прокси.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: CGFloat(36 + 10 * section))
    }
}
