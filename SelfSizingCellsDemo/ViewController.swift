//
//  ViewController.swift
//  SelfSizingCellsDemo
//
//  Created by Alexis Gallagher on 2014-08-13.
//  Copyright (c) 2014 AlexisGallagher. All rights reserved.
//

import UIKit


/*
INSTRUCTIONS: build and run on an iPhone 5s-sized screen.

The flag below toggle the estimatedItemSize height between 20 and 21.

For 20 and below, the collection view does not display its last element.

For above 20, the collection view does display its last element.

So the estimatedItemSize, which is supposed to serve only as a perf
optimization, is determining whether the collection works or does not
work at its basic function of displaying items.


*/
let useMagicallyBrokenHeight:Bool = true


/*
NOTE TO APPLE (1/2): 

This line of text is split into words. Each word goes in its own label. Each cell contains one label.

The cells correctly self-size based on the size of the label, using iOS8's support for self-sizing collection view cells.

This is exactly as per Olivier Gutknecht's demonstration app in WWDC 2014, session 226, What's New in
Table and Collection Views.
*/
let smallitems = "The UICollectionViewFlowLayout class is a concrete layout object that organizes items into a grid with optional header and footer views for each section. The items in the collection view flow from one row or column (depending on the scrolling direction) to the next, with each row comprising as many cells as will fit. Cells can be the same sizes or different sizes. A flow layout works with the collection view’s delegate object to determine the size of items, headers, and footers in each section and grid. That delegate object must conform to the UICollectionViewDelegateFlowLayout protocol. Use of the delegate allows you to adjust layout information dynamically. For example, you would need to use a delegate object to specify different sizes for items in the grid. If you do not provide a delegate, the flow layout uses the default values you set using the properties of this class. Flow layouts lay out their content using a fixed distance in one direction and a scrollable distance in the other. For example, in a vertically scrolling grid, the width of the grid content is constrained to the width of the corresponding collection view while the height of the content adjusts dynamically to match the number of sections and items in the grid. The layout is configured to scroll vertically by default but you can configure the scrolling direction using the scrollDirection property. Each section in a flow layout can have its own custom header and footer. To configure the header or footer for a view, you must configure the size of the header or footer to be non zero. You can do this by implementing the appropriate delegate methods or by assigning appropriate values to the headerReferenceSize and footerReferenceSize properties. If the header or footer size is 0, the corresponding view is not added to the collection view."


/*
NOTE TO APPLE (1/2): 

This long item contains a long string of text that needs to be word-wrapped to fit into
a label with an iPhone screen width of 320. As a result of wrapping onto multiple lines, this 
item produce a self-sizing cell that is taller than the other cells.

This item will be the last in the collection.

THE PROBLEM AS OF iOS 8.0: although UICollectionView correctly self-sizes the cells based on the
size of the required labels, it does not seem correctly to calculate the collectionViewContentSize 
based on the cell sizies. This last item in the collection does not display within the
scrollable region, but is visible if you manually scroll to see outside the bounds of the
scrollable region.

THE PROBLEM AS OF iOS 8.3: in iOS 8.3, UICollectionView seems to no longer be displaying the
last item at all. So now the UICollectionView's calculation of the contentSize is consistent 
with its rendering of the cells, in that they are both incorrect in the same way -- they 
ignore the item.

*/
let onelongitem="I am a long string containing spaces to see if text wraps within a label properly or if instead it produces undesired artefacts."

let items = smallitems.components(separatedBy: " ") + [onelongitem]

class ViewController: UICollectionViewController {
  
  override var prefersStatusBarHidden : Bool { return true; }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // register the cell type
    self.collectionView!.register(LabelHoldingCell.self, forCellWithReuseIdentifier: LabelHoldingCell.classReuseIdentifier)
    
    // tell the collection view layout object to let the cells self-size
    let flowLayout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout

    let estimationHeight = useMagicallyBrokenHeight ? 20 : 21
    
    flowLayout.estimatedItemSize = CGSize(width: 30, height: estimationHeight)
  }

  // MARK: <UICollectionViewDatasource>
  
  override func collectionView(_ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelHoldingCell.classReuseIdentifier, for: indexPath) as! LabelHoldingCell
    cell.setText(items[(indexPath as NSIndexPath).row])
    return cell
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1;
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count;
  }
}
