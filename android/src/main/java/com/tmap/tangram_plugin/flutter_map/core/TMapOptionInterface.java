package com.tmap.tangram_plugin.flutter_map.core;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mapzen.tangram.CameraPosition;
import com.mapzen.tangram.CameraUpdate;
import com.mapzen.tangram.CameraUpdateFactory;
import com.mapzen.tangram.FeaturePickResult;
import com.mapzen.tangram.LabelPickResult;
import com.mapzen.tangram.LngLat;
import com.mapzen.tangram.MapController;
import com.mapzen.tangram.MapData;
import com.mapzen.tangram.Marker;
import com.mapzen.tangram.MarkerPickResult;
import com.mapzen.tangram.SceneUpdate;
import com.mapzen.tangram.TouchInput;
import com.mapzen.tangram.networking.HttpHandler;

import java.util.List;

public interface TMapOptionInterface {

    void updateCameraPosition(@NonNull final CameraUpdate update);
    void setCameraType(MapController.CameraType cameraType);
    void setMapChangeListener(boolean setListener);
    void setSceneLoadListener(boolean setListener);
    void setTouchInput(boolean setTouchInput);
    void setFeaturePickListener(boolean setListener);
    void setLabelPickListener(boolean setListener);
    void setMarkerPickListener(boolean setListener);
    void loadSceneFileAsync(final String path, @Nullable final List<SceneUpdate> sceneUpdates);
    void addDataLayer(String datalayer);
    void setPickRadius(final float radius);
    void setpointStylingPath(String pointStylingPath);
    void setPoint(LngLat point);
    Marker getLocationMarker();
    void flyToCameraPosition(CameraPosition position);
    CameraPosition getCameraPosition();

}
