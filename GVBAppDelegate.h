//
//  Google_Voice_BrowserAppDelegate.h
//  Google Voice Browser
//
//  Created by David Beck on 4/29/10.
//  Copyright 2010 Ultimate Reno Web Design. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WebView;

@interface GVBAppDelegate : NSObject <NSApplicationDelegate> {
	NSWindow *window;
	WebView *webView;
	
	NSMenuItem *zoomIn;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *webView;

@property (assign) IBOutlet NSMenuItem *zoomIn;

- (IBAction)refresh:(id)sender;

@end
