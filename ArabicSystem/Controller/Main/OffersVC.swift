//
//  OffersVC.swift
//  ArabicSystem
//
//  Created by Techimmense Software Solutions on 13/02/24.
//

import UIKit
import LanguageManager_iOS

class OffersVC: UIViewController {

    @IBOutlet weak var offers_Collection: UICollectionView!
    @IBOutlet weak var height_Collection: NSLayoutConstraint!
    @IBOutlet weak var lbl_OfferText: UILabel!
    
    var arr_Offers: [Res_OfferList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offers_Collection.register(UINib(nibName: "OffersCell", bundle: nil),forCellWithReuseIdentifier: "OffersCell")
        changeStaticLangauge()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        offer_List()
    }
    
    func changeStaticLangauge()
    {
        if LanguageManager.shared.currentLanguage == .en {
            self.lbl_OfferText.text = "Offers"
        } else {
            self.lbl_OfferText.text = "العروض"
        }
    }
}

extension OffersVC {
    
    func offer_List()
    {
        Api.shared.offer_Lists(self) { responseData in
            if responseData.count > 0 {
                self.arr_Offers = responseData
                let numberOfItemInRows = 2
                let numberOfRows = (self.arr_Offers.count + numberOfItemInRows - 1) / numberOfItemInRows
                let cellHeight: CGFloat = 200
                self.height_Collection.constant = CGFloat(numberOfRows) * cellHeight
            } else {
                self.arr_Offers = []
            }
            self.offers_Collection.reloadData()
        }
    }
}

extension OffersVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr_Offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCell", for: indexPath) as! OffersCell
        let obj = self.arr_Offers[indexPath.row]
        cell.lbl_CodePercent.text = "\(obj.percentage ?? "")% \("off".localiz())"
        if LanguageManager.shared.currentLanguage == .en {
            cell.lbl_ServiceName.text = obj.title ?? ""
            cell.lbl_Description.text = obj.description ?? ""
        } else {
            cell.lbl_ServiceName.text = obj.title_ar ?? ""
            cell.lbl_Description.text = obj.description_ar ?? ""
        }
        cell.lbl_Code.text = "\("Use code".localiz()) : \(obj.code ?? "")"
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.offer_Img)
        } else {
            cell.offer_Img.image = UIImage(named: "placeholder")
        }
        return cell
    }
}

extension OffersVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/2, height: 200)
    }
}
