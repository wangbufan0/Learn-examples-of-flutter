package com.example.flutter_to_bative.textview_java;

import io.flutter.plugin.common.PluginRegistry;

/**
 * @ProjectName: flutter_to_bative
 * @Package: com.example.flutter_to_bative.textview_java
 * @ClassName: MyViewFlutterPlugin
 * @Author: wangbufan
 * @CreateDate: 2019/12/13 23:47
 * @Description: java类作用描述
 */
public class MyViewFlutterPlugin {
    public static void registerWith(PluginRegistry registry) {
        final String key = MyViewFlutterPlugin.class.getCanonicalName();

        if (registry.hasPlugin(key)) return;

        PluginRegistry.Registrar registrar = registry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("plugins.nightfarmer.top/myview", new MyViewFactory(registrar.messenger()));
    }
}
