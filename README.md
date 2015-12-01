PhaxiOS
=======

A simple Objective-C library for Phaxio

##Requirements
[AFNetworking](https://github.com/AFNetworking/AFNetworking)

##Usage
You must set your api key and secret key before calling the service.
```obj-c
[PhaxioManager setPMAPIKey:API_KEY andPMAPISecret:API_SECRET];
```
###Send
```obj-c
[[PhaxioManager sharedInstance] send:fileData ofType:@"pdf" toNumber:@"5555555555" withOptions:params completion:^(id responseObject) {
    //Do something with the response
} failure:^(NSError *error) {
    //Handle the error
}];
```

###Fax Status
```obj-c
[[PhaxioManager sharedInstance] faxStatusForId:@"18826331" completion:^(id responseObject) {
    NSLog(@"%@", responseObject);
} failure:^(NSError *error) {
    NSLog(@"%@", error.localizedDescription);
}];
```

##Todo
1. Add cocoa pods support.
