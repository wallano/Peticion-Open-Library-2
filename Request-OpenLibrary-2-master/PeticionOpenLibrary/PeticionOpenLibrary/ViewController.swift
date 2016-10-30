//
//  ViewController.swift
//  PeticionOpenLibrary
//
//  Created by administradorMAC on 30/10/16.
//  Copyright © 2016 Walter Llano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchText: UITextField!
    @IBOutlet var LabelTitulo: UILabel!
    @IBOutlet var LabelAutores: UILabel!
    @IBOutlet var LabelPortada: UILabel!
    @IBAction func ButtonSearch(_ sender: UIButton) {
        
        self.LabelTitulo.text = ""
        self.LabelAutores.text = ""
        self.LabelPortada.text = ""
        
        let url = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let urlComplete = "\(url)\(self.searchText.text!)"
        let urlFull = URL(string: urlComplete)
        if let datos = try? Data(contentsOf: urlFull!){
            do{
                let json = try JSONSerialization.jsonObject(with: datos, options: JSONSerialization.ReadingOptions.mutableLeaves)
                if json.count>0{
                    let response = json as! NSDictionary
                    let libro = response["ISBN:"+self.searchText.text!] as! NSDictionary
                    let nombre = libro["title"] as! NSString as String
                    self.LabelTitulo.text = nombre
                    
                    
                    let autores = libro["authors"] as! NSArray
                    for item in autores{
                        print(item["name"] as! NSString as String)
                        
                        self.LabelAutores.text = self.LabelAutores.text! + (item["name"] as! NSString as String)
                        
                    }
                    self.LabelPortada.text = "No Existe Portada"
                }else{
                    let alertController = UIAlertController(title: "OpenLibrary Request", message:
                        "No hay resultado para la Busqueda", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)

                }
                
                
                
                //self.LabelAutores.text = autores as! NSString as String
                
                
                
            }catch _{
            }
        }else{
            let alertController = UIAlertController(title: "OpenLibrary Request", message:
                "Error al obtener los datos", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func ButtonClear(_ sender: UIButton) {
        self.searchText.text = ""
        self.LabelTitulo.text = ""
        self.LabelAutores.text = ""
        self.LabelPortada.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

