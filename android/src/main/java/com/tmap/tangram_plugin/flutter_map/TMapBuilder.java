package com.tmap.tangram_plugin.flutter_map;

import android.content.Context;

import com.mapzen.tangram.LngLat;
import com.tmap.tangram_plugin.flutter_map.core.TMapController;
import com.tmap.tangram_plugin.flutter_map.base.TMapOption;
import com.tmap.tangram_plugin.flutter_map.lifecycle.LifecycleProvider;
import com.tmap.tangram_plugin.flutter_map.tool.LogUtil;

import io.flutter.plugin.common.BinaryMessenger;

public class TMapBuilder {
    private static final String CLASS_NAME="TMapBuilder";

    TMapView build(int id,
                   Context context,
                   BinaryMessenger binaryMessenger,
                   LifecycleProvider lifecycleProvider,
                   TMapOption tMapOption){
        try{
            final TMapView tMapView = new TMapView(id, context, binaryMessenger, lifecycleProvider);

            //请求渲染
            TMapController tMapController=tMapView.getTMapController();
            tMapController.setKey(tMapOption.getTangramApikey());
            tMapController.loadSceneFileAsync(tMapOption.getPath(),tMapOption.getSceneUpdates());

            //调用高德定位
            tMapOption.getaMapLocationClient().setLocationOption(tMapOption.getaMapLocationClientOption());
            tMapView.initLocation(tMapOption.getaMapLocationClient());
            if(tMapOption.isLocation())
                tMapView.startLocation();
            /////////////对MapController属性初始化
            tMapController.addDataLayer(tMapOption.getDataLayer());
            tMapController.setpointStylingPath(tMapOption.getPointStylingPath());
            LngLat lngLat=tMapOption.getCameraPosition().getPosition();
            tMapController.setPoint(lngLat);


            tMapController.setPickRadius(tMapOption.getPickRadius());
            tMapController.setMapChangeListener(tMapOption.isMapChangeListener());
            tMapController.setLabelPickListener(tMapOption.isLabelPickListener());
            tMapController.setSceneLoadListener(tMapOption.isSceneLoadListener());
            tMapController.setMarkerPickListener(tMapOption.isMarkerPickListener());
            tMapController.setFeaturePickListener(tMapOption.isFeaturePickListener());
            tMapController.setTouchInput(tMapOption.isTouchInput());


            return tMapView;
        } catch (Exception e) {
            LogUtil.e(CLASS_NAME, "build", e);;
        }
        return null;
    }

}
