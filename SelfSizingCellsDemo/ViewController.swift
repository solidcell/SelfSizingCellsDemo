//
//  ViewController.swift
//  SelfSizingCellsDemo
//
//  Created by Alexis Gallagher on 2014-08-13.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import UIKit

let notTooManyItems = "The UICollectionViewFlowLayout class is a concrete layout object that organizes items into a grid with optional header and footer views for each section. The items in the collection view flow from one row or column (depending on the scrolling direction) to the next, with each row comprising as many cells as will fit. Cells can be the same sizes or different sizes. A flow layout works with the collection view’s delegate object to determine the size of items, headers, and footers in each section and grid. That delegate object must conform to the UICollectionViewDelegateFlowLayout protocol. Use of the delegate allows you to adjust layout information dynamically. For example, you would need to use a delegate object to specify different sizes for items in the grid. If you do not provide a delegate, the flow layout uses the default values you set using the properties of this class. Flow layouts lay out their content using a fixed distance in one direction and a scrollable distance in the The UICollectionViewFlowLayout class is a concrete layout object that organizes items into a grid with optional header and footer views for each section. The items in the collection view flow from one row or column (depending on the scrolling direction) to the next, with each row comprising as many cells as will fit. Cells can be the same sizes or different sizes. A flow layout works with the collection view’s delegate object to determine the size of items, headers, and footers in each section and grid. That delegate object must conform to the UICollectionViewDelegateFlowLayout protocol. Use of the delegate allows you to adjust layout information dynamically. For example, you would need to use a delegate object to specify different sizes for items in the grid. If you do not provide a delegate, the flow layout uses the default values you set using the properties of this class. Flow layouts lay out their content using a fixed distance in one direction and a scrollable distance in the The UICollectionViewFlowLayout class is a concrete layout object that organizes items into a grid with optional header and footer views for each section. The items in the collection view flow from one row or column (depending on the scrolling direction) to the next, with each row comprising as many cells as will fit. Cells can be the same sizes or different sizes. A flow layout works with the collection view’s delegate object to determine the size of items, headers, and footers in each section and grid. That delegate object must conform to the UICollectionViewDelegateFlowLayout protocol. Use of the delegate allows you to adjust layout information dynamically. For example, you would need to use a delegate object to specify different sizes for items in the grid. If you do not provide a delegate, the flow layout uses the default values you set using the properties of this class. Flow layouts lay out their content using a fixed distance in one direction and a scrollable distance in the"

let useTooManyItems = true

let originalString = useTooManyItems ? tooManyItems : notTooManyItems
let items = originalString.components(separatedBy: " ")

// tooManyItems => 103987, 61.152007 seconds
// notTooManyItems => 498 items, 0.239882 seconds to show visible
// 255x slower...

class ViewController: UICollectionViewController {
  
  override var prefersStatusBarHidden : Bool { return true; }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    print(items.count)

    // register the cell type
    self.collectionView!.register(LabelHoldingCell.self, forCellWithReuseIdentifier: LabelHoldingCell.classReuseIdentifier)
    
    // tell the collection view layout object to let the cells self-size
    let flowLayout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout

    flowLayout.estimatedItemSize = CGSize(width: 30, height: 21)
  }

  // MARK: <UICollectionViewDatasource>

  override func collectionView(_ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelHoldingCell.classReuseIdentifier, for: indexPath) as! LabelHoldingCell
    cell.setText(items[(indexPath as NSIndexPath).row])
    print(NSDate.timeIntervalSinceReferenceDate)
    return cell
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1;
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count;
  }
}
