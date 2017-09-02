//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Tyron Spencer on 2/9/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        
    }
    // Now that we have implented or dataSource and delegate we need to conform to them:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            return cell
        }
        return AvatarCell()
    }
    
    // Now we need to state how many section there are:
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Now we need to state how many number of items in the sections:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    
    @IBAction func segmentControlChanged(_ sender: Any) {
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
