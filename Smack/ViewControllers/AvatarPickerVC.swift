//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by maropost on 31/01/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    // Outlets
    @IBOutlet weak var collectionViewAvatar: UICollectionView!
    @IBOutlet weak var segmentControlAvatar: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewAvatar.delegate = self
        self.collectionViewAvatar.dataSource = self
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            return cell
        }
        
        return AvatarCell()
    }
}

