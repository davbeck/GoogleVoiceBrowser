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
	NSWindow *_window;
	WebView *_webView;
	
	NSMenuItem *_zoomIn;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet WebView *webView;

@property (nonatomic, retain) IBOutlet NSMenuItem *zoomIn;

- (IBAction)refresh:(id)sender;

@end
