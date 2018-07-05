//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios7649 on 7/2/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtFone: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtSite: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
    
    var contact: Contact?
    var delegate: CreateOrUpdateContactDelegate?
    @IBOutlet weak var loadingFindCoordinates: UIActivityIndicatorView!
    
    let dao = ContactDAO.shared
    var isNew = true

    override func viewDidLoad() {
        super.viewDidLoad()
        if let contact = self.contact {
            fillForm(with: contact)
            isNew = false
        }else{
            contact = Contact()
        }
    }
    
    private func fillForm(with contact: Contact){
        txtNome.text = contact.name
        txtEndereco.text = contact.address
        txtSite.text = contact.site
        txtFone.text = contact.phone
        photoImageView.image = contact.photo
        txtLatitude.text = contact.latitude?.description
        txtLongitude.text = contact.longitude?.description
    }
    
    private func fillContact(){
        contact?.name = txtNome.text!
        contact?.phone = txtFone.text!
        contact?.address = txtEndereco.text!
        contact?.site = txtSite.text!
        if let photo = photoImageView.image {
            contact?.photo = photo
        }
        if let latitude = Double(self.txtLatitude.text!) {
            contact?.latitude = latitude
        }
        if let longitude = Double(self.txtLongitude.text!) {
            contact?.longitude = longitude
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func saveContact(_ sender: UIBarButtonItem) {
        
        fillContact()
        
        if isNew {
            dao.add(newContact: contact!)
            delegate?.created(contact: contact!)
        }else{
            delegate?.updated(contact: contact!)
        }
        _ = navigationController?.popViewController(animated: true)// _ = ignora o retorno
        
    }
    
    @IBAction func findCoordinates(_ sender: UIButton) {
        
        sender.isHidden = true
        self.loadingFindCoordinates.startAnimating()
        
        
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(self.txtEndereco.text!) { (result, error) in
            
            defer {
                sender.isHidden = false
                self.loadingFindCoordinates.stopAnimating()
            }
            
            guard error == nil else{ return }
            
            guard let places = result else{  return  }
            
            guard places.count > 0 else{ return }

            let placemark = places[0]
            
            guard let location = placemark.location else {return}
            
            let coordenada = location.coordinate
            
            self.txtLatitude.text = coordenada.latitude.description
            self.txtLongitude.text = coordenada.longitude.description
            
            
        
        }
        
    }

    //acao para o "Tap Gesture Recognizer" que foi colocado graficamente em cima do UIImageView
    @IBAction func choosePhoto(_ sender: UITapGestureRecognizer) {
        
        activityIndicator.startAnimating()
        //para imperdir que seja clicado mais de uma vez
        photoImageView.isUserInteractionEnabled = false
        
       
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let alert = UIAlertController(title: "Choose Source", message: nil, preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Take Photo", style: .default, handler: { (action) in
                self.showImage(from: .camera)
            })
            
            let library = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
                self.showImage(from: .photoLibrary)
            })

            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                self.stopImageLoader()
            })
            
            alert.addAction(camera)
            alert.addAction(library)
            alert.addAction(cancel)
            
        }else{
            showImage(from: .photoLibrary)
        }
    
        
       
    }
    
    private func showImage(from source: UIImagePickerControllerSourceType){
        
        let imageController = UIImagePickerController()
        imageController.allowsEditing = true
        imageController.delegate = self
        imageController.sourceType = source
        
        present(imageController, animated: true, completion: nil)
    }
}



extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        //executa somente antes do return ou finalizacao do metodo. ou seja executa sempre antas de finalizar o metodo
        defer {
            stopImageLoader()
            //fecha o app de fotos
            picker.dismiss(animated: true, completion: nil)
        }
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }
        
        photoImageView.image = image
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        stopImageLoader()
        picker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func stopImageLoader(){
        activityIndicator.stopAnimating()
        photoImageView.isUserInteractionEnabled = true

    }
}

