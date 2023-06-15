//
//  ViewController.swift
//  Project25
//
//  Created by Fauzan Dwi Prasetyo on 14/05/23.
//

import UIKit
import MultipeerConnectivity

class ViewController: UITableViewController {
    
    var messages = [Message]()
    
    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var mcSession: MCSession?
    var mcAdvertiserAssistant: MCAdvertiserAssistant?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession?.delegate = self
        
        title = "Selfie Share"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(writeText))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))

    }
    
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    @objc func writeText() {
        let ac = UIAlertController(title: "Type your messages", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Send", style: .default) { [weak self] _ in
            guard let msg = ac.textFields?[0].text else { return }
            var message = Message(userName: self?.peerID.displayName ?? "userName", message: msg)
            
            self?.messages.insert(message, at: 0)
            self?.tableView.reloadData()
            
            guard let mcSession = self?.mcSession else { return }
            
            if mcSession.connectedPeers.count > 0 {
                if let msgData = self?.parseJSON(message) {
                    do {
                        try mcSession.send(msgData, toPeers: mcSession.connectedPeers, with: .reliable)
                    } catch {
                        let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        
                        self?.present(ac, animated: true)
                    }
                }
            }
        })
        
        present(ac, animated: true)
    }
    
    func parseJSON(_ message: Message) -> Data {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(message)
            return data
        } catch {
            print("Failed to encode Message, \(error)")
        }
        
        return Data()
    }

}


// MARK: - UITableViewController Method

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
        
        cell.textLabel?.text = msg.userName
        cell.detailTextLabel?.text = msg.message
        
        return cell
    }
    
}


// tes
// MARK: - MCSessionDelegate & MCAdvertiserAssistantDelegate Protocol

extension ViewController: MCSessionDelegate, MCBrowserViewControllerDelegate {
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected: \(peerID.displayName)")
            
        case .connecting:
            print("Connecting: \(peerID.displayName)")
            
        case .notConnected:
            let ac = UIAlertController(title: "\(UIDevice.current.name) iPhone has disconnected", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(ac, animated: true)
            print("Not Connected: \(peerID.displayName)")
            
        @unknown default:
            print("Unknown state received: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            let jsonDecoder = JSONDecoder()
            do {
                let msg = try jsonDecoder.decode(Message.self, from: data)
                self.messages.insert(msg, at: 0)
                self.tableView.reloadData()
            } catch {
                print("Failed to decode msgData, \(error)")
            }
            
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
    func startHosting(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else { return }
        
        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        
        present(mcBrowser, animated: true)
    }
    
}
