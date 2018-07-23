//
//  DrinkListViewController.swift
//  orderFood
//
//  Created by Anıl T. on 22.07.2018.
//  Copyright © 2018 anil. All rights reserved.
//

import UIKit

class DrinkListViewController: UIViewController {
    
    @IBOutlet weak var drinkCollectionsTableView: UITableView!
    
    @IBOutlet weak var drinkListTableView: UITableView!
    
    static let tableCellID: String = "tableViewCellID_section_#"

    let numberOfSections: Int = 20
    let numberOfCollectionsForRow: Int = 1
    let numberOfCollectionItems: Int = 7
    var heightForRowAt: CGFloat {
        return self.view.frame.height / 6
    }
    
    /// Set true to enable UICollectionViews scroll pagination
    var paginationEnabled: Bool = true
    
    var drinkList: DrinkList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "beerHall")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        drinkListTableView.register(UINib(nibName: "DrinkDetailsTableCell", bundle: nil), forCellReuseIdentifier: "drinkCell")
        
        drinkCollectionsTableView.dataSource = self
        drinkCollectionsTableView.delegate = self
        drinkCollectionsTableView.backgroundColor = .clear

        drinkListTableView.dataSource = self
        drinkListTableView.delegate = self
        drinkListTableView.backgroundColor = .clear
        drinkListTableView.setEditing(true, animated: true)
        
        drinkList = DrinkList(dictionary: barrelDrinks)
    }
 
    @IBAction func didPressButton(_ sender: AnyObject) {
    drinkListTableView.reloadData()
    drinkCollectionsTableView.reloadData()
    }
}

////////////////////////////////////////////////////////////////
//MARK:-
//MARK:TABLEVIEW DATA SOURCE
//MARK:-
////////////////////////////////////////////////////////////////

extension DrinkListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .insert
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == drinkListTableView {
            return "\(drinkList?.category.firstLine ?? "") \(drinkList?.category.secondLine ?? "")"
        }
        return ""
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == drinkListTableView {
            return 28
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == drinkCollectionsTableView {
            return 1
        }
        guard let count = drinkList?.drinks.count else { return 1 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Instead of having a single cellIdentifier for each type of
        // UITableViewCells, like in a regular implementation, we have multiple
        // cellIDs, each related to a indexPath section. By Doing so the
        // UITableViewCells will still be recycled but only with
        // dequeueReusableCell of that section.
        //
        // For example the cellIdentifier for section 4 cells will be:
        //
        // "tableViewCellID_section_#3"
        //
        // dequeueReusableCell will only reuse previous UITableViewCells with
        // the same cellIdentifier instead of using any UITableViewCell as a
        // regular UITableView would do, this is necessary because every cell
        // will have a different UICollectionView with UICollectionViewCells in
        // it and UITableView reuse won't work as expected giving back wrong
        // cells.
        if tableView == drinkCollectionsTableView {
            var cell: GLCollectionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: GLTableCollectionViewController.tableCellID + indexPath.section.description) as? GLCollectionTableViewCell
            
            if cell == nil {
                cell = GLCollectionTableViewCell(style: .default, reuseIdentifier: GLTableCollectionViewController.tableCellID + indexPath.section.description)
                
                // Configure the cell...
                cell!.selectionStyle = .none
                cell!.collectionViewPaginatedScroll = paginationEnabled
                
            }
            return cell!
        }
        
        
        var cell: DrinkDetailsTableCell = (tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as? DrinkDetailsTableCell)!
        
        
        guard let name = drinkList?.drinks[indexPath.row % (drinkList?.drinks.count)!].name else { return cell }
        
        cell.drinkName.text = name
        cell.drinkName.textColor = .white
        
        guard let price = drinkList?.drinks[indexPath.row % (drinkList?.drinks.count)!].price else { return cell }

        
        cell.drinkPrice.text = price
        cell.drinkPrice.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == drinkCollectionsTableView {
            return tableView.frame.height
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell: GLCollectionTableViewCell = cell as? GLCollectionTableViewCell else {
            return
        }
        if tableView == drinkCollectionsTableView {
            cell.setCollectionView(dataSource: self, delegate: self, indexPath: indexPath)
        }
    }
}

extension DrinkListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: GLIndexedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: GLIndexedCollectionViewCell.identifier, for: indexPath) as? GLIndexedCollectionViewCell else {
            fatalError("UICollectionViewCell must be of GLIndexedCollectionViewCell type")
        }
        
        
        cell.drinkImageView.image = UIImage(named: "\(categories[indexPath.row])")
        cell.drinkImageView.layer.cornerRadius = cell.frame.size.width / 2
        cell.drinkImageView.clipsToBounds = true
        
//        if let category = drinkList?.category {
//            cell.setDrinkNameLabel(name: category as! (String, String))
//        }
        cell.setDrinkNameLabel(name: categoryToName[categories[indexPath.row]]!)
        
        guard let indexedCollectionView: GLIndexedCollectionView = collectionView as? GLIndexedCollectionView else {
            fatalError("UICollectionView must be of GLIndexedCollectionView type")
        }
        
        // Configure the cell...
        //        cell.backgroundColor = colorsDict[indexedCollectionView.indexPath.section]?[indexPath.row]
        
        
        return cell
    }
}


////////////////////////////////////////////////////////////////
//MARK:-
//MARK: UI COLLECTION VIEW DELEGATE
//MARK:-
////////////////////////////////////////////////////////////////

extension DrinkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let allCategories = [barrelDrinks, bottleDrinks]
        drinkList = DrinkList(dictionary: allCategories[indexPath.row % 2])
        self.drinkListTableView.reloadData()
        NSLog("drinkList")
        collectionView.reloadData()
    }
}

extension DrinkListViewController: UICollectionViewDelegateFlowLayout {
    var collectionTopInset: CGFloat {
        return 0
    }
    var collectionBottomInset: CGFloat {
        return 0
    }
    var collectionLeftInset: CGFloat {
        return 5
    }
    var collectionRightInset: CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                return UIEdgeInsets(top: collectionTopInset, left: collectionLeftInset, bottom: collectionBottomInset, right: collectionRightInset)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tableViewCellHeight: CGFloat = self.heightForRowAt
        let collectionItemWidth: CGFloat = tableViewCellHeight - (collectionLeftInset + collectionRightInset)
        let collectionViewHeight: CGFloat = collectionItemWidth
        
        return CGSize(width: collectionItemWidth, height: collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
