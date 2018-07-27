//
//  CategoryViewController.swift
//  Nagaraju
//
//  Created by kireeti on 25/07/18.
//  Copyright © 2018 KireetiSoftSolutions. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet var Categorytableview: UITableView!
    var  CategorylistArray = NSMutableArray()
    var  productsArray = NSMutableArray()
    var  casualproductsArray = NSMutableArray()
    var  rankingArray = NSMutableArray()
    var  VariantsArray = NSMutableArray()
    var imageView = UIImageView()
    var selected: Bool = false
    var sectioninteger : Int? = 0
    
    var sectiondIndexDict = NSMutableDictionary()
    var sectiondIndexDictforcolor = NSMutableDictionary()
    
    var fisDropDownOpened : Bool?  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.backgroundColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Categoties"
        
        
       

        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        
        if appDelegate.sharedInstance().isInternetAvailable(){
            
            Apimanager.sharedInstance.getCategoriesMethod(handler: { (response, error) in
                print("response===%@",response!)
                
                if error != nil{
                    
                    return
                }
                
                if response != nil {
                    if self.CategorylistArray.count > 0 && self.productsArray.count > 0 && self.rankingArray.count > 0 {
                        self.CategorylistArray.removeAllObjects()
                        self.productsArray.removeAllObjects()
                        self.rankingArray.removeAllObjects()
                    }
                    
        let listarray = response?.value(forKey: "categories")  as! NSArray
                    print("listarray",listarray)
                    for dict in listarray {
                        self.CategorylistArray.add(dict as! NSDictionary)

                    }
                    
                    print("Categorylistarray====",self.CategorylistArray)
                    print("productlistarray====",self.productsArray)
                    let rankingArray = response?.value(forKey: "rankings")  as! NSArray
                    for dict in rankingArray {
                        self.rankingArray.add(dict as! NSDictionary)
                    }
                    print("rankingArray====",self.rankingArray)
                    
                    DispatchQueue.main.async {
                     self.Categorytableview.estimatedRowHeight = 215
                    self.Categorytableview.sectionHeaderHeight = UITableViewAutomaticDimension
                        
                        DispatchQueue.main.async {
                            self.Categorytableview.reloadData()

                            
                        }
                }
                   
                }else{
                    print("Something went wrong, Please try againg.")
                    self.Categorytableview.isHidden = true
                    let alertView = UIAlertController(title: "", message: "No Data Found", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        
                    })
                    alertView.addAction(action)
                    self.present(alertView, animated: true, completion: nil)
                    
                }
            })
            
            
        }else{
            let alertView = UIAlertController(title: "NO INTERNET", message: "Please Make Sure Your Device is Connected to internet", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- IBACTIONS
    
    @objc func expandandcollapsehandle(sender : UIButton) {
        
        let objs : NSDictionary =  self.CategorylistArray[sender.tag] as! NSDictionary
        
        
        if self.productsArray.count > 0{
            
            self.productsArray.removeAllObjects()
        }
        
        
        let arrayofproducts = objs.value(forKey: "products") as! NSArray
                                            for dictproductlist in arrayofproducts {
                                                self.productsArray.add(dictproductlist as! NSDictionary)
        
                                                for variantsdict in self.productsArray {
                                                    let arrvariant = (variantsdict as! NSDictionary).value(forKey: "variants") as! NSArray
        
                                                    for variantsspecifieddict in arrvariant {
        
                                                        self.VariantsArray.add(variantsspecifieddict as! NSDictionary)
        
                                                    }
                                                }
                                            }
        
        
        if self.productsArray.count == 0 {
            let alertView = UIAlertController(title: "", message: "No items found.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
        }
        
        
        if sectiondIndexDict[sender.tag] == nil {
            // add object
            if productsArray.count > 0 {
                sectiondIndexDict[sender.tag] = productsArray
                
                Categorytableview.reloadSections(NSIndexSet(index: sender.tag) as IndexSet, with: .automatic)
            }
        } else {
            sectiondIndexDict.removeObject(forKey: sender.tag)
            Categorytableview.reloadSections(NSIndexSet(index: sender.tag) as IndexSet, with: .automatic)
        }

    }

// MARK: - UITableView Delegate && DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.CategorylistArray.count
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = UIView(frame: CGRect(x: 0, y: 0, width: self.Categorytableview.frame.size.width, height: 60))
                let label = UILabel(frame: CGRect(x: 10, y: 10, width: self.Categorytableview.frame.size.width, height: 40))
                headerview.backgroundColor = UIColor.clear  
                label.backgroundColor = UIColor(hexString:"#D6D6D6")
                let dict  = self.CategorylistArray.object(at: section) as! NSDictionary
        
                label.text =  (dict.value(forKey: "name") as! String)
                label.textColor = UIColor.black
        
        //Create button
        let expandandcollapsebutton = UIButton(frame: CGRect(x: 0, y: 10, width: self.Categorytableview.frame.size.width, height: 40))
        expandandcollapsebutton.backgroundColor = UIColor.clear
        expandandcollapsebutton.setTitleColor(UIColor.black, for: .normal)
        expandandcollapsebutton.addTarget(self, action: #selector(self.expandandcollapsehandle), for: .touchUpInside)
        expandandcollapsebutton.tag = section
        
    
        imageView  = UIImageView(frame:CGRect(x:self.Categorytableview.frame.size.width - 60, y:15, width:30, height:30));
       
      
       if (!(sectiondIndexDict[section] != nil)){
        imageView.image = UIImage(named:"plus")

      }else{
        imageView.image = UIImage(named:"minus-symbol")

        }
        
        
        self.view.addSubview(imageView)
        headerview.addSubview(label)
        headerview.addSubview(expandandcollapsebutton)
         headerview.addSubview(imageView)
        self.view.addSubview(headerview)
        
                return headerview
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
    return 215
  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if sectiondIndexDict[section] != nil {

        
        let array : NSMutableArray = sectiondIndexDict.object(forKey: (NSNumber.init(integerLiteral: section))) as! NSMutableArray

        if array.count > 0{
            
            return array.count
        }
            return 0
            
        }else{
            
            return 0

        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorycellid", for: indexPath) as! CustomTableViewCell
        
        if self.productsArray.count > 0{
            
          
            let dictproducts  = self.productsArray.object(at: indexPath.row) as! NSDictionary
            cell.categorynamelbl?.text  = (dictproducts.value(forKey: "name") as! String)
            
            let dictvariants  = self.VariantsArray.object(at: indexPath.row) as! NSDictionary
            cell.colorlbl?.text  = (dictvariants.value(forKey: "color") as! String)
            
            
            
            if dictvariants.value(forKey: "size")  is NSNull{

            }else{
                
                cell.sizelbl?.text  = String(format:"%@",(dictvariants.value(forKey: "size") as! NSNumber))

            }
            
            if dictvariants.value(forKey: "price") is NSNull{
                

            }else{
                cell.Pricelbl?.text  = String(format:"%@",(dictvariants.value(forKey: "price") as! NSNumber))
                
                }
            
            
             let rankdictproducts  = self.rankingArray.object(at: 0) as! NSDictionary
             let rankdictproducts1  = self.rankingArray.object(at: 1) as! NSDictionary
             let rankdictproducts2  = self.rankingArray.object(at: 2) as! NSDictionary
            
            let viewedProductsString = "Most Viewed Products"
             if let keyString:String = rankdictproducts.value(forKey: "ranking") as? String{
             if keyString == viewedProductsString {
                
                 let productsArray  = rankdictproducts.value(forKey: "products") as! Array<Any>
                for object in productsArray{
                    let productsDictonary = object as! NSDictionary
                let productid =  String(format:"%@",productsDictonary.value(forKey: "id") as! NSNumber)
                
                let productidfrommain =  String(format:"%@",dictproducts.value(forKey: "id") as! NSNumber)
                
                if productidfrommain == productid {
                
                cell.viewslbl?.attributedText = self.decorateText(sub: "Views: ", des: String(format:"%@",productsDictonary.value(forKey: "view_count") as! NSNumber ))
                    
                }
                }
                }
            }
            
            let orderedProductsString = "Most OrdeRed Products"
            if let keyString:String = rankdictproducts1.value(forKey: "ranking") as? String{
                if keyString == orderedProductsString {
                    let productsArray  = rankdictproducts1.value(forKey: "products") as! Array<Any>
                    for object in productsArray{
                        let productsDictonary = object as! NSDictionary
                        let productid =  String(format:"%@",productsDictonary.value(forKey: "id") as! NSNumber)
                        
                        let productidfrommain =  String(format:"%@",dictproducts.value(forKey: "id") as! NSNumber)
                        
                        if productidfrommain == productid {
                        cell.orderslbl?.attributedText = self.decorateText(sub: "Orders: ", des: String(format:"%@",productsDictonary.value(forKey: "order_count") as! NSNumber ))
                       
                        }
                    }
                }
            }
            
            let sharedProductsString = "Most ShaRed Products"
            if let keyString:String = rankdictproducts2.value(forKey: "ranking") as? String{
                if keyString == sharedProductsString {
                    let productsArray  = rankdictproducts2.value(forKey: "products") as! Array<Any>
                    for object in productsArray{
                        let productsDictonary = object as! NSDictionary
                        let productid =  String(format:"%@",productsDictonary.value(forKey: "id") as! NSNumber)
                        
                        let productidfrommain =  String(format:"%@",dictproducts.value(forKey: "id") as! NSNumber)
                        
                        if productidfrommain == productid {
                            
                        cell.shareslbl.attributedText = self.decorateText(sub: "Shares: ", des: String(format:"%@",productsDictonary.value(forKey: "shares") as! NSNumber ))
             
                        }
                    }
                }
            }
            
            
         print("rankindictproducts===%@",rankdictproducts)
            /*
            for dict  in self.rankingArray {
                let dictonary = dict as! NSDictionary
                let productsArray  = dictonary.value(forKey: "products") as! Array<Any>
                for object in productsArray{
                    let productsDictonary = object as! NSDictionary
                    if let keyString:String = dictonary.value(forKey: "ranking") as? String{
                        let viewedProductsString = "Most Viewed Products"
                        if keyString == viewedProductsString {
                            let productid =  String(format:"%@",productsDictonary.value(forKey: "id") as! NSNumber)
                            
                             let productidfrommain =  String(format:"%@",dictproducts.value(forKey: "id") as! NSNumber)
                           
                            if productidfrommain == productid {
                              
                                 cell.viewslbl?.attributedText = self.decorateText(sub: "Views: ", des: String(format:"%@",productsDictonary.value(forKey: "view_count") as! NSNumber ))
                            }
                        }
                        let orderedProductsString = "Most OrdeRed Products"
                        if keyString == orderedProductsString {
                            let productid = String(format:"%@",productsDictonary.value(forKey: "id") as! NSNumber)
                            let productidfrommain =  String(format:"%@",dictproducts.value(forKey: "id") as! NSNumber)
                            if productidfrommain == productid {
                               
                                
                                 cell.orderslbl?.attributedText = self.decorateText(sub: "Orders: ", des: String(format:"%@",productsDictonary.value(forKey: "order_count") as! NSNumber ))
                                
                            }
                        }
                        let sharedProductsString = "Most ShaRed Products"
                        if keyString == sharedProductsString {
                            let productid = String(format:"%@",productsDictonary.value(forKey: "id") as! NSNumber)
                            let productidfrommain =  String(format:"%@",dictproducts.value(forKey: "id") as! NSNumber)
                            if productidfrommain == productid {
                              
                                cell.shareslbl.attributedText = self.decorateText(sub: "Shares: ", des: String(format:"%@",productsDictonary.value(forKey: "shares") as! NSNumber ))
                                
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    
                }
            }
            */
     
        }else{
            
     
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            if self.productsArray.count > 0{
                
                
                let detailsview = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                detailsview.Detailsarray = self.productsArray
                detailsview.indexpathrow = indexPath.row
                self.navigationController?.pushViewController(detailsview, animated: true)
                
        }
        
    }
    
    // MARK: -  Decorate UILabel Text
    func decorateText(sub:String, des:String)->NSAttributedString{
        let textAttributesOne = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: 14.0)!]
        let textAttributesTwo = [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#5c9ce8"), NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 14.0)!]
        
        let textPartOne = NSMutableAttributedString(string: sub, attributes: textAttributesOne)
        let textPartTwo = NSMutableAttributedString(string: des, attributes: textAttributesTwo)
        
        let textCombination = NSMutableAttributedString()
        textCombination.append(textPartOne)
        textCombination.append(textPartTwo)
        return textCombination
    }
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue:      CGFloat(b) / 255, alpha: CGFloat(a) / 255)
}
}
