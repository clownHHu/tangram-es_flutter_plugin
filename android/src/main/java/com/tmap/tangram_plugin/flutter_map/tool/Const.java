package com.tmap.tangram_plugin.flutter_map.tool;

/**
 * @author whm
 * @date 2020/11/10 9:44 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public class Const {
    /**
     * map
     */
    public static final String METHOD_MAP_SCENE_READY ="map#sceneReady";
    public static final String METHOD_MAP_ADD_MAKR = "map#addMark";
    public static final String METHOD_MAP_FLY_CAMERA = "map#flyCamera";
    public static final String[] METHOD_ID_LIST_FOR_MAP = {
            METHOD_MAP_ADD_MAKR,
            METHOD_MAP_FLY_CAMERA,
            METHOD_MAP_SCENE_READY

    };

    public static final String METHOD_VIEW_FLY_LOCATION= "map#flyLoction";
    public static final String[] METHOD_ID_LIST_FOR_VIEW = {
            METHOD_VIEW_FLY_LOCATION
    };


}
