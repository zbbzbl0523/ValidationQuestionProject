//
//  DocumentSaveController.m
//  testproject
//
//  Created by bolang on 2020/6/9.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "DocumentSaveController.h"

@interface DocumentSaveController ()

@end

@implementation DocumentSaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self saveButton];
    [self cleanButton];
    [self savepdfButton];
    [self checkExiextButton];
    // Do any additional setup after loading the view.
}

- (void)saveButton{
    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 100)];
    [showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showButton setTitle:@"保存到tmp中" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(saveToTmp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton];
}

- (void)cleanButton{
    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 200, 100)];
    [showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showButton setTitle:@"tmp中全清除了" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(clearFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton];
}

- (void)savepdfButton{
    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, 200, 100)];
    [showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showButton setTitle:@"将pdf缓存到tmp中" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(savePDF) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton];
}

- (void)checkExiextButton{
    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 500, 200, 100)];
    [showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showButton setTitle:@"查看文件是否存在" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(checkExi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton];
}

- (void)saveToTmp{
    //如果已经连接Xcode调试则不输出到文件
    if (isatty(STDOUT_FILENO)) {
        return;
    }
    
    //判定如果是模拟器就不输出
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model]hasSuffix:@"Simulator"]) {
        return;
    }
    
    //以下是获取沙盒Document目录的方法
    //将需要保存的信息 保存到Document目录下的Log文件夹下
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //
    NSString *tmpDir = NSTemporaryDirectory();
    
    //设置存放的路径。以”/“来区分文件夹的名字
    
    NSArray *dirArray = @[@"carSealDoc",@"carRepaire"];
    
    for (NSString *abc in dirArray) {
        NSString *logDirectory = [tmpDir stringByAppendingPathComponent:abc];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
        if (!fileExists) {
            NSError *error = nil;
            [fileManager createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"error = %@",[error localizedDescription]);
            }
        }
    }
    
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    //每次启动都保存一个新的日志文件中
//    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"abc.log"];
//
//    //    NSData *data = [NSData dataWithContentsOfFile:logFilePath];
//    //    NSString *fileData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSString *fileData = [NSString stringWithContentsOfFile:logFilePath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"打印写入的内容---》%@",fileData);
}

- (void)clearFile{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tmpDir = NSTemporaryDirectory();
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:tmpDir];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [tmpDir stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

- (void)savePDF{
    // 获取本地PDF
    NSURL *PDFUrl = [[NSBundle mainBundle] URLForResource:@"计算机" withExtension:@"pdf"];
    // 将PDF转换成NSData文件
    NSData *pdfData = [NSData dataWithContentsOfURL:PDFUrl];
    
    NSString *cachesPath = [self filePathWithKey:@"计算机.pdf"];
    
    BOOL result = [pdfData writeToFile:cachesPath atomically:YES];
    if (result) {
        NSLog(@"缓存成功");
    }
    
}

- (NSString *)filePathWithKey:(NSString *)key {
    NSString *tmpDir = NSTemporaryDirectory();
    NSString *logDirectory = [tmpDir stringByAppendingPathComponent:@"carSealDoc"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"error = %@",[error localizedDescription]);
        }
    }
    NSString *cachesPath = [tmpDir stringByAppendingPathComponent:key];
    return cachesPath;
}

- (void)checkExi{
    // 判读缓存数据是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self filePathWithKey:@"计算机.pdf"]]) {
        // 读取缓存数据
        [NSData dataWithContentsOfFile:[self filePathWithKey:@"计算机.pdf"]];
    }else{
        NSLog(@"123");
    }
}

@end
