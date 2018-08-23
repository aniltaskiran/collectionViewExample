//
//  GLTableCollectionViewController.swift
//  GLTableCollectionView
//
//  Created by Giulio Lombardo on 24/11/16.
//

import UIKit

final class GLTableCollectionViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    static let tableCellID: String = "tableViewCellID_section_#"

    let numberOfSections: Int = 20
    let numberOfCollectionsForRow: Int = 1
    let numberOfCollectionItems: Int = 7
    var heightForRowAt: CGFloat {
        return self.view.frame.height / 6
    }

    var colorsDict: [Int: [UIColor]] = [:]

    /// Set true to enable UICollectionViews scroll pagination
    var paginationEnabled: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DrinkDetailsTableCell", bundle: nil), forCellReuseIdentifier: "drinkCell")

        // Uncomment the following line to preserve selection between
        // presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the
        // navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        (0 ... numberOfSections - 1).forEach { section in
            colorsDict[section] = randomRowColors()
        }
    }

    private final func randomRowColors() -> [UIColor] {
        let colors: [UIColor] = (0 ... numberOfCollectionItems - 1).map({ _ -> UIColor in
            var randomRed: CGFloat = CGFloat(arc4random_uniform(256))
            let randomGreen: CGFloat = CGFloat(arc4random_uniform(256))
            let randomBlue: CGFloat = CGFloat(arc4random_uniform(256))

            if randomRed == 255.0 && randomGreen == 255.0 && randomBlue == 255.0 {
                randomRed = CGFloat(arc4random_uniform(128))
            }

            let color: UIColor

            if #available(iOS 10.0, *) {
                if traitCollection.displayGamut == .P3 {
                    color = UIColor(displayP3Red: randomRed / 255.0, green: randomGreen / 255.0, blue: randomBlue / 255.0, alpha: 1.0)
                } else {
                    color = UIColor(red: randomRed / 255.0, green: randomGreen / 255.0, blue: randomBlue / 255.0, alpha: 1.0)
                }
            } else {
                color = UIColor(red: randomRed / 255.0, green: randomGreen / 255.0, blue: randomBlue / 255.0, alpha: 1.0)
            }

            return color
        })

        return colors
    }

    // MARK: <UITableView Data Source>

    override func numberOfSections(in _: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return numberOfCollectionsForRow
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        if indexPath.section == 0 {
            var cell: GLCollectionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: GLTableCollectionViewController.tableCellID + indexPath.section.description) as? GLCollectionTableViewCell

            if cell == nil {
                cell = GLCollectionTableViewCell(style: .default, reuseIdentifier: GLTableCollectionViewController.tableCellID + indexPath.section.description)

                // Configure the cell...
                cell!.selectionStyle = .none
                cell!.collectionViewPaginatedScroll = paginationEnabled

            }
            return cell!
        }

        let cell: DrinkDetailsTableCell = (tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as? DrinkDetailsTableCell)!
        cell.drinkName.text = "anil"
        cell.drinkName.textColor = .white

        cell.drinkPrice.text = "23.03₺"
        cell.drinkPrice.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section: " + section.description
    }

    // MARK: <UITableView Delegate>

    override func tableView(_: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat {
        if indexpath.section == 0 {
            return self.heightForRowAt
        }
        return 40
    }

    override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 0
    }

    override func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return 0
    }

    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell: GLCollectionTableViewCell = cell as? GLCollectionTableViewCell else {
            return
        }
        if indexPath.row == 0 {
            cell.setCollectionView(dataSource: self, delegate: self, indexPath: indexPath)
        }
    }

    // MARK: <UICollectionView Data Source>

    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return numberOfCollectionItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: GLIndexedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: GLIndexedCollectionViewCell.identifier, for: indexPath) as? GLIndexedCollectionViewCell else {
            fatalError("UICollectionViewCell must be of GLIndexedCollectionViewCell type")
        }

        cell.drinkImageView.image = UIImage(named: "\(indexPath.row % 7)")

        guard let _ : GLIndexedCollectionView = collectionView as? GLIndexedCollectionView else {
            fatalError("UICollectionView must be of GLIndexedCollectionView type")
        }

        // Configure the cell...
//        cell.backgroundColor = colorsDict[indexedCollectionView.indexPath.section]?[indexPath.row]

        cell.layer.cornerRadius = cell.frame.size.width / 2
        cell.clipsToBounds = true

        return cell
    }

    // MARK: <UICollectionViewDelegate Flow Layout>

    let collectionTopInset: CGFloat = 0
    let collectionBottomInset: CGFloat = 0
    let collectionLeftInset: CGFloat = 10
    let collectionRightInset: CGFloat = 10

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionTopInset, left: collectionLeftInset, bottom: collectionBottomInset, right: collectionRightInset)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let tableViewCellHeight: CGFloat = self.heightForRowAt
        let collectionItemWidth: CGFloat = tableViewCellHeight - (collectionLeftInset + collectionRightInset)
        let collectionViewHeight: CGFloat = collectionItemWidth

        return CGSize(width: collectionItemWidth, height: collectionViewHeight)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }

    // MARK: <UICollectionView Delegate>

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    /*
     // MARK: <Navigation>

     // In a storyboard-based application, you will often want to do a little
     // preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
