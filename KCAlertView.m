//
//  KCAlertView.m
//

#import "KCAlertView.h"

@interface KCAlertAction()

@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) UIAlertActionStyle style;
@property (nonatomic, readwrite) kcAlertActionHandler handler;

- (KCAlertAction *)initWithTitle:title style:(UIAlertActionStyle)style handler:(void (^)(KCAlertAction *action))handler;

@end

@implementation KCAlertAction

- (KCAlertAction *)initWithTitle:title style:(UIAlertActionStyle)style handler:(void (^)(KCAlertAction *action))handler {
    if (self = [super init]) {
        self.title = title;
        self.style = style;
        self.handler = handler;
    }
    return self;
}

+ (KCAlertAction *)actionWithTitle:title style:(UIAlertActionStyle)style handler:(void (^)(KCAlertAction *action))handler {
    KCAlertAction *action = [[KCAlertAction alloc] initWithTitle:title style:style handler:handler];
    return action;
}

@end

@interface KCAlertView()

@property (nonatomic, strong) NSArray *actions;

@end

@implementation KCAlertView

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static KCAlertView *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[KCAlertView alloc] init];
    });
    return instance;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    KCAlertAction *action = self.actions[buttonIndex];
    if (action && action.handler) {
        action.handler(action);
    }
}

- (void)showAlertWithViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message actions:(NSArray *)actions {
#if _DEBUG
    for (KCAlertAction *action in actions) {
        NSAssert([action isKindOfClass:[KCAlertAction class]], @"Invalid action, actions must contain KCAlertAction objects.");
    }
#endif
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

        for (KCAlertAction *action in actions) {
            [alertController addAction:[UIAlertAction actionWithTitle:action.title style:action.style handler:^(UIAlertAction *alertAction) {
                if (action && action.handler) {
                    action.handler(action);
                }
            }]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [viewController presentViewController:alertController animated:TRUE completion:nil];
        });
    } else {
        self.actions = actions;

        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.delegate = self;
        alertView.title = title;
        alertView.message = message;

        for (KCAlertAction *action in actions) {
            NSInteger index = [alertView addButtonWithTitle:action.title];
            
            if (action.style == UIAlertActionStyleCancel) {
                alertView.cancelButtonIndex = index;
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView show];
        });
    }
}

@end
