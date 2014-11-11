//
//  KCAlertView.h
//

#import <UIKit/UIKit.h>

@class KCAlertAction;

typedef void (^kcAlertActionHandler)(KCAlertAction *action);

@interface KCAlertAction : NSObject

+ (KCAlertAction *)actionWithTitle:title style:(UIAlertActionStyle)style handler:(void (^)(KCAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) UIAlertActionStyle style;
@property (nonatomic, readonly) kcAlertActionHandler handler;

@end

@interface KCAlertView : NSObject<UIAlertViewDelegate>

+ (instancetype)sharedInstance;

- (void)showAlertWithViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message actions:(NSArray *)actions;

@end
