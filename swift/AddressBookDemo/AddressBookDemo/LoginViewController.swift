//
//  LoginViewController.swift
//  AddressBookDemo
//
//  Created by dfang on 2018-1-18.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rememberPwdSwitch: UISwitch!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    let usernameKey = "username"
    let passwordKey = "password"
    let rememberPwdKey = "rememberPwd"
    let autoLoginKey = "autoLogin"
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        usernameField.text = defaults.value(forKey: usernameKey) as? String
        rememberPwdSwitch.isOn = defaults.bool(forKey: rememberPwdKey)
        
        if (rememberPwdSwitch.isOn) {
             passwordField.text = defaults.value(forKey: passwordKey) as? String
        }
        
        textChanged()

        autoLoginSwitch.isOn = defaults.bool(forKey: autoLoginKey)
        if (autoLoginSwitch.isOn) {
            loginBtnClicked()
        }
    }
    
    @IBAction func textChanged() {
        if (usernameField.text != nil && usernameField.text!.lengthOfBytes(using: String.Encoding.utf8) > 0 &&
            passwordField.text != nil && passwordField.text!.lengthOfBytes(using: String.Encoding.utf8) > 0) {
            loginBtn.isEnabled = true
            registerBtn.isEnabled = true
        } else {
            loginBtn.isEnabled = false
            registerBtn.isEnabled = false
        }
    }
    
    @IBAction func rememberSwitchChanged() {
        if !rememberPwdSwitch.isOn && autoLoginSwitch.isOn {
            autoLoginSwitch.isOn = false
        }
        saveSwitchToPreference()
    }
    
    @IBAction func autoLoginSwitchChanged() {
        if autoLoginSwitch.isOn && !rememberPwdSwitch.isOn {
            rememberPwdSwitch.isOn = true
        }
        saveSwitchToPreference()
    }
    
    func saveSwitchToPreference() {
        defaults.set(rememberPwdSwitch.isOn, forKey: rememberPwdKey)
        defaults.set(autoLoginSwitch.isOn, forKey: autoLoginKey)
        defaults.synchronize()
    }
    
    @IBAction func loginBtnClicked() {
        if usernameField.text == "east" && passwordField.text == "1234" {
            self.performSegue(withIdentifier: "toContactsSegue", sender: nil)
            
            defaults.set(usernameField.text, forKey: usernameKey)
            defaults.set(passwordField.text, forKey: passwordKey)
            defaults.set(rememberPwdSwitch.isOn, forKey: rememberPwdKey)
            defaults.set(autoLoginSwitch.isOn, forKey: autoLoginKey)
            defaults.synchronize()
        } else {
            let alertController = UIAlertController.init(title: "登录失败", message: "您输入的用户名或密码错误！", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func registerBtnClicked() {
        let alertController = UIAlertController.init(title: "注册新用户", message: "正在完善中，敬请期待！", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    // UITextfieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        if (vc.isKind(of: ContactsViewController.self)) {
            let contactsVC:ContactsViewController = vc as! ContactsViewController
            contactsVC.name = usernameField.text
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

