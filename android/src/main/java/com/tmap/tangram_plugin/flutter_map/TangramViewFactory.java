package com.tmap.tangram_plugin.flutter_map;

import android.app.Activity;
import android.content.Context;

import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.mapzen.tangram.CameraPosition;
import com.mapzen.tangram.CameraUpdateFactory;
import com.mapzen.tangram.LngLat;
import com.mapzen.tangram.SceneUpdate;
import com.tmap.tangram_plugin.flutter_map.core.TMapOption;
import com.tmap.tangram_plugin.flutter_map.lifecycle.LifecycleProvider;
import com.tmap.tangram_plugin.flutter_map.tool.LngLatConverterUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

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
        Map<String, Object> options=new HashMap<>();
        final TMapBuilder builder = new TMapBuilder();
        TMapOption tMapOption=new TMapOption();
        if(params.containsKey("privacyStatement")){
            options= (Map<String, Object>) params.get("privacyStatement");
            AMapLocationClient.updatePrivacyShow(context,  (Boolean) options.get("hasContains"),(Boolean) options.get("hasShow"));
            AMapLocationClient.updatePrivacyAgree(context, (Boolean) options.get("hasAgree"));
        }
        if(params.containsKey("tangramApiKey")){
            options= (Map<String, Object>) params.get("tangramApiKey");
            tMapOption.setTangramApikey((String) options.get("androidKey"));
        }
        if(params.containsKey("ampApiKey")){
            options= (Map<String, Object>) params.get("ampApiKey");
            tMapOption.setAmpApikey((String) options.get("androidKey"));
        }
        if(params.containsKey("options")){
            options= (Map<String, Object>) params.get("options");
            tMapOption.setPath((String) options.get("scenePath"));
            tMapOption.setPickRadius((float)(double) options.get("pickRadius"));
            tMapOption.setFeaturePickListener((Boolean) options.get("isFeaturePickListener"));
            tMapOption.setLabelPickListener((Boolean) options.get("isLabelPickListener"));
            tMapOption.setMapChangeListener((Boolean) options.get("isMapChangeListener"));
            tMapOption.setMarkerPickListener((Boolean) options.get("isMarkerPickListener"));
            tMapOption.setTouchInput((Boolean) options.get("isTouchInput"));
            tMapOption.setSceneLoadListener((Boolean) options.get("isSceneLoadListener"));
            tMapOption.setSceneLoadListener((Boolean) options.get("isSceneLoadListener"));
            tMapOption.setDataLayer((String) options.get("dataLayer"));
            tMapOption.setPointStylingPath((String) options.get("pointStylingPath"));
            tMapOption.setLocation((Boolean) options.get("isLocation"));
            if(tMapOption.isLocation())
            {
                AMapLocationClientOption aMapLocationClientOption=new AMapLocationClientOption();
                aMapLocationClientOption.setNeedAddress((Boolean) options.get("isNeedAddress"));
                switch ((Integer) options.get("LocationMode")){
                    case 0:
                        aMapLocationClientOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);
                        break;
                    case 1:
                        aMapLocationClientOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Device_Sensors);
                        break;
                    case 2:
                        aMapLocationClientOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Battery_Saving);
                        break;
                    default:
                        aMapLocationClientOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);
                }
                aMapLocationClientOption.setInterval((Integer)options.get("interval"));
                tMapOption.setaMapLocationClientOption(aMapLocationClientOption);
                try {
                    AMapLocationClient aMapLocationClient=new AMapLocationClient(context);
                    aMapLocationClient.setApiKey(tMapOption.getAmpApikey());
                    //aMapLocationClient.setLocationOption(aMapLocationClientOption);
                    tMapOption.setaMapLocationClient(aMapLocationClient);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        if(params.containsKey("cameraPosition")){
            options= (Map<String, Object>) params.get("cameraPosition");
            CameraPosition cameraPosition=new CameraPosition();
            ArrayList latlng= (ArrayList) options.get("latlng");
            cameraPosition.latitude=(double) latlng.get(0);
            cameraPosition.longitude=(double)latlng.get(1);
            cameraPosition.tilt= (float) (double)options.get("tilt");
            cameraPosition.zoom= (float) (double)options.get("zoom");
            cameraPosition.rotation= (float) (double)options.get("rotation");
            tMapOption.setCameraPosition(cameraPosition);
        }


        if (!tMapOption.getTangramApikey().isEmpty()&&!tMapOption.getPath().isEmpty()){
            ArrayList<SceneUpdate> sceneUpdates = new ArrayList<>();
            sceneUpdates.add(new SceneUpdate("global.sdk_api_key", tMapOption.getTangramApikey()));
            tMapOption.setSceneUpdates(sceneUpdates);
        }


        return builder.build(id, context, messenger, lifecycleProvider,tMapOption);
    }

}

