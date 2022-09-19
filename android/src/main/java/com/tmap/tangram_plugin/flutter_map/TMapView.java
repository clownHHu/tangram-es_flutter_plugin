package com.tmap.tangram_plugin.flutter_map;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.LifecycleOwner;

import com.amap.api.location.AMapLocation;
import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationListener;
import com.mapzen.tangram.CameraUpdateFactory;
import com.mapzen.tangram.LngLat;
import com.mapzen.tangram.MapController;
import com.mapzen.tangram.MapData;
import com.mapzen.tangram.MapView;
import com.mapzen.tangram.Marker;
import com.mapzen.tangram.SceneError;
import com.mapzen.tangram.geometry.Point;
import com.mapzen.tangram.networking.DefaultHttpHandler;
import com.mapzen.tangram.networking.HttpHandler;
import com.mapzen.tangram.viewholder.GLSurfaceViewHolderFactory;
import com.tmap.tangram_plugin.R;
import com.tmap.tangram_plugin.flutter_map.base.TMapLocation;
import com.tmap.tangram_plugin.flutter_map.core.TMapController;
import com.tmap.tangram_plugin.flutter_map.lifecycle.LifecycleProvider;
import com.tmap.tangram_plugin.flutter_map.tool.Const;
import com.tmap.tangram_plugin.flutter_map.tool.LngLatConverterUtil;
import com.tmap.tangram_plugin.flutter_map.tool.LogUtil;
import com.tmap.tangram_plugin.flutter_map.tool.Sha1;

import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;
import okhttp3.Cache;
import okhttp3.CacheControl;
import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Request;

public class TMapView implements DefaultLifecycleObserver, ActivityPluginBinding.OnSaveInstanceStateListener, MethodChannel.MethodCallHandler, PlatformView, AMapLocationListener,MyMethodCallHandler {
    private final Map<String, MyMethodCallHandler> myMethodCallHandlerMap;
    private static final String CLASS_NAME="TMapView";
    private final MethodChannel methodChannel;
    private TMapController mapController;
    private MapView view;
    private Context context;
    private boolean disposed = false;
    private TMapLocation tMapLocation=new TMapLocation();
    //声明AMapLocationClient类对象
    private AMapLocationClient mlocationClient = null;

