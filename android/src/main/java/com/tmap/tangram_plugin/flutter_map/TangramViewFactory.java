package com.tmap.tangram_plugin.flutter_map;

import android.app.Activity;
import android.content.Context;

import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.mapzen.tangram.CameraUpdateFactory;
import com.mapzen.tangram.LngLat;
import com.mapzen.tangram.SceneUpdate;
import com.tmap.tangram_plugin.flutter_map.core.TMapOption;
import com.tmap.tangram_plugin.flutter_map.lifecycle.LifecycleProvider;
import com.tmap.tangram_plugin.flutter_map.tool.LngLatConverterUtil;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;



public class TangramViewFactory extends PlatformViewFactory {

    private static final String CLASS_NAME = "TangramViewFactory";
    private final BinaryMessenger messenger;
    private final LifecycleProvider lifecycleProvider;

    public TangramViewFactory(BinaryMessenger binaryMessenger,
                              LifecycleProvider lifecycleProvider) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = binaryMessenger;
        this.lifecycleProvider = lifecycleProvider;
    }

    @Override
    public PlatformView create(Context context, int id, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;

        final TMapBuilder builder = new TMapBuilder();
        TMapOption tMapOption=new TMapOption();

        if (params.containsKey("TangramKey")) {
            tMapOption.setKey((String) params.get("TangramKey"));
        }
        if (params.containsKey("scenePath")){
            tMapOption.setPath((String) params.get("scenePath"));
        }
        if (!tMapOption.getKey().isEmpty()&&!tMapOption.getPath().isEmpty()){
            ArrayList<SceneUpdate> sceneUpdates = new ArrayList<>();
            sceneUpdates.add(new SceneUpdate("global.sdk_api_key", tMapOption.getKey()));
            tMapOption.setSceneUpdates(sceneUpdates);
        }
        if (params.containsKey("latitude")&&params.containsKey("longitude")){
            LngLat startPoint = new LngLat((Double) params.get("longitude"), (Double)params.get("latitude"));
            tMapOption.setStartPoint(startPoint);
        }
        if (params.containsKey("zoom")){
            tMapOption.setStartZoom((float)(double) params.get("zoom"));
        }
        if (params.containsKey("pickRadius")){
            tMapOption.setPickRadius((float)(double) params.get("pickRadius"));
        }
        if (params.containsKey("isFeaturePickListener")){
            tMapOption.setFeaturePickListener((Boolean) params.get("isFeaturePickListener"));
        }
        if (params.containsKey("isLabelPickListener")){
            tMapOption.setLabelPickListener((Boolean) params.get("isLabelPickListener"));
        }
        if (params.containsKey("isMapChangeListener")){
            tMapOption.setMapChangeListener((Boolean) params.get("isMapChangeListener"));
        }
        if (params.containsKey("isMarkerPickListener")){
            tMapOption.setMarkerPickListener((Boolean) params.get("isMarkerPickListener"));
        }
        if (params.containsKey("isTouchInput")){
            tMapOption.setTouchInput((Boolean) params.get("isTouchInput"));
        }
        if (params.containsKey("isSceneLoadListener")){
            tMapOption.setSceneLoadListener((Boolean) params.get("isSceneLoadListener"));
        }
        if (params.containsKey("isSceneLoadListener")){
            tMapOption.setSceneLoadListener((Boolean) params.get("isSceneLoadListener"));
        }
        if (params.containsKey("dataLayer")){
            tMapOption.setDataLayer((String) params.get("dataLayer"));
        }
        if (params.containsKey("pointStylingPath")){
            tMapOption.setPointStylingPath((String) params.get("pointStylingPath"));
        }
        if (params.containsKey("isLocation")){
            tMapOption.setLocation((Boolean) params.get("isLocation"));
            if(tMapOption.isLocation())
            {
                AMapLocationClientOption aMapLocationClientOption=new AMapLocationClientOption();
                aMapLocationClientOption.setNeedAddress((Boolean) params.get("isNeedAddress"));
                switch ((String)params.get("LocationMode")){
                    case "High":
                        aMapLocationClientOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);
                        break;
                    case "Medium":
                        aMapLocationClientOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Device_Sensors);
                        break;
                    case "Low":
                        aMapLocationClientOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Battery_Saving);
                        break;
                    default:
                        aMapLocationClientOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);
                }
                aMapLocationClientOption.setInterval((int)params.get("interval"));
                tMapOption.setaMapLocationClientOption(aMapLocationClientOption);
                try {
                    AMapLocationClient aMapLocationClient=new AMapLocationClient(context);
                    aMapLocationClient.setApiKey((String) params.get("ampApiKey"));
                    //aMapLocationClient.setLocationOption(aMapLocationClientOption);
                    tMapOption.setaMapLocationClient(aMapLocationClient);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        return builder.build(id, context, messenger, lifecycleProvider,tMapOption);
    }

}

