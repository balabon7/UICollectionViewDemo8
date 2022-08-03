//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by alenpaulkevin on 2017/6/19.
//  Copyright © 2017年 alenpaulkevin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let data: [[String: Any]] = [
        ["text": "основное использование", "class": "BaseCollectionViewController"],
        ["text": "Водопады текут", "class": "WaterFlowViewController"],
        ["text": "Горизонтальная прокрутка с несколькими ячейками на странице", "class": "HorizontalCollectionViewController"],
        ["text": "CoverFlow Эффект", "class": "CoverFlowViewController"],
        ["text": "Карусель", "class": "CircularCollectionViewController"],
        ["text": "Имитация Toutiao для достижения перестройки клеток", "class": "MoveCollectionViewController"],
        ["text": "iOS9-Реализация перестановки ячеек с системными свойствами", "class": "InteractiveMoveViewController"],
        ["text": "iOS10-Предварительная загрузка", "class": "PrefecthingCollectionViewController"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    /// строка файла класса, преобразованная в ViewController
    ///
    /// - Parameter childControllerName: VC的字符串
    /// - Returns: ViewController
    func convertController(_ childControllerName: String) -> UIViewController? {
        
        // 1.получить пространство имен
        // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的值的类型为AnyObject?
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            return nil
        }
        // 2.Преобразование в класс по пространству имен и имени класса
        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)
        
        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
        guard let clsType = cls as? UIViewController.Type else {
            return nil
        }
        
        if clsType is UICollectionViewController.Type {
            let coll = clsType as! UICollectionViewController.Type
            let collCls = coll.init(collectionViewLayout: CircularCollectionViewLayout())
            return collCls
        }
        
        // 3.通过Class创建对象
        let childController = clsType.init()
        
        return childController
    }
}

// MARK: - действующий
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]["text"] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let className = data[indexPath.row]["class"] as! String
        let cls = convertController(className)!
        navigationController?.pushViewController(cls, animated: true)
    }
}

