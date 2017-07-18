//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 水野 隆夫 on 2017/07/17.
//  Copyright © 2017年 ghard1053. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var goButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var playStopButton: UIButton!

  @IBOutlet weak var imageView: UIImageView!
  var setImage:UIImage = UIImage(named:"image_1.JPG")!
  var imageCount: Int = 1
  var buttonTitle: String = "再生"

  var timer: Timer!
  var startStopCount:Bool = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    imageView.image = setImage
    
//    let gesture = UITapGestureRecognizer(target: self, action: Selector(("didClickImageView")))
//    imageView.addGestureRecognizer(gesture)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let showViewController:ShowViewController = segue.destination as! ShowViewController
    showViewController.showImage = self.setImage
    if startStopCount == false {
      stopSlide()
    }
  }

  @IBAction func goSlide(_ sender: Any) {
    slideImage()
  }
  
  @IBAction func backSlide(_ sender: Any) {
    backSlideImage()
  }
  
  @IBAction func playSlideStopSlide(_ sender: Any) {
    if startStopCount == true {
      playSlide()
    } else {
      stopSlide()
    }
  }

  func playSlide() {
    buttonTitle = "停止"
    playStopButton.setTitle(buttonTitle, for: .normal)
    buttonIsenabledFalse()
    startStopCount = false
    startSlide()
  }
 
  func stopSlide() {
    buttonTitle = "再生"
    playStopButton.setTitle(buttonTitle, for: .normal)
    buttonIsenabledTrue()
    startStopCount = true
    stopTimer()
  }
  
  func selectImage() {
    if imageCount == 1 {
      setImage = UIImage(named:"image_1.JPG")!
    } else if imageCount == 2 {
      setImage = UIImage(named:"image_2.JPG")!
    } else {
      setImage = UIImage(named:"image_3.JPG")!
    }
  }
  
  func startSlide() {
    if self.timer == nil {
      self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
  }

  func stopTimer() {
    if self.timer != nil {
      self.timer.invalidate()
      self.timer = nil
    }
  }
  
  func updateTimer(timer: Timer) {
    slideImage()
  }

  func buttonIsenabledFalse() {
    goButton.isEnabled = false
    backButton.isEnabled = false
  }
  func buttonIsenabledTrue() {
    goButton.isEnabled = true
    backButton.isEnabled = true
  }
  
  func slideImage() {
    if 1...2 ~= imageCount {
      imageCount += 1
    } else {
      imageCount = 1
    }
    selectImage()
    imageView.image = setImage
  }

  func backSlideImage() {
    if 2...3 ~= imageCount {
      imageCount -= 1
    } else {
      imageCount = 3
    }
    selectImage()
    imageView.image = setImage
  }

  //imageViewをタッチした際の画面遷移
//  func didClickImageView(recognizer: UIGestureRecognizer) {
//    if let imageView = recognizer.view as? UIImageView {
//      let image = imageView.image
//      let showViewController = ShowViewController()
//        showViewController.showImage = image
//      /** netViewController への遷移 */
//    }
//  }
  
  @IBAction func unwind(_ segue: UIStoryboardSegue) {
    
  }
  
}

