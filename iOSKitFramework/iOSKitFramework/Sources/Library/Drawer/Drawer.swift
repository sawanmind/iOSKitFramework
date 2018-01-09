







import UIKit

public class Drawer: UIView, drawerProtocolNew, UITableViewDelegate, UITableViewDataSource {
  

   
    
    fileprivate let height = UIScreen.main.bounds.height
    fileprivate var width = CGFloat()
    fileprivate var tableView = UITableView()
    fileprivate var vcArrays = NSArray()
    fileprivate var arrayElements = [DrawerModel]()
  
  
    public  var backgroundView = UIView()
    public var drawerView = UIView()
    weak public var delegate:DrawerControllerDelegate?
    private var currentViewController = UIViewController()
    
    
    convenience public init(elements: [DrawerModel], controller:UIViewController) {
        self.init(frame: UIScreen.main.bounds)
     
       
        if UIDevice.current.userInterfaceIdiom == .phone {
                width = UIScreen.main.bounds.width/2+75
                tableView = UITableView(frame:  CGRect(x:0, y:160, width:width, height:height - 160), style: .grouped)
        } else {
                width = UIScreen.main.bounds.width/2 - 75
                tableView = UITableView(frame:  CGRect(x:0, y:210, width:width, height:height - 210), style: .grouped)
        }
        
        
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        self.tableView.register(DrawerCell.self, forCellReuseIdentifier: "cell")
        self.initialise(elements: elements, controller:controller)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private  func setupHeaderView() -> UIView {

        let  header = UIView()
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            header.frame = CGRect(x:0, y:0, width:width, height:160)
        } else {
            header.frame = CGRect(x:0, y:0, width:width, height:210)
        }
        

        let topColor = UIColor().colorFromHexString("B7F8DB")
        let bottomColor = UIColor().colorFromHexString("50A7C2")
        
        header.applyGradient(topColor:topColor, bottomColor:bottomColor)
        
        header.addSubview(avatarImage)
        avatarImage.topAnchor.constraint(equalTo: header.topAnchor,constant: 30).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: header.leadingAnchor,constant:10).isActive = true
    
        if UIDevice.current.userInterfaceIdiom == .phone {
            avatarImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
            avatarImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        } else {
            avatarImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
            avatarImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
        
   
        header.addSubview(editProfileBtn)
        editProfileBtn.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor).isActive = true
        editProfileBtn.trailingAnchor.constraint(equalTo: header.trailingAnchor,constant:-10).isActive = true
        editProfileBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        editProfileBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        header.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor,constant:17).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor,constant:10).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: header.widthAnchor,constant:-10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        
        header.addSubview(subtitle)
        subtitle.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant:7).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: header.leadingAnchor,constant:10).isActive = true
        subtitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
        subtitle.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        
        header.addSubview(moreBtn)
        moreBtn.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor,constant:15).isActive = true
        moreBtn.trailingAnchor.constraint(equalTo: header.trailingAnchor,constant:-10).isActive = true
        moreBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        moreBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return header
    }
    
    
    

  public  lazy var avatarImage : UIImageView = {
        let avatarImage = UIImageView()
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            avatarImage.layer.cornerRadius = 30
        } else {
            avatarImage.layer.cornerRadius = 50
        }
      
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.borderWidth = 3.0
        avatarImage.clipsToBounds = true
        avatarImage.contentMode = .scaleAspectFit
        avatarImage.backgroundColor = UIColor.white
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        return avatarImage
    }()
   
   private lazy var editProfileBtn : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Edit Profile", for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.layer.cornerRadius = 5.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapProfileBtn), for: .touchUpInside)
        return button
    }()

    
   private lazy var moreBtn : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(named:"more"), for: .normal)
        button.imageView?.tintColor  = UIColor.black
        button.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapMoreBtn), for: .touchUpInside)
        return button
    }()
    
    
  public  let nameLabel : UILabel = {
        let textlabel = UILabel()
        textlabel.text = "Sawan Kumar"
        textlabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.black)
        textlabel.translatesAutoresizingMaskIntoConstraints = false
        return textlabel
    }()
    
    
  public  let subtitle : UILabel = {
        let textlabel = UILabel()
        textlabel.text = "@sawanmind"
        textlabel.font =  UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textlabel.translatesAutoresizingMaskIntoConstraints = false
        return textlabel
    }()
    
   @objc  fileprivate func didTapProfileBtn(){
        delegate?.didTapButton(type: .editProfile)
    }
    
    
    @objc  fileprivate func didTapMoreBtn(){
        delegate?.didTapButton(type: .moreButton)
    }
    
    
    
    private  func initialise(elements: [DrawerModel], controller:UIViewController) {
        
      
        currentViewController = controller
        currentViewController.tabBarController?.tabBar.isHidden = true
        
        backgroundView.frame = UIScreen.main.bounds
        drawerView.backgroundColor = UIColor.clear
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:  #selector(Drawer.dismissVC))
        swipeGesture.direction = .left
        backgroundView.addGestureRecognizer(swipeGesture)
      
        let tap = UITapGestureRecognizer(target: self, action: #selector(Drawer.dismissVC))
        backgroundView.addGestureRecognizer(tap)
        addSubview(backgroundView)
        
        drawerView.frame = CGRect(x:0, y:0, width:width, height:height)
        drawerView.clipsToBounds = true


        self.allocateLayout(elements:elements)
    }
    
    
    private  func allocateLayout(elements: [DrawerModel]) {
      
        arrayElements = elements
    
        tableView.delegate = self
        tableView.dataSource = self
   
        drawerView.addSubview(tableView)
        tableView.reloadData()
        addSubview(drawerView)
      
        drawerView.addSubview(setupHeaderView())
        
    }
    
   public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
   public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    
  public  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    
 public   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
   public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    
  public  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayElements.count
    }

    
  public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DrawerCell
        cell.textlabel.text = arrayElements[indexPath.row].text
        cell.iconImage.image = arrayElements[indexPath.row].icon
        return cell
    }
    
   public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissVC()
        let new = arrayElements[indexPath.row].controller
        self.delegate?.pushTo(viewController: new)
    }

   
    @objc private func dismissVC() {
         currentViewController.tabBarController?.tabBar.isHidden = false
         UIApplication.shared.statusBarView?.isHidden = false
        self.dissmiss()
    }
    
 
}

