//
//  ViewController.swift
//  imageViewer
//
//  Created by Fedor Lvov on 30/08/2019.
//  Copyright © 2019 Fedor Lvov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let url = URL(string: "https://picsum.photos/v2/list?limit=1000")! //Source of images
    var imageArray = [[String]]()
    
    @IBOutlet weak var tableView: UITableView!
    let idCell = "Image Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellReuseIdentifier: idCell) //создание ячейки кастомного класса
        sendRequest();
        
    }
    
    func sendRequest() {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let data = data {
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                            for i in jsonArray {
                                if let author = i["author"], let urlImage = i["download_url"] {
                                    self.imageArray.append([author as! String, urlImage as! String])
                                }
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData() //обновление таблицы
                            }
                        } else {
                            print("bad json")
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! ImageViewCell // Использование существующей ячейки
        
        if let array: [String] = imageArray[indexPath.row] { // установка значений в ячейки таблиц
            if let imgURL = URL(string: array[1]) {
                cell.randomImage.load(imgURL)
            }
            cell.authorName.text = array[0]
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let imgView = storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController
        if let array: [String] = imageArray[indexPath.row] { // установка значений в ячейки таблиц
            if let imgURL = URL(string: array[1]) {
                imgView?.image = imgURL
            }
        }
        self.navigationController?.pushViewController(imgView!, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ImageViewController {
           // destination.image =
        }
    }
}

extension UIImageView {
    func load(_ url: URL) { // загрузка фото по URL
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
