//
//  AOBCarChannelViewController.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 25/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBCarChannelViewController.h"
#import <PhoenixClient/PhoenixClient.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface AOBCarChannelViewController ()<UITextFieldDelegate, WCSessionDelegate>

@property (nonatomic, retain) PhxSocket *socket;
@property (nonatomic, retain) PhxChannel *channel;
@property (nonatomic, retain) WCSession *session;
@property (nonatomic,strong) NSMutableString *messages;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardHeight;
@property (weak, nonatomic) IBOutlet UITextField *username;

@end

@implementation AOBCarChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messages = [NSMutableString stringWithString:@""];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self phoenixConnect];
    [self observeKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.socket disconnect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)phoenixConnect {
    if (self.socket != nil && [self.socket isConnected]) {
        return;
    }
    self.socket = [[PhxSocket alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/socket/websocket",kApiUrl]] heartbeatInterval:20];
    [self.socket connect];
    self.channel = [[PhxChannel alloc] initWithSocket:self.socket topic:[NSString stringWithFormat:@"cars:%@",self.entityCar.carId] params:@{}];
    
    [self.channel onEvent:@"new_msg" callback:^(id message, id ref) {
        NSLog(@"New Message Received: %@", message);
        NSString* user = [message valueForKey:@"username"];
        NSString* body = [message valueForKey:@"body"];
        if ([user isEqual:[NSNull null]]) {user = @"anonymous";}
        [self sendWatchMessage:message];
        [self.messages appendString:[NSString stringWithFormat:@" [%@] %@\n", user,body]];
        self.textView.text = self.messages;
        [self scrollTextViewToBottom:self.textView];
    }];
    
    [self.channel join];
}

- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// The callback for frame-changing of keyboard
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;
    
    NSLog(@"Updating constraints.");
    // Because the "space" is actually the difference between the bottom lines of the 2 views,
    // we need to set a negative constant value here.
    self.keyboardHeight.constant = height + 10;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.keyboardHeight.constant = 26;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (IBAction)dismissKeyboard:(id)sender {
    [self.textView resignFirstResponder];
}

- (IBAction)sendButton:(id)sender {
    [self sendMessage:self.message.text];
    
}

- (void)sendMessage:(NSString*)message {
    if ([message isEqualToString:@""]) {
        return;
    }
    NSString *user = self.username.text;
    if ([user isEqualToString:@""]) {user = @"anonymous";}
    [self.channel pushEvent:@"new_msg" payload:@{@"username":user, @"body":message}];
}

- (void)sendWatchMessage:(NSDictionary*)message {
    NSString *body = [message valueForKey:@"body"];
    NSString *user = [message valueForKey:@"username"];
    if (user == nil) {user = @"anonymous";}
    if (body == nil) {body = @"entered";}
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[body, user] forKeys:@[@"body", @"username"]];
    [self.session sendMessage:applicationData replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.message) {
        [self sendMessage:textField.text];
        self.message.text = @"";
        return NO;
    }
    return YES;
}

-(void)scrollTextViewToBottom:(UITextView *)textView {
    if(textView.text.length > 0) {
        NSRange bottom = NSMakeRange(textView.text.length -1, 1);
        [textView scrollRangeToVisible:bottom];
    }
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler {
    NSString *body = [message valueForKey:@"body"];
    
    //Use this to update the UI instantaneously (otherwise, takes a little while)
    dispatch_async(dispatch_get_main_queue(), ^{
        [self sendMessage:body];
    });
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
