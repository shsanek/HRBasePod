//
//  HRCache.m
//  Pods
//
//  Created by Alexander Shipin on 31/08/2017.
//
//

#import "HRCache.h"

@interface HRCacheTask : NSObject

@property (nonatomic, strong) id key;
@property (nonatomic, strong) id obj;
@property (nonatomic, strong) NSMutableArray<void (^)(id obj,NSError*,BOOL)>* completionBlock;
@property (nonatomic, copy) void (^preemptiveBlock)(id obj,NSError*,BOOL);

@property (nonatomic, assign) NSInteger  size;
@property (nonatomic, assign) NSInteger lastCall;

@end

@implementation HRCacheTask


@end

@interface HRCache ()

@property (nonatomic, strong) NSMutableDictionary<id,HRCacheTask*>* dictioary;
@property (nonatomic, assign, readwrite) NSInteger currentSize;
@end

@implementation HRCache


- (instancetype) initWithWorkQueue:(dispatch_queue_t) workQueue
                           maxSize:(NSInteger) maxSize
                          delegate:(id<HRCacheDelegate>) delegate{
    self = [super init];
    if (self) {
        _workQueue = workQueue;
        _maxSize = maxSize;
        _delegate = delegate;
    }
    return self;
}

- (instancetype) initWithDelegate:(id<HRCacheDelegate>) delegate{
    self = [super init];
    if (self) {
        _workQueue = dispatch_get_main_queue();
        _maxSize = 0;
        _delegate = delegate;
    }
    return self;
    
}

- (instancetype) initWithMaxSize:(NSInteger) maxSize
                        delegate:(id<HRCacheDelegate>) delegate{
    self = [super init];
    if (self) {
        _workQueue = dispatch_get_main_queue();
        _maxSize = maxSize;
        _delegate = delegate;
    }
    return self;
}

- (id) requestObjectWithKey:(id) key
            completionBlock:(void (^)(id obj,NSError* error, BOOL firstLoad)) completionBlock{
    return [self requestObjectWithKey:key
                           preemptive:NO
                      completionBlock:completionBlock];
}

- (id) requestObjectWithKey:(id) key
                  preemptive:(BOOL) preemptive
            completionBlock:(void (^)(id obj,NSError* error, BOOL firstLoad)) completionBlock{
    id object = self.dictioary[key].obj;
    __weak typeof(self) weakSelf = self;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    if (object) {
        id obj = object;
        dispatch_async(self.workQueue, ^{
            weakSelf.dictioary[key].lastCall = time;
        });
        if (completionBlock) {
            completionBlock(obj,nil,NO);
        }
        return obj;
    }

    dispatch_async(self.workQueue, ^{
        weakSelf.dictioary[key].lastCall = time;
        if (weakSelf.dictioary[key].obj) {
            id obj = self.dictioary[key].obj;
            if (completionBlock) {
                completionBlock(obj,nil,NO);
            }
            return ;
        }
        if (weakSelf.dictioary[key]){
            if (completionBlock && !preemptive) {
                [weakSelf.dictioary[key].completionBlock addObject:completionBlock];
            } else if (completionBlock) {
                weakSelf.dictioary[key].preemptiveBlock = completionBlock;
            }
            return ;
        }
        HRCacheTask* task = [HRCacheTask new];
        if (completionBlock && !preemptive) {
            task.completionBlock = [@[completionBlock] mutableCopy];
        } else  {
            if (completionBlock) {
                task.preemptiveBlock = completionBlock;
            }
            task.completionBlock = [@[] mutableCopy];
        }
        
        
        task.key = key;
        task.lastCall = time;
        weakSelf.dictioary[key] = task;
        [weakSelf.delegate cache:weakSelf
               loadObjectWithKey:key
                 completionBlock:^(id obj, NSInteger size, NSError* error) {
                     [weakSelf loadObject:obj
                                 withTask:task
                                     size:size
                                    error:error];
               }];
    });
    return nil;
}

- (void) loadObject:(id) object withTask:(HRCacheTask*) task size:(NSInteger) size error:(NSError*) error {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.workQueue, ^{
        weakSelf.currentSize += size;
        task.size = size;
        if (object) {
            task.obj = object;
        } else {
            [self.dictioary removeObjectForKey:task];
        }
        for (void (^completionBlock)(id,NSError*,BOOL)  in task.completionBlock) {
            completionBlock(object,error,YES);
        }
        if (task.preemptiveBlock) {
            task.preemptiveBlock(object,error,YES);
        }
        
    });
}

- (NSMutableDictionary *)dictioary {
    if (!_dictioary) {
        _dictioary = [NSMutableDictionary new];
    }
    return _dictioary;
}

@end
