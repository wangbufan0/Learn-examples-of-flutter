package com.example.flutter_to_bative.textview_java;

/**
 * @ProjectName: flutter_to_bative
 * @Package: com.example.flutter_to_bative.textview_java
 * @ClassName: MyViewFactory
 * @Author: wangbufan
 * @CreateDate: 2019/12/13 23:46
 * @Description: java类作用描述
 */

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class MyViewFactory extends PlatformViewFactory {
    private final BinaryMessenger messenger;

    public MyViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @SuppressWarnings("unchecked")
    @Override
    public PlatformView create(Context context, int id, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;
        return new MyView(context, messenger, id, params);
    }
}