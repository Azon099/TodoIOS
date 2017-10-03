//
//  todoController.swift
//  LastTodoApp2
//
//  Created by vagrant on 10/2/17.
//  Copyright © 2017 vagrant. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public var Page:[Project] = []


class todoController: UITableViewController {
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        reloadInfo()        //self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        reloadInfo()
        super.viewDidLoad()
    }
    
    func reloadInfo(){
        Page.removeAll()
        Alamofire.request("https://secondtodoapp.herokuapp.com/todo_controller/mobileAppGet").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            if let json = response.result.value {
                let projects = JSON(json)
                for (_, proj) in projects["Projects"]{//"Proects"]{
                    let newProj = Project(id: Int(proj["id"].description)!, title: proj["title"].description)
                    for (_,todo) in proj["Todos"]{
                        let newTodo = Todo(id: Int(todo["id"].description)!, project_id: Int(todo["project_id"].description)!,text: todo["text"].description,isComplete: Bool(todo["isCompleted"].description)!)
                        newProj.Todos.append(newTodo)
                    }
                    Page.append(newProj)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**/
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
        return Page.count//sections.count
     }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? {
            return Page[section].title//sections[section]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let hView = UIView()
        hView.backgroundColor = uiColorFromHex(rgbValue: 0x0096FF)
        
        //hView.backgroundColor = UIColor.
        //hView.backgroundColor = //"0096FF"
        let headerLabel = UILabel(frame: CGRect(x:0, y:0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "PanfortePro-Bold", size:35)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.textAlignment = NSTextAlignment.right
        headerLabel.sizeToFit()
        hView.addSubview(headerLabel)
        
        return hView
        
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
        return Page[section].Todos.count//(sectionData[section]?.count)!
     }
 
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo", for: indexPath) as! todoCell
        let Proj = Page[indexPath.section]
        cell.setTitle(Proj.Todos[indexPath.row].text)
       /*
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: Proj.Todos[indexPath.row].text)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.textLabel?.attributedText = attributeString*/
        
        cell.checkbox.setOn(Proj.Todos[indexPath.row].isComplete, animated: false)
        cell.checkbox.todoID = Proj.Todos[indexPath.row].id
        cell.checkbox.borderColor = uiColorFromHex(rgbValue: 0x00A6FF)
        cell.checkbox.bgColorSelected = uiColorFromHex(rgbValue: 0x0096FF)
        cell.checkbox.borderWidth = 2.5
        cell.checkbox.bgColor = UIColor.white
        cell.checkbox.checkboxValueChangedBlock = {
            isOn in
            if(isOn != Proj.Todos[indexPath.row].isComplete){
                //print("Todo with id: " + cell.checkbox.todoID.description + " is changed to: " + isOn.description)
                Proj.Todos[indexPath.row].isComplete = isOn
                let reqstr = "https://secondtodoapp.herokuapp.com/todos/" + cell.checkbox.todoID.description + "|" + isOn.description
                Alamofire.request(reqstr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!).response { response in
                    print("Request: \(response.request)")
                    print("Response: \(response.response)")
                    print("Error: \(response.error)")
                }
            }
        }
        return cell
     }
    
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        // &  binary AND operator to zero out other color values
        // >>  bitwise right shift operator
        // Divide by 0xFF because UIColor takes CGFloats between 0.0 and 1.0
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
     /**/
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}


