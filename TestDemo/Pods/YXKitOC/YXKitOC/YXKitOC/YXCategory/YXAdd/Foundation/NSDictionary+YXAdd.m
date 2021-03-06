//
//  NSDictionary+YXAdd.m
//  YXKitOC
//
//  Created by 张鑫 on 2020/1/10.`
//  Copyright © 2020 张鑫. All rights reserved.
//

#import "NSDictionary+YXAdd.h"
#import <YYCategories/NSDictionary+YYAdd.h>

@implementation NSDictionary (YXAdd)

/// 根据二进制数据创建Dictionary
+ (nullable NSDictionary *)yx_dictionaryWithPlistData:(NSData *)plist {
    return [NSDictionary dictionaryWithPlistData:plist];
}

/// 返回二进制数据
- (nullable NSData *)yx_plistData {
    return [self plistData];
}

/// 返回排序（上升）后的所有Key集合
- (NSArray *)yx_allKeysSorted {
    return [self allKeysSorted];
}

/// 返回排序（上升）后的所有Value集合
- (NSArray *)yx_allValuesSortedByKeys {
    return [self allValuesSortedByKeys];
}

/// 是否包含Key
- (BOOL)yx_containsObjectForKey:(id)key {
    return [self containsObjectForKey:key];
}

/// 返回匹配keys的新NSDictionary
- (NSDictionary *)yx_entriesForKeys:(NSArray *)keys {
    return [self entriesForKeys:keys];
}

/// NSDictionary转Json(String)
- (nullable NSString *)yx_jsonStringEncoded {
    return [self jsonStringEncoded];
}

/// NSDictionary转String（格式化的）
- (nullable NSString *)yx_jsonPrettyStringEncoded {
    return [self jsonPrettyStringEncoded];
}

/** 根据Key返回指定类型的Value，error时取default值 */
- (BOOL)yx_boolValueForKey:(NSString *)key default:(BOOL)def {
    return [self boolValueForKey:key default:def];
}

- (int)yx_intValueForKey:(NSString *)key default:(int)def {
    return [self intValueForKey:key default:def];
}

- (long)yx_longValueForKey:(NSString *)key default:(long)def {
    return [self longValueForKey:key default:def];
}

- (float)yx_floatValueForKey:(NSString *)key default:(float)def {
    return [self floatValueForKey:key default:def];
}

- (double)yx_doubleValueForKey:(NSString *)key default:(double)def {
    return [self doubleValueForKey:key default:def];
}

- (NSInteger)yx_integerValueForKey:(NSString *)key default:(NSInteger)def {
    return [self integerValueForKey:key default:def];
}

- (nullable NSNumber *)yx_numberValueForKey:(NSString *)key default:(nullable NSNumber *)def {
    return [self yx_numberValueForKey:key default:def];
}

- (nullable NSString *)yx_stringValueForKey:(NSString *)key default:(nullable NSString *)def {
    return [self stringValueForKey:key default:def];
}

#pragma mark - Block

/**
 循环遍历字典
 */
- (void)yx_each:(void (^)(id key, id obj))block {
    [self yx_each:block];
}
/**
 遍历执行block会分配在多核cpu上执行
 */
- (void)yx_apply:(void (^)(id key, id obj))block {
    [self yx_apply:block];
}
/**
 循环遍历字典以查找与块匹配的第一个键/值对。
 */
- (id)yx_match:(BOOL (^)(id key, id obj))block {
    return [self yx_match:block];
}
/**
 循环遍历字典以查找与块匹配的键/值对。
 */
- (NSDictionary *)yx_select:(BOOL (^)(id key, id obj))block {
    return [self yx_select:block];
}
/**
 循环遍历字典以查找与块不匹配的键/值对。
 */
- (NSDictionary *)yx_reject:(BOOL (^)(id key, id obj))block {
    return [self yx_reject:block];
}
/**
 返回一个新的字典，block传入参数位置与原数组参数位置一一对应
 */
- (NSDictionary *)yx_map:(id (^)(id key, id obj))block {
    return [self yx_map:block];
}
/**
 循环遍历字典以查找是否有任何键/值对与块匹配。
 */
- (BOOL)yx_any:(BOOL (^)(id key, id obj))block {
    return [self yx_any:block];
}
/**
 循环遍历字典以查找是否没有键/值对与块匹配。
 */
- (BOOL)yx_none:(BOOL (^)(id key, id obj))block {
    return [self yx_none:block];
}

/**
 循环遍历字典以查找是否所有键/值对都与块匹配。
 */
- (BOOL)yx_all:(BOOL (^)(id key, id obj))block {
    return [self yx_all:block];
}

@end
