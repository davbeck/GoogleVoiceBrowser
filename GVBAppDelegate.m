//
//  Google_Voice_BrowserAppDelegate.m
//  Google Voice Browser
//
//  Created by David Beck on 4/29/10.
//  Copyright 2010 Ultimate Reno Web Design. All rights reserved.
//

#import "GVBAppDelegate.h"

#import <WebKit/WebKit.h>

@implementation GVBAppDelegate

@synthesize window;
@synthesize webView;
@synthesize zoomIn;


#pragma mark -
#pragma mark NSApplication Delegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[zoomIn setKeyEquivalent:@"+"];
	[zoomIn setKeyEquivalentModifierMask:NSCommandKeyMask];
	
	/*
	NSWindowCollectionBehavior behavior = [self.window collectionBehavior];
	behavior |= NSWindowCollectionBehaviorMoveToActiveSpace;
	behavior &= !NSWindowCollectionBehaviorCanJoinAllSpaces;
	[self.window setCollectionBehavior:behavior];
	 */
	
	self.webView.frameLoadDelegate = self;
	[self.webView setMainFrameURL:@"https://www.google.com/voice#inbox"];
}

/*
- (void)applicationDidBecomeActive:(NSNotification *)aNotification
{
	[self.window makeKeyAndOrderFront:self];
}
 */

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	return YES;
}

- (BOOL)applicationOpenUntitledFile:(NSApplication *)theApplication
{
	[self.window makeKeyAndOrderFront:self];
	
	return YES;
}

#pragma mark -
#pragma mark WebView Delegate

- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame
{
	self.window.title = title;
	
	NSRange openRange = [title rangeOfString:@"("];
	NSRange closeRange = [title rangeOfString:@")"];
	NSRange unreadRange = NSMakeRange(openRange.location + openRange.length, closeRange.location - openRange.location - openRange.length);
	
	if (unreadRange.location != NSNotFound) {
		[NSApplication sharedApplication].dockTile.badgeLabel = [title substringWithRange:unreadRange];
	} else {
		[NSApplication sharedApplication].dockTile.badgeLabel = nil;
	}
}


#pragma mark -
#pragma mark Actions

- (IBAction)refresh:(id)sender
{
	[self.webView stringByEvaluatingJavaScriptFromString:@"var evObj = document.createEvent('MouseEvents');"
	 "evObj.initMouseEvent( 'click', true, true, window, 1, 12, 345, 7, 220, false, false, true, false, 0, null );"
	 "document.getElementById('gc-inbox-refresh').dispatchEvent(evObj);"];
}

@end
