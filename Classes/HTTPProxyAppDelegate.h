//
//  HTTPProxyAppDelegate.h
//  HTTPProxy
//
//  Created by 上田 澄博 on 09/09/15.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMHTTPServer.h"

@class HTTPProxyViewController;

@interface HTTPProxyAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HTTPProxyViewController *viewController;
	
	GTMHTTPServer *proxyServer;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HTTPProxyViewController *viewController;

@end

