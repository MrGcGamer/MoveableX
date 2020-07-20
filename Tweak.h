#import <UIKit/UIKit.h>
#include <dlfcn.h>

BOOL axon = NO;
BOOL grupi = NO;
BOOL lockwidgets = NO;

@interface AXNView : UIView
@end
@interface GRPView : UIView
@end

@interface SBDashBoardNotificationAdjunctListViewController
@property (nonatomic, retain) AXNView *axnView;
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@interface CSNotificationAdjunctListViewController
@property (nonatomic, retain) AXNView *axnView;
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@interface NotificationController
@property (nonatomic, retain) AXNView *axnView;
@property (nonatomic, retain) AXNView *grpView;
@property (strong, nonatomic) UICollectionView *collectionView;
@end