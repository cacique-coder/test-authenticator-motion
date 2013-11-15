class AppDelegate
  include Auth::FacebookAppDeletegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.rootViewController = LogController.alloc.initWithNibName(nil, bundle: nil)
    true
  end
end