    TMapView(int id,
                     Context context,
                     BinaryMessenger binaryMessenger,
             LifecycleProvider lifecycleProvider
                     ) {
        methodChannel = new MethodChannel(binaryMessenger, "test/channel");
        methodChannel.setMethodCallHandler(this);
        myMethodCallHandlerMap = new HashMap<String, MyMethodCallHandler>();

        try {
            view = new MapView(context);
            view.onCreate(new Bundle());
            this.context=context;
            //map=view.initMapController(new GLSurfaceViewHolderFactory(), TMapController.getHttpHandler(context));
            mapController = new TMapController(methodChannel,view, view.initMapController(new GLSurfaceViewHolderFactory(), TMapController.getHttpHandler(context)));
//            markersController = new MarkersController(methodChannel, amap);
//            polylinesController = new PolylinesController(methodChannel, amap);
//            polygonsController = new PolygonsController(methodChannel, amap);
            initMyMethodCallHandlerMap();

            //获取sha1值，获取高德定位时用
            //final String s=Sha1.getSha1(context);
            //startLoction();

            lifecycleProvider.getLifecycle().addObserver(this);
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "<init>", e);
        }
    }


    public void initLocation(AMapLocationClient mlocationClient) {
        this.mlocationClient=mlocationClient;
        this.mlocationClient.setLocationListener(this);
        tMapLocation.setInitAltitude(-200);
        tMapLocation.setMaxAltitude(-666);
        tMapLocation.setMinAltitude(6666);
    }
    public void startLocation(){
        mlocationClient.startLocation();
        tMapLocation.setLocationFlag(true);
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String methodId = call.method;
        if (myMethodCallHandlerMap.containsKey(methodId)) {
            myMethodCallHandlerMap.get(methodId).doMethodCall(call, result);
        } else {
            result.notImplemented();
        }
    }

    @Nullable
    @Override
    public View getView() {
        LogUtil.i(CLASS_NAME, "getView==>");
        return view;
    }

    @Override
    public void dispose() {
        LogUtil.i(CLASS_NAME, "dispose==>");
        try {
            if (disposed) {
                return;
            }
            methodChannel.setMethodCallHandler(null);
            view=null;
            disposed = true;
            tMapLocation=null;
            mlocationClient=null;
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "dispose", e);
        }
    }
    private void initMyMethodCallHandlerMap() {
        String[] methodIdArray = mapController.getRegisterMethodIdArray();
        if (null != methodIdArray && methodIdArray.length > 0) {
            for (String methodId : methodIdArray) {
                myMethodCallHandlerMap.put(methodId, mapController);
            }
        }
        methodIdArray=this.getRegisterMethodIdArray();
        if (null != methodIdArray && methodIdArray.length > 0) {
            for (String methodId : methodIdArray) {
                myMethodCallHandlerMap.put(methodId,this);
            }
        }
    }
    public TMapController getTMapController() {
        return mapController;
    }

    @Override
    public void onSaveInstanceState(@NonNull Bundle bundle) {
        LogUtil.i(CLASS_NAME, "onDestroy==>");
        try {
            if (disposed) {
                return;
            }
            //暂未实现
            //view.onSaveInstanceState(bundle);
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onSaveInstanceState", e);
        }

    }

    @Override
    public void onRestoreInstanceState(@Nullable Bundle bundle) {
        LogUtil.i(CLASS_NAME, "onDestroy==>");
        try {
            if (disposed) {
                return;
            }
            view.onCreate(bundle);
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onRestoreInstanceState", e);
        }

    }
    @Override
    public void onCreate(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onCreate==>");
        try {
            if (disposed) {
                return;
            }
            if (null != view) {
                view.onCreate(null);
            }
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onCreate", e);
        }
    }

    @Override
    public void onStart(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onStart==>");
    }

    @Override
    public void onResume(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onResume==>");
        try {
            if (disposed) {
                return;
            }
            if (null != view) {
                view.onResume();
                mlocationClient.startLocation();
                tMapLocation.setLocationFlag(true);
            }
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onResume", e);
        }
    }

    @Override
    public void onPause(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onPause==>");
        try {
            if (disposed) {
                return;
            }
            view.onPause();
            mlocationClient.stopLocation();
            tMapLocation.setLocationFlag(false);

        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onPause", e);
        }
    }

    @Override
    public void onStop(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onStop==>");
        try {
            if (disposed) {
                return;
            }
            view.onPause();
            mlocationClient.stopLocation();
            tMapLocation.setLocationFlag(false);

        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onStop", e);
        }
    }

    @Override
    public void onDestroy(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onDestroy==>");
        try {
            if (disposed) {
                return;
            }
            destroyMapViewIfNecessary();
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onDestroy", e);
        }
    }
    private void destroyMapViewIfNecessary() {
        if (view == null) {
            return;
        }
        mlocationClient.onDestroy();
        view.onDestroy();
    }



    @Override
    public void onLocationChanged(AMapLocation amapLocation) {
        if (amapLocation != null) {
            if (amapLocation.getErrorCode() == 0) {
                ////定位数据
                if(tMapLocation.getTime()==0||tMapLocation.locationChanged(amapLocation.getTime()))
                {
                    tMapLocation.setLocation(amapLocation);

                    if (null != methodChannel) {
                        final Map<String, Object> arguments = new HashMap<String, Object>(2);
                        arguments.put("location",tMapLocation.locationToJson());
                        arguments.put("navigation",tMapLocation.navigationToJson());
                        methodChannel.invokeMethod(Const.METHOD_VIEW_LOCATION_CHANGED, arguments);
                    }

                    if(tMapLocation.getMaxAltitude()<tMapLocation.getAltitude())
                        tMapLocation.setMaxAltitude(tMapLocation.getAltitude());

                    if(tMapLocation.getMinAltitude()>tMapLocation.getAltitude())
                        tMapLocation.setMinAltitude(tMapLocation.getAltitude());


                    LngLat lngLat = tMapLocation.toLngLat_Gcj_To_Gps84();
                    if(!tMapLocation.isFirstLocation()) {
                        tMapLocation.setFirstLocation(true);
                        if(tMapLocation.getInitAltitude()==-200&&tMapLocation.getAltitude()!=0)
                            tMapLocation.setInitAltitude(tMapLocation.getAltitude());
                        mapController.updateCameraPosition(CameraUpdateFactory.newLngLatZoom(lngLat,18));
                    }
                    mapController.addMarkerBySrting(lngLat);
                }
            } else {
                //显示错误信息ErrCode是错误码，errInfo是错误信息，详见错误码表。
                Log.e("AmapError","location Error, ErrCode:"
                        + amapLocation.getErrorCode() + ", errInfo:"
                        + amapLocation.getErrorInfo());
            }
        }
    }


    @Override
    public void doMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if(mlocationClient!=null)
        {
            switch (call.method){
                case Const.METHOD_VIEW_FLY_LOCATION:
                    tMapLocation.setFirstLocation(false);
                    break;
                case Const.METHOD_VIEW_LOCATION_SWITCH:
                    if(tMapLocation.isLocationFlag()) {
                        mlocationClient.stopLocation();
                        Toast.makeText(context,"停止导航",Toast.LENGTH_SHORT).show();
                    }
                    else {
                        mlocationClient.startLocation();
                        Toast.makeText(context,"开始导航",Toast.LENGTH_SHORT).show();
                    }
                    tMapLocation.setLocationFlag(!tMapLocation.isLocationFlag());
                    break;
                default:
                    LogUtil.w(CLASS_NAME, "onMethodCall not find methodId:" + call.method);
            }
        }
    }

    @Override
    public String[] getRegisterMethodIdArray() {
        return Const.METHOD_ID_LIST_FOR_VIEW;
    }
}
