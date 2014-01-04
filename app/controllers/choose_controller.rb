class ChooseController < UIViewController
  def viewDidLoad
    super
    view.backgroundColor = UIColor.colorWithWhite(1,alpha: 1)
    @login = UIButtonGray.create([50,150],text:"Login with Email")
    @register = UIButtonGray.create([50,200],text:"Register with Email")
    @facebook = UIButtonGray.create([50,250],text:"Submit With Facebook")

    @login.addTarget(self,action: :login_action,forControlEvents: UIControlEventTouchUpInside)
    @register.addTarget(self,action: :register_action,forControlEvents: UIControlEventTouchUpInside)
    @facebook.addTarget(self,action: :facebook_action,forControlEvents: UIControlEventTouchUpInside)

    view.addSubview @login
    view.addSubview @register
    view.addSubview @facebook
  end

  def login_action
    new_view = LogController.alloc.init
    change_controller new_view
  end

  def register_action
    new_view = LogController.alloc.init
    change_controller new_view    
  end

  def facebook_action
    new_view = LogController.alloc.init
    change_controller new_view    
  end

  def change_controller(controller)
    self.navigationController.pushViewController(controller, animated: true)
  end

end