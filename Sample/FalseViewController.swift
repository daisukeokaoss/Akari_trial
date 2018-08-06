//
//  FalseViewController.swift
//  Sample
//
//  Created by 岡大輔 on 2018/08/06.
//  Copyright © 2018年 koherent.org. All rights reserved.
//

import UIKit

class FalseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dismiss(animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(2)
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
