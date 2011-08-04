//
//  GVBAppDelegate.m
//  Google Voice Browser
//
//  Copyright (c) 2010, David Beck
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, 
//  are permitted provided that the following conditions are met:
//  
//  - Redistributions of source code must retain the above copyright notice, 
//    this list of conditions and the following disclaimer.
//  - Redistributions in binary form must reproduce the above copyright notice, 
//    this list of conditions and the following disclaimer in the documentation 
//    and/or other materials provided with the distribution.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
//  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
//  OF THE POSSIBILITY OF SUCH DAMAGE.
//  

#import "GVBAppDelegate.h"

#import <WebKit/WebKit.h>

@implementation GVBAppDelegate

@synthesize window = _window;
@synthesize webView = _webView;
@synthesize zoomIn = _zoomIn;


#pragma mark -
#pragma mark NSApplication Delegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self.zoomIn setKeyEquivalent:@"+"];
	[self.zoomIn setKeyEquivalentModifierMask:NSCommandKeyMask];
	
	self.webView.frameLoadDelegate = self;
	[self.webView setContinuousSpellCheckingEnabled:YES];
	[self.webView setMainFrameURL:@"https://www.google.com/voice#inbox"];
}

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
