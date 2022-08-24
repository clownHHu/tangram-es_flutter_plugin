package com.tmap.tangram_plugin.flutter_map;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.amap.api.location.AMapLocationClient;
import com.mapzen.tangram.CameraPosition;
import com.mapzen.tangram.CameraUpdate;
import com.mapzen.tangram.CameraUpdateFactory;
import com.mapzen.tangram.LngLat;
import com.mapzen.tangram.MapController;
import com.mapzen.tangram.SceneUpdate;
import com.tmap.tangram_plugin.flutter_map.core.TMapController;
import com.tmap.tangram_plugin.flutter_map.core.TMapOption;
import com.tmap.tangram_plugin.flutter_map.core.TMapOptionInterface;
import com.tmap.tangram_plugin.flutter_map.lifecycle.LifecycleProvider;
import com.tmap.tangram_plugin.flutter_map.tool.LogUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
            TMapController tMapController=tMapView.getMapController();
            tMapController.setKey(tMapOption.getKey());
            tMapController.loadSceneFileAsync(tMapOption.getPath(),tMapOption.getSceneUpdates());

            //调用高德定位
            AMapLocationClient.updatePrivacyShow(context,true,true);
            AMapLocationClient.updatePrivacyAgree(context,true);
            tMapOption.getaMapLocationClient().setLocationOption(tMapOption.getaMapLocationClientOption());
            tMapView.startLocation(tMapOption.getaMapLocationClient());

            /////////////对MapController属性初始化
            tMapController.addDataLayer(tMapOption.getDataLayer());
            tMapController.setpointStylingPath(tMapOption.getPointStylingPath());
            tMapController.setPoint(tMapOption.getStartPoint());

            //tMapController.updateCameraPosition(CameraUpdateFactory.newLngLatZoom(tMapOption.getStartPoint(),tMapOption.getStartZoom()));
            tMapController.setPickRadius(tMapOption.getPickRadius());
            tMapController.setMapChangeListener(tMapOption.isMapChangeListener());
            tMapController.setLabelPickListener(tMapOption.isLabelPickListener());
            tMapController.setSceneLoadListener(tMapOption.isSceneLoadListener());
            tMapController.setMarkerPickListener(tMapOption.isMarkerPickListener());
            tMapController.setFeaturePickListener(tMapOption.isFeaturePickListener());
            tMapController.setTouchInput(tMapOption.isTouchInput());


//            CameraPosition cameraPosition=new CameraPosition();
//            cameraPosition.latitude=0;
//            cameraPosition.longitude=0;
//            cameraPosition.rotation= 0;
//            cameraPosition.tilt=0;
//            cameraPosition.zoom=16;

//            CameraPosition cameraPosition=tMapController.getCameraPosition();
//            tMapController.flyToCameraPosition(cameraPosition);

            return tMapView;
        } catch (Exception e) {
            LogUtil.e(CLASS_NAME, "build", e);;
        }
        return null;
    }

}
