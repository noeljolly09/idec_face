package com.example.idec_face;

import android.Manifest;
import android.Manifest.permission;
import android.app.Activity;
import android.app.ActivityManager;
import android.app.AlarmManager;
import android.app.AlertDialog;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import java.util.List;
import java.util.concurrent.TimeUnit;
import pub.devrel.easypermissions.AppSettingsDialog;
import pub.devrel.easypermissions.EasyPermissions;

public class MainActivity
  extends FlutterActivity
  implements EasyPermissions.PermissionCallbacks {

  public static final String TAG = MainActivity.class.getSimpleName();
  private static final String CHANNEL1 = "com.camera.cameraPermission";
  final String ENGINE_ID = "1";
  private static final int REQUEST_ENABLE_CMR = 1;


  @Override
  protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    FlutterEngine flutterEngine = new FlutterEngine(this);
    flutterEngine
      .getDartExecutor()
      .executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault());
    FlutterEngineCache.getInstance().put(ENGINE_ID, flutterEngine);



    // camera permission
    new MethodChannel(getFlutterEngine().getDartExecutor(), CHANNEL1)
    .setMethodCallHandler(
        new MethodChannel.MethodCallHandler() {
          @Override
          public void onMethodCall(
            MethodCall call,
            MethodChannel.Result result
          ) {
            if (call.method.equals("camera_permission")) {
              boolean isCameraPermissionAllowed = cameraPermissionRequest();
              result.success(isCameraPermissionAllowed);
            } else {
              result.notImplemented();
            }
          }
        }
      );

  
  }

  @Override
  protected void onStart() {
    super.onStart();
  }

  @Override
  public void onRequestPermissionsResult(
    int requestCode,
    @NonNull String[] permissions,
    @NonNull int[] grantResults
  ) {
    EasyPermissions.onRequestPermissionsResult(
      requestCode,
      permissions,
      grantResults,
      this
    );
  }


  public boolean cameraPermissionRequest() {
    boolean isCamerPermissionAllowed = true;
    String[] CAMERA_SENSORS_PERMISSION = { Manifest.permission.CAMERA };
    if (!EasyPermissions.hasPermissions(this, CAMERA_SENSORS_PERMISSION)) {
      isCamerPermissionAllowed = false;
      EasyPermissions.requestPermissions(
        this,
        "Application requires Camera permission",
        REQUEST_ENABLE_CMR,
        CAMERA_SENSORS_PERMISSION
      );
    } else {
      isCamerPermissionAllowed = true;
    }
    return isCamerPermissionAllowed;
  }

  @Override
  public void onPermissionsGranted(
    int requestCode,
    @NonNull List<String> perms
  ) {}

  @Override
  public void onPermissionsDenied(
    int requestCode,
    @NonNull List<String> perms
  ) {

  }

  @Override
  protected void onActivityResult(
    int requestCode,
    int resultCode,
    Intent data
  ) {
    super.onActivityResult(requestCode, resultCode, data);
  }

  @Override
  public void onPause() {
    super.onPause();
  }

  @Override
  protected void onDestroy() {
    super.onDestroy();
  }

  @Override
  protected void onResume() {
    super.onResume();
  }
}
