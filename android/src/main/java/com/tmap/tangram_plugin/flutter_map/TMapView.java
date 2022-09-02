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
    private MapController map;
    private Context context;
    private boolean disposed = false;
    boolean flag=false;
    boolean timeflag=false;
    private Marker marker;
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
            map=view.initMapController(new GLSurfaceViewHolderFactory(), TMapController.getHttpHandler(context));
            mapController = new TMapController(methodChannel,view, map);
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

    public void startLocation(AMapLocationClient mlocationClient) {
        this.mlocationClient=mlocationClient;
        this.mlocationClient.setLocationListener(this);
        this.mlocationClient.startLocation();
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
//            destroyMapViewIfNecessary();
            view=null;
            disposed = true;
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
    public TMapController getMapController() {
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
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onPause", e);
        }
    }

    @Override
    public void onStop(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onStop==>");
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
//                //定位成功回调信息，设置相关消息
//                amapLocation.getLocationType();//获取当前定位结果来源，如网络定位结果，详见定位类型表
//                amapLocation.getLatitude();//获取纬度
//                amapLocation.getLongitude();//获取经度
//                amapLocation.getAccuracy();//获取精度信息
//                amapLocation.getAddress();//地址，如果option中设置isNeedAddress为false，则没有此结果，网络定位结果中会有地址信息，GPS定位不返回地址信息。
//                amapLocation.getCountry();//国家信息
//                amapLocation.getProvince();//省信息
//                amapLocation.getCity();//城市信息
//                amapLocation.getDistrict();//城区信息
//                amapLocation.getStreet();//街道信息
//                amapLocation.getStreetNum();//街道门牌号信息
//                amapLocation.getCityCode();//城市编码
//                amapLocation.getAdCode();//地区编码
                //LngLat lngLat0=new LngLat(116.7234192,40.1591512);

                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date = new Date(amapLocation.getTime());
                //System.out.println("定位时间:"+df.format(date));//定位时间
                if(timeflag)
                    Toast.makeText(context,df.format(date),Toast.LENGTH_SHORT).show();
                LngLat lngLat = LngLatConverterUtil.gcj_To_Gps84(amapLocation.getLatitude(), amapLocation.getLongitude());
                if(!flag) {
                    flag=true;
                    timeflag=!timeflag;
                    map.updateCameraPosition(CameraUpdateFactory.newLngLatZoom(lngLat,18));
                }
                marker = map.addMarker();
                String pointStyle = "{ style: 'points', color: 'yellow', size: [10px, 10px], order: 2000, collide: false, flat: true }";
                marker.setStylingFromString(pointStyle);
                marker.setPoint(lngLat);
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
                    flag=false;
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
