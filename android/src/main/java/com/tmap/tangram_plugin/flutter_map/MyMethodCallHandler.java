package com.tmap.tangram_plugin.flutter_map;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public interface MyMethodCallHandler {

    public void doMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result);
    /**
     * 获取注册的{@link MethodCall#method}
     * @return
     */
    public abstract String[] getRegisterMethodIdArray();
}
