package com.tmap.tangram_plugin.flutter_map.core;

import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.mapzen.tangram.CameraPosition;
import com.mapzen.tangram.LngLat;
import com.mapzen.tangram.SceneUpdate;

import java.util.List;

public class TMapOption {
    private String path;
    private String tangramApikey;
    private String ampApikey;
    private String dataLayer;
    private String pointStylingPath;
    private List<SceneUpdate> sceneUpdates;
    private CameraPosition cameraPosition;
    private float pickRadius;
    private boolean mapChangeListener;
    private boolean labelPickListener;
    private boolean sceneLoadListener;
    private boolean markerPickListener;
    private boolean featurePickListener;
    private boolean touchInput;
    private boolean isLocation;
    private AMapLocationClientOption aMapLocationClientOption;
    private AMapLocationClient aMapLocationClient;


    public boolean isLocation() {
        return isLocation;
    }

    public void setLocation(boolean location) {
        this.isLocation = location;
    }

    public AMapLocationClient getaMapLocationClient() {
        return aMapLocationClient;
    }

    public void setaMapLocationClient(AMapLocationClient aMapLocationClient) {
        this.aMapLocationClient = aMapLocationClient;
    }

    public AMapLocationClientOption getaMapLocationClientOption() {
        return aMapLocationClientOption;
    }

    public void setaMapLocationClientOption(AMapLocationClientOption aMapLocationClientOption) {
        this.aMapLocationClientOption = aMapLocationClientOption;
    }

    public String getPointStylingPath() {
        return pointStylingPath;
    }

    public void setPointStylingPath(String pointStylingPath) {
        this.pointStylingPath = pointStylingPath;
    }

    public String getDataLayer() {
        return dataLayer;
    }

    public void setDataLayer(String dataLayer) {
        this.dataLayer = dataLayer;
    }

    public float getPickRadius() {
        return pickRadius;
    }

    public void setPickRadius(float pickRadius) {
        this.pickRadius = pickRadius;
    }

    public boolean isMapChangeListener() {
        return mapChangeListener;
    }

    public void setMapChangeListener(boolean mapChangeListener) {
        this.mapChangeListener = mapChangeListener;
    }

    public boolean isLabelPickListener() {
        return labelPickListener;
    }

    public void setLabelPickListener(boolean labelPickListener) {
        this.labelPickListener = labelPickListener;
    }

    public boolean isSceneLoadListener() {
        return sceneLoadListener;
    }

    public void setSceneLoadListener(boolean sceneLoadListener) {
        this.sceneLoadListener = sceneLoadListener;
    }

    public boolean isMarkerPickListener() {
        return markerPickListener;
    }

    public void setMarkerPickListener(boolean markerPickListener) {
        this.markerPickListener = markerPickListener;
    }

    public boolean isFeaturePickListener() {
        return featurePickListener;
    }

    public void setFeaturePickListener(boolean featurePickListener) {
        this.featurePickListener = featurePickListener;
    }

    public boolean isTouchInput() {
        return touchInput;
    }

    public void setTouchInput(boolean touchInput) {
        this.touchInput = touchInput;
    }




    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getTangramApikey() {
        return tangramApikey;
    }

    public void setTangramApikey(String tangramApikey) {
        this.tangramApikey = tangramApikey;
    }

    public String getAmpApikey() {
        return ampApikey;
    }

    public void setAmpApikey(String ampApikey) {
        this.ampApikey = ampApikey;
    }

    public List<SceneUpdate> getSceneUpdates() {
        return sceneUpdates;
    }

    public void setSceneUpdates(List<SceneUpdate> sceneUpdates) {
        this.sceneUpdates = sceneUpdates;
    }

    public CameraPosition getCameraPosition() {
        return cameraPosition;
    }

    public void setCameraPosition(CameraPosition cameraPosition) {
        this.cameraPosition = cameraPosition;
    }
}
