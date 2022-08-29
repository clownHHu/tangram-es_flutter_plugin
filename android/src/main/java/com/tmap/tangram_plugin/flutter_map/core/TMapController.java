package com.tmap.tangram_plugin.flutter_map.core;


import android.content.Context;
import android.graphics.PointF;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.mapzen.tangram.CameraPosition;
import com.mapzen.tangram.CameraUpdate;
import com.mapzen.tangram.CameraUpdateFactory;
import com.mapzen.tangram.FeaturePickListener;
import com.mapzen.tangram.FeaturePickResult;
import com.mapzen.tangram.LabelPickListener;
import com.mapzen.tangram.LabelPickResult;
import com.mapzen.tangram.LngLat;
import com.mapzen.tangram.MapChangeListener;
import com.mapzen.tangram.MapController;
import com.mapzen.tangram.MapData;
import com.mapzen.tangram.MapView;
import com.mapzen.tangram.Marker;
import com.mapzen.tangram.MarkerPickListener;
import com.mapzen.tangram.MarkerPickResult;
import com.mapzen.tangram.SceneError;
import com.mapzen.tangram.SceneUpdate;
import com.mapzen.tangram.TouchInput;
import com.mapzen.tangram.TouchInput.DoubleTapResponder;
import com.mapzen.tangram.TouchInput.LongPressResponder;
import com.mapzen.tangram.TouchInput.TapResponder;
import com.mapzen.tangram.networking.DefaultHttpHandler;
import com.mapzen.tangram.networking.HttpHandler;
import com.tmap.tangram_plugin.flutter_map.MyMethodCallHandler;
import com.tmap.tangram_plugin.flutter_map.tool.Const;
import com.tmap.tangram_plugin.flutter_map.tool.LogUtil;
import com.tmap.tangram_plugin.flutter_map.tool.PresetSelectionTextView;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import okhttp3.Cache;
import okhttp3.CacheControl;
import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Request;

