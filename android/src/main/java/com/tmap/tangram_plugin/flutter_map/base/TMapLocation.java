package com.tmap.tangram_plugin.flutter_map.base;

import androidx.annotation.NonNull;

import com.amap.api.location.AMapLocation;
import com.mapzen.tangram.LngLat;
import com.tmap.tangram_plugin.flutter_map.tool.LngLatConverterUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class TMapLocation {

    private double latutude;
    private double longitude;
    private String provider;
    private double accuracy;
    private double altitude;
    private double bearing;
    private double speed;
    private long time;

    private boolean locationFlag;
    private boolean locationChanged;
    private boolean firstLocation;
    private ArrayList<Double> speedList;
    private double averSpeed;
    private double initAltitude;
    private double distance;
    private double maxAltitude;
    private double minAltitude;
    private int speedNum;

    public void setLocation(@NonNull AMapLocation amapLocation){
       this.latutude=amapLocation.getLatitude();
       this.longitude=amapLocation.getLongitude();
       this.accuracy=amapLocation.getAccuracy();
       this.altitude=amapLocation.getAltitude();
       this.bearing=amapLocation.getBearing();
       this.speed=amapLocation.getSpeed();
       this.time=amapLocation.getTime();
       this.provider=amapLocation.getProvider();
       setSpeedList(speed);
       this.averSpeed=calAverSpeed();
    }
    public boolean locationChanged(long now){
        if(time!=0)
            locationChanged=(time!= now);
        else
            locationChanged=false;

        return locationChanged;
    }
    public double calAverSpeed(){
        double sum=0.0;
        double result=0.0;
        for(int i=0;i<speedList.size();i++)
            sum+=speedList.get(i);
        if(!speedList.isEmpty())
            result=sum/speedNum;
        return result;
    }

    public final LngLat toLngLat_Gps84_To_Gcj02(){
        return LngLatConverterUtil.gps84_To_Gcj02(latutude,longitude);
    }

    public final LngLat toLngLat_Gcj_To_Gps84(){
        return LngLatConverterUtil.gcj_To_Gps84(latutude,longitude);
    }
    public final LngLat toLngLat_Gcj02_To_Bd09(){
        return LngLatConverterUtil.gcj02_To_Bd09(latutude,longitude);
    }

    public final LngLat toLngLat_Bd09_To_Gcj02(){
        return LngLatConverterUtil.bd09_To_Gcj02(latutude,longitude);
    }
    public final LngLat toLngLat_Bd09_To_Gps84(){
        return LngLatConverterUtil.bd09_To_Gps84(latutude,longitude);
    }

    public final Map<String, Object> locationToJson(){
        Map<String, Object> json = new HashMap<String, Object>(2);
        ArrayList<Double> latLng=new ArrayList<Double>();
        latLng.add(latutude);
        latLng.add(longitude);
        json.put("provider",provider);
        json.put("latLng", latLng);
        json.put("accuracy",accuracy);
        json.put("altitude",altitude);
        json.put("bearing",bearing);
        json.put("speed",speed);
        json.put("time",time);

//        json.put("averSpeed",averSpeed);
//        json.put("initAltitude",initAltitude);
//        json.put("distance",distance);
//        json.put("maxAltitude",maxAltitude);
//        json.put("minAltitude",minAltitude);

        return json;
    }
    public final Map<String, Object> navigationToJson(){
        Map<String, Object> json = new HashMap<String, Object>(2);
        json.put("averSpeed",averSpeed);
        json.put("distance",distance);
        json.put("maxAltitude",maxAltitude);
        json.put("minAltitude",minAltitude);
        json.put("upAltitude",initAltitude==-200?0:maxAltitude-initAltitude);
        json.put("downAltitude",initAltitude==-200?0:initAltitude-minAltitude);
        return json;
    }

    /**
     * setter,getter
     * **/
    public double getMaxAltitude() {
        return maxAltitude;
    }

    public void setMaxAltitude(double maxAltitude) {
        this.maxAltitude = maxAltitude;
    }

    public double getMinAltitude() {
        return minAltitude;
    }

    public void setMinAltitude(double minAltitude) {
        this.minAltitude = minAltitude;
    }

    public boolean isFirstLocation() {
        return firstLocation;
    }

    public void setFirstLocation(boolean firstLocation) {
        this.firstLocation = firstLocation;
    }



    public double getInitAltitude() {
        return initAltitude;
    }

    public void setInitAltitude(double initAltitude) {
        this.initAltitude = initAltitude;
    }

    public ArrayList<Double> getSpeedList() {
        return speedList;
    }

    public void setSpeedList(double speed) {
        if(speedList==null)
            speedList=new ArrayList<>();

        if(speedList.size()>=100)
        {
            speedList.clear();
            speedList.add(averSpeed);
        }

        speedList.add(speed);
        speedNum++;
    }

    public boolean isLocationFlag() {
        return locationFlag;
    }

    public void setLocationFlag(boolean locationFlag) {
        this.locationFlag = locationFlag;
    }
    public double getAverSpeed(){
        return averSpeed;
    }
    public double getLatutude() {
        return latutude;
    }

    public void setLatutude(double latutude) {
        this.latutude = latutude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
    }

    public double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(double accuracy) {
        this.accuracy = accuracy;
    }

    public double getAltitude() {
        return altitude;
    }

    public void setAltitude(double altitude) {
        this.altitude = altitude;
    }

    public double getBearing() {
        return bearing;
    }

    public void setBearing(double bearing) {
        this.bearing = bearing;
    }

    public double getSpeed() {
        return speed;
    }

    public void setSpeed(double speed) {
        this.speed = speed;
    }

    public long getTime() {
        return time;
    }

    public void setTime(long time) {
        this.time = time;
    }


}
