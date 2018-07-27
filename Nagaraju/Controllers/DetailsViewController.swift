//
//  DetailsViewController.swift
//  Nagaraju
//
//  Created by kireeti on 26/07/18.
//  Copyright © 2018 KireetiSoftSolutions. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var  Detailsarray = NSMutableArray()
     var  variantsarrray = NSMutableArray()
    var cartdict = NSMutableDictionary()
    var  cartarray = NSMutableArray()
    var indexpathrow : Int? = 0
    @IBOutlet var btncart: UIButton!
    
    @IBOutlet var produnamelbl: UILabel!
    @IBOutlet var detailstableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        
        if self.Detailsarray.count > 0{
            let dictobj  = self.Detailsarray.object(at: indexpathrow!) as! NSDictionary
            
            self.produnamelbl.text = (dictobj.value(forKey: "name") as! String)
            
              let arrayofproducts = dictobj.value(forKey: "variants") as! NSArray
            for variantsspecifieddict in arrayofproducts {
                self.variantsarrray.add(variantsspecifieddict as! NSDictionary)
                print(" self.variantsarrray==%@",self.variantsarrray)
            }
        }
        
        self.btncart.layer.cornerRadius = self.btncart.frame.size.height/2
        
            self.detailstableview.estimatedRowHeight = 155
            self.detailstableview.sectionHeaderHeight = UITableViewAutomaticDimension
           self.detailstableview.reloadData()
                
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UITableView Delegate && DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return  self.variantsarrray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailscellid", for: indexPath) as! DetailsCustomTableViewCell
        
        let dictvariants  = self.variantsarrray.object(at: indexPath.row) as! NSDictionary
        cell.colorlbl?.text  = (dictvariants.value(forKey: "color") as! String)
        
        if dictvariants.value(forKey: "size")  is NSNull{
            
        }else{
            
            cell.sizelbl?.text  = String(format:"%@",(dictvariants.value(forKey: "size") as! NSNumber))
            
        }
        
        if dictvariants.value(forKey: "price") is NSNull{
            
            
        }else{
            
            
            cell.pricelbl?.text  = String(format:"%@",(dictvariants.value(forKey: "price") as! NSNumber))
            
            
        }
        cell.btnbuy.addTarget(self, action: #selector(self.Buynowhandle), for: .touchUpInside)
    
   
        for i in indexPath.row..<variantsarrray.count {
            cell.btnbuy.tag = 9 * (indexPath.row + 1)
        }

        return cell
    }
    
    // MARK:- IBACTIONS
    
    @objc func Buynowhandle(sender : UIButton) {
      
            let btn = sender as? UIButton
        let intIndex: Int = ((btn?.tag)! / 9) - 1
        print("Selected row is: \(intIndex)")
    let dict  = variantsarrray[intIndex]  as! NSDictionary
        let myMutableDict: NSMutableDictionary = NSMutableDictionary(dictionary: dict)

        let intIndexOfCategory: Int = cartarray.index(of: cartdict)
        if intIndexOfCategory == 4388744179 || intIndexOfCategory == -1 {
            myMutableDict["color"] = myMutableDict["color"]
            cartarray.add(myMutableDict)
            print("subarray===\(cartdict)")
            btncart.setTitle("\(UInt(cartarray.count))", for: .normal)

        }else{
            print("alreadyexist")
            var alertController: UIAlertController?
            alertController = UIAlertController(title: "This Item Alreadyexist in Cart", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in

            })
            alertController?.addAction(ok)
            if let aController = alertController {
                present(aController, animated: true)
            }

        }
    }
    
}