public class TMapController implements MyMethodCallHandler,TMapOptionInterface, MapController.SceneLoadListener,
        TapResponder, DoubleTapResponder,LongPressResponder, FeaturePickListener, LabelPickListener, MarkerPickListener,
        MapView.MapReadyCallback{

    private static final String CLASS_NAME="MapController";
    private static String NEXTZEN_API_KEY=null;
    private static final String TAG = "TangramDemo";
    private boolean sceneReady=false;
    private MethodChannel.Result sceneReadyResult;
//    private static final String[] SCENE_PRESETS = {
//            "asset:///satellite-streets-style.yaml",
//            "asset:///satellite.yaml",
//            "asset:///huscene.yaml",
//            "https://www.nextzen.org/carto/bubble-wrap-style/9/bubble-wrap-style.zip",
//            "https://www.nextzen.org/carto/refill-style/11/refill-style.zip",
//            "https://www.nextzen.org/carto/walkabout-style/7/walkabout-style.zip",
//            "https://www.nextzen.org/carto/tron-style/6/tron-style.zip",
//            "https://www.nextzen.org/carto/cinnabar-style/9/cinnabar-style.zip"
//    };

    MapController map;
    MapView view;
    MapData mapData;
    List<LngLat> tappedPoints = new ArrayList<>();
    String pointStylingPath;
    ArrayList<Marker> pointMarkers = new ArrayList<>();
    boolean showTileInfo = false;
    private static final String FTAG = "TangramView";



    public TMapController(MapView view,MapController map) {
        this.view=view;
        this.map=map;
    }

    public void setKey(String key) {
        NEXTZEN_API_KEY=key;
        System.out.println((CLASS_NAME+"key:"+NEXTZEN_API_KEY));
    }


    @Override
    public void onMapReady(@Nullable MapController mapController) {
        if (mapController == null) {
            return;
        }
        System.out.println("onMapReady回调");
       //未回调
    }

    @Override
    public boolean onSingleTapUp(float x, float y) {
        return false;
    }

    @Override
    public boolean onSingleTapConfirmed(float x, float y) {
        LngLat tappedPoint = map.screenPositionToLngLat(new PointF(x, y));

        map.pickFeature(x, y);
        map.pickLabel(x, y);
        map.pickMarker(x, y);

        map.updateCameraPosition(CameraUpdateFactory.setPosition(tappedPoint), 1000, new MapController.CameraAnimationCallback() {
            @Override
            public void onFinish() {
                Log.d("Tangram","finished!");
            }

            @Override
            public void onCancel() {
                Log.d("Tangram","canceled!");
            }
        });

        return true;
    }

    @Override
    public boolean onDoubleTap(float x, float y) {

        LngLat tapped = map.screenPositionToLngLat(new PointF(x, y));

        Marker p = map.addMarker();
        p.setStylingFromPath(pointStylingPath);
        p.setPoint(tapped);
        pointMarkers.add(p);

        CameraPosition camera = map.getCameraPosition();

        camera.longitude = .5 * (tapped.longitude + camera.longitude);
        camera.latitude = .5 * (tapped.latitude + camera.latitude);
        camera.zoom += 1;
        map.updateCameraPosition(CameraUpdateFactory.newCameraPosition(camera),
                500, MapController.EaseType.CUBIC);
        return true;
    }

    @Override
    public void onLongPress(float x, float y) {
        map.removeAllMarkers();
        pointMarkers.clear();
        tappedPoints.clear();
        mapData.clear();
        showTileInfo = !showTileInfo;
        map.setDebugFlag(MapController.DebugFlag.TILE_INFOS, showTileInfo);
    }

    @Override
    public void onFeaturePickComplete(@Nullable final FeaturePickResult result) {
        if (result == null) {
            Log.d(TAG, "Empty selection");
            return;
        }

        String name = result.getProperties().get("name");
        if (name == null || name.isEmpty()) {
            name = "unnamed";
        }

        Log.d(TAG, "Picked: " + name);
        final String message = name;
        //Toast.makeText(getApplicationContext(), "Selected: " + message, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onLabelPickComplete(@Nullable final LabelPickResult result) {
        if (result == null) {
            Log.d(TAG, "Empty label selection");
            return;
        }

        String name = result.getProperties().get("name");
        if (name == null || name.isEmpty()) {
            name = "unnamed";
        }

        Log.d(TAG, "Picked label: " + name);
        final String message = name;
        // Toast.makeText(getApplicationContext(), "Selected label: " + message, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onMarkerPickComplete(@Nullable final MarkerPickResult result) {
        if (result == null) {
            Log.d(TAG, "Empty marker selection");
            return;
        }

        Log.d(TAG, "Picked marker: " + result.getMarker().getMarkerId());
        final String message = String.valueOf(result.getMarker().getMarkerId());
        //Toast.makeText(getApplicationContext(), "Selected Marker: " + message, Toast.LENGTH_SHORT).show();
    }




    @Override
    public void onSceneReady(int sceneId, SceneError sceneError) {
        //CameraPosition cameraPosition = map.getCameraPosition();
        sceneReady=true;
        if (null != sceneReadyResult) {
            sceneReadyResult.success(null);
            sceneReadyResult = null;
        }
        System.out.println("onSceneReady回调");
    }

    @Override
    public void doMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if(NEXTZEN_API_KEY!=null)
            if (null == view) {
                LogUtil.w(CLASS_NAME, "onMethodCall amap is null!!!");
                return;
            }
        switch (call.method) {
            case Const.METHOD_MAP_FLY_CAMERA:
                HashMap arguments = (HashMap) call.arguments;
                HashMap positionMap = (HashMap) arguments.get("cameraPosition");
                CameraPosition cameraPosition1=new CameraPosition();
                cameraPosition1.longitude= (double) positionMap.get("longitude");
                cameraPosition1.latitude= (double) positionMap.get("latitude");
                cameraPosition1.zoom= (float)((double) positionMap.get("zoom"));
                cameraPosition1.tilt= (float)((double) positionMap.get("tilt"));
                cameraPosition1.rotation= (float)((double) positionMap.get("rotation"));
                CameraPosition cameraPosition = map.getCameraPosition();

                if(cameraPosition1.latitude!=-999)
                    cameraPosition.latitude=cameraPosition1.latitude;
                if(cameraPosition1.longitude!=-999)
                    cameraPosition.longitude=cameraPosition1.longitude;
                if(cameraPosition1.tilt!=-999)
                    cameraPosition.tilt=cameraPosition1.tilt;
                if(cameraPosition1.zoom!=-999)
                    cameraPosition.zoom=cameraPosition1.zoom;
                if(cameraPosition1.rotation!=-999)
                    cameraPosition.rotation=cameraPosition1.rotation;

                flyToCameraPosition(cameraPosition);
                System.out.println((CLASS_NAME+"fly:"));
                result.success("fly");
                break;
            case Const.METHOD_MAP_ADD_MAKR:
                System.out.println(CLASS_NAME+"do:"+Const.METHOD_MAP_ADD_MAKR);
                result.success("mark");
                break;
            case Const.METHOD_MAP_SCENE_READY:
                if(sceneReady) {
                    result.success(null);
                    return;
                }
                sceneReadyResult = result;
                break;
            default:
                LogUtil.w(CLASS_NAME, "onMethodCall not find methodId:" + call.method);
                break;
        }
    }

    @Override
    public  String[] getRegisterMethodIdArray() {
        return Const.METHOD_ID_LIST_FOR_MAP;
    }

    @Override
    public void updateCameraPosition(@NonNull final CameraUpdate update) {
        map.updateCameraPosition(update);
    }

    @Override
    public void setCameraType(MapController.CameraType cameraType) {
        map.setCameraType(cameraType);
    }

    @Override
    public void setMapChangeListener(boolean setListener) {
        if(setListener)
            map.setMapChangeListener(new MapChangeListener() {
                @Override
                public void onViewComplete() {
                    System.out.println(CLASS_NAME+ "View complete");
                }

                @Override
                public void onRegionWillChange(boolean animated) {
                    System.out.println(CLASS_NAME+ "On Region Will Change Animated: " + animated);
                }

                @Override
                public void onRegionIsChanging() {
                    System.out.println(CLASS_NAME+ "On Region Is Changing");
                }

                @Override
                public void onRegionDidChange(boolean animated) {
                    System.out.println(CLASS_NAME+ "On Region Did Change Animated: " + animated);
                }
            });
    }

    @Override
    public void setSceneLoadListener(boolean setListener) {
        if(setListener)
            map.setSceneLoadListener(this);
    }

    @Override
    public void setTouchInput(boolean setTouchInput) {
        if(setTouchInput)
        {
            TouchInput touchInput = map.getTouchInput();
            touchInput.setTapResponder(this);
            touchInput.setDoubleTapResponder(this);
            touchInput.setLongPressResponder(this);
        }
    }

    @Override
    public void setFeaturePickListener(boolean setListener) {
        if(setListener)
            map.setFeaturePickListener(this);
    }

    @Override
    public void setLabelPickListener(boolean setListener) {
        if(setListener)
            map.setLabelPickListener(this);
    }

    @Override
    public void setMarkerPickListener(boolean setListener) {
        if(setListener)
            map.setMarkerPickListener(this);
    }

    @Override
    public void loadSceneFileAsync(String path, @Nullable List<SceneUpdate> sceneUpdates) {
        if (NEXTZEN_API_KEY.isEmpty() || NEXTZEN_API_KEY.equals("null")) {
            Log.w(TAG, "No API key found! Nextzen data sources require an API key.\n" +
                    "Sign up for a free key at https://developers.nextzen.org/ and set it\n" +
                    "in your local Gradle properties file (~/.gradle/gradle.properties)\n" +
                    "as 'nextzenApiKey=YOUR-API-KEY-HERE'");
        }
        else {
            //sceneUpdates.add(new SceneUpdate("global.sdk_api_key", NEXTZEN_API_KEY));
            map.loadSceneFileAsync(path, sceneUpdates);
        }

    }

    @Override
    public void addDataLayer(String datalayer) {
        mapData=map.addDataLayer(datalayer);
    }

    @Override
    public void setPickRadius(float radius) {
        map.setPickRadius(radius);
    }

    @Override
    public void setpointStylingPath(String pointStylingPath) {
        this.pointStylingPath=pointStylingPath;
    }

    @Override
    public void setPoint(LngLat point) {
        Marker p = map.addMarker();
        p.setStylingFromPath(pointStylingPath);
        p.setPoint(point);
        pointMarkers.add(p);
    }

    @Override
    public Marker getLocationMarker() {
        Marker marker = map.addMarker();
        String pointStyle = "{ style: 'points', color: 'white', size: [20px, 20px], order: 2000, collide: false, flat: true }";
        marker.setStylingFromString(pointStyle);
        return marker;
    }

    @Override
    public void flyToCameraPosition(@NonNull CameraPosition position){
        map.flyToCameraPosition(position,1000, new MapController.CameraAnimationCallback() {
            @Override
            public void onFinish() {
                System.out.println("flyToCameraPosition finish!");
            }

            @Override
            public void onCancel() {
                System.out.println("flyToCameraPosition cancel!");
            }
        });
    }

    @Override
    public CameraPosition getCameraPosition() {
        return map.getCameraPosition();
    }


    public static HttpHandler getHttpHandler(Context context) {
        OkHttpClient.Builder builder = DefaultHttpHandler.getClientBuilder();
        File cacheDir = context.getExternalCacheDir();
        if (cacheDir != null && cacheDir.exists()) {
            builder.cache(new Cache(cacheDir, 16 * 1024 * 1024));
        }

        return new DefaultHttpHandler(builder) {
            CacheControl tileCacheControl = new CacheControl.Builder().maxStale(7, TimeUnit.DAYS).build();
            @Override
            protected void configureRequest(HttpUrl url, Request.Builder builder) {
                if ("tile.nextzen.com".equals(url.host())) {
                    builder.cacheControl(tileCacheControl);
                }
            }
        };
    }


}
