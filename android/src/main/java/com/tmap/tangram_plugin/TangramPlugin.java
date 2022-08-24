package com.tmap.tangram_plugin;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference;

import android.app.Activity;


import com.tmap.tangram_plugin.flutter_map.MyMethodCallHandler;
import com.tmap.tangram_plugin.flutter_map.TangramViewFactory;
import com.tmap.tangram_plugin.flutter_map.lifecycle.LifecycleProvider;
import com.tmap.tangram_plugin.flutter_map.lifecycle.ProxyLifecycleProvider;
import com.tmap.tangram_plugin.flutter_map.tool.LogUtil;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.platform.PlatformViewRegistry;

public class TangramPlugin implements FlutterPlugin,ActivityAware {
  private static final String CLASS_NAME="TangramPlugin";
  private Lifecycle lifecycle;
  private static final String VIEW_TYPE = "flutter_map/view";
  private PlatformViewRegistry platformViewRegistry;
  private FlutterPluginBinding pluginBinding;
//  private MethodChannel channel;

  public static void registerWith(PluginRegistry.Registrar registrar){
    LogUtil.i(CLASS_NAME, "registerWith=====>");

    final Activity activity = registrar.activity();
    if (activity == null) {
      LogUtil.w(CLASS_NAME, "activity is null!!!");
      return;
    }
    if (activity instanceof LifecycleOwner) {
      registrar
              .platformViewRegistry()
              .registerViewFactory(
                      VIEW_TYPE,
                      new TangramViewFactory(
                              registrar.messenger(),
                              new LifecycleProvider() {
                                @Override
                                public Lifecycle getLifecycle() {
                                  return ((LifecycleOwner) activity).getLifecycle();
                                }
                              }));
    } else {
      registrar
              .platformViewRegistry()
              .registerViewFactory(
                      VIEW_TYPE,
                      new TangramViewFactory(registrar.messenger(), new ProxyLifecycleProvider(activity)));
    }
  }


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    LogUtil.i(CLASS_NAME, "onAttachedToEngine==>");
    pluginBinding = flutterPluginBinding;
    flutterPluginBinding
            .getPlatformViewRegistry()
            .registerViewFactory(
                    VIEW_TYPE,
                    new TangramViewFactory(
                            flutterPluginBinding.getBinaryMessenger(),
                            new LifecycleProvider() {
                              @Nullable
                              @Override
                              public Lifecycle getLifecycle() {
                                return lifecycle;
                              }
                            }));

  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    LogUtil.i(CLASS_NAME, "onDetachedFromEngine==>");
    pluginBinding = null;
  }


  // ActivityAware
  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
//    Activity activity = binding.getActivity();
//    platformViewRegistry.registerViewFactory(VIEW_TYPE, new TangramViewFactory(messenger, activity));


      LogUtil.i(CLASS_NAME, "onAttachedToActivity==>");
      lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);

  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    LogUtil.i(CLASS_NAME, "onDetachedFromActivityForConfigChanges==>");
    this.onDetachedFromActivity();
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    LogUtil.i(CLASS_NAME, "onReattachedToActivityForConfigChanges==>");
    onAttachedToActivity(binding);
  }

  @Override
  public void onDetachedFromActivity() {
    LogUtil.i(CLASS_NAME, "onDetachedFromActivity==>");
    lifecycle = null;
  }


//  @Override
//  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
//    switch (call.method){
//      case "a":break;
//      default:System.out.println(call.method);
//    }
//
//  }
}

