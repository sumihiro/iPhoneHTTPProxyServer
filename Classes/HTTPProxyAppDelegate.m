//
//  HTTPProxyAppDelegate.m
//  HTTPProxy
//
//  Created by 上田 澄博 on 09/09/15.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "HTTPProxyAppDelegate.h"
#import "HTTPProxyViewController.h"

@implementation HTTPProxyAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	proxyServer = [[GTMHTTPServer alloc] initWithDelegate:self];
	[proxyServer setLocalhostOnly:NO];
	[proxyServer setPort:8080];
	
	[proxyServer start:nil];
	
	NSLog(@"Server started: %@",proxyServer);
	
}


- (void)dealloc {
	[proxyServer release];
	
    [viewController release];
    [window release];
    [super dealloc];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[proxyServer stop];
}


- (GTMHTTPResponseMessage *)httpServer:(GTMHTTPServer *)server
                         handleRequest:(GTMHTTPRequestMessage *)request {
	NSLog(@"request: %@",request);
	

	NSHTTPURLResponse *response;
	NSError *error;
	NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[request URL]];
	[req setHTTPMethod:[request method]];
	[req setHTTPBody:[request body]];
	[req setAllHTTPHeaderFields:[request allHeaderFieldValues]];
	[req setTimeoutInterval:15.0f];
	NSData *responseBody = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
	[req release];
	
	NSLog(@"response: %@",response);
	NSLog(@"error: %@",error);
	
	if(error) {
		return [GTMHTTPResponseMessage responseWithBody:[[error description] dataUsingEncoding:NSUTF8StringEncoding]
											contentType:@"text/html"
											 statusCode:500];
	} else {
		return [GTMHTTPResponseMessage responseWithBody:responseBody
											contentType:[response MIMEType]
											 statusCode:[response statusCode]];
	}
}



@end
