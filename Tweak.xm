#import "Tweak.h"

BOOL initialized = NO;

%group Moveable
  %hook NotificationController
    -(void)viewDidLoad {
      %orig;
      if (!initialized) {
        initialized = YES;
        NotificationController *me = (NotificationController*) self;

        UIStackView *stackView = MSHookIvar<UIStackView *>(me, "_stackView");
        UIView *view = nil;
        if (axon) {
          view = me.axnView;
        } else {
          view = me.grpView;
        }

        //id object = [stackview.arrangedSubviews objectAtIndex:0];
        [stackView removeArrangedSubview:view];
        [stackView removeArrangedSubview:me.collectionView];
        [stackView addArrangedSubview:me.collectionView];
        [stackView addArrangedSubview:view];
        // [stackView addArrangedSubview:self.axnView];
      }
    }
    -(void)viewDidAppear:(BOOL)animated {
      %orig(animated);
      NotificationController *me = (NotificationController*) self;
      UIStackView *stackView = MSHookIvar<UIStackView *>(me, "_stackView");
      UIView *view = nil;
      if (axon) {
        view = me.axnView;
      } else {
        view = me.grpView;
      }
      if (me.collectionView != nil) {
        [stackView removeArrangedSubview:view];
        [stackView removeArrangedSubview:me.collectionView];
        [stackView addArrangedSubview:me.collectionView];
        [stackView addArrangedSubview:view];
      }
    }
    -(void)_updatePresentingContent {
      %orig;
      NotificationController *me = (NotificationController*) self;
      UIStackView *stackView = MSHookIvar<UIStackView *>(me, "_stackView");
      UIView *view = nil;
      if (axon) {
        view = me.axnView;
      } else {
        view = me.grpView;
      }
      if(me.collectionView != nil) {
        [stackView removeArrangedSubview:view];
        [stackView removeArrangedSubview:me.collectionView];
        [stackView addArrangedSubview:me.collectionView];
        [stackView addArrangedSubview:view];
  		}
    }
  %end
%end // Moveable

%ctor {
  if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Axon.dylib"]) axon = YES;
  else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Grupi.dylib"]) grupi = YES;

  if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/LockWidgets.dylib"]) lockwidgets = YES;
  
  if (lockwidgets && (axon || grupi)) {
    if (axon) dlopen("/Library/MobileSubstrate/DynamicLibraries/Axon.dylib", RTLD_NOW);
    else if (grupi) dlopen("/Library/MobileSubstrate/DynamicLibraries/Grupi.dylib", RTLD_NOW);
    dlopen("/Library/MobileSubstrate/DynamicLibraries/LockWidgets.dylib", RTLD_NOW);

    NSString *notificationControllerClass = @"SBDashBoardNotificationAdjunctListViewController";

    if(@available(iOS 13.0, *)) {
      notificationControllerClass = @"CSNotificationAdjunctListViewController";
    }
    %init(Moveable, NotificationController = NSClassFromString(notificationControllerClass));
  }
}

