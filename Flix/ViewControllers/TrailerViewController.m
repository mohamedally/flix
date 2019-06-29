//
//  TrailerViewController.m
//  Flix
//
//  Created by mudi on 6/28/19.
//  Copyright © 2019 mudi. All rights reserved.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *TrailerView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *urlString = [@"https://api.themoviedb.org/3/movie/" stringByAppendingString:[self.movie[@"id"] stringValue]
];
    NSString *fullUrlString = [urlString stringByAppendingString:@"/videos?api_key=2a86b5775a6179b1512a5f4512ff52aa"];
    NSURL *url = [NSURL URLWithString:fullUrlString];
    
    // Network request
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSString *videoKey = dataDictionary[@"results"][0][@"key"];
            
            NSString *trailerString = [@"https://www.youtube.com/watch?v=" stringByAppendingString:videoKey];
            
            NSURL *url = [NSURL URLWithString:trailerString];
            
            // Place thrvkdjgfkhtdfetlejnfncuvhuiglherde URL in a URL Request.
            NSURLRequest *request = [NSURLRequest requestWithURL:url
                                                     cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                 timeoutInterval:10.0];
            // Load Request into WebView.
            [self.TrailerView loadRequest:request];
    
            
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
        }
        
    }];
    [task resume];
}
- (IBAction)touchCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
