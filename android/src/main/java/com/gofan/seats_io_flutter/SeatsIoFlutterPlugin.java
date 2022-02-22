package com.gofan.seats_io_flutter;

import android.content.Context;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import io.seats.Region;
import io.seats.seatingChart.ConfigChange;
import io.seats.seatingChart.SeatingChartConfig;
import io.seats.seatingChart.SeatingChartView;

/** SeatsIoFlutterPlugin */
public class SeatsIoFlutterPlugin implements FlutterPlugin{

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    binding
            .getPlatformViewRegistry()
            .registerViewFactory("seats-io-view", new SeatsViewFactory(binding.getBinaryMessenger()));
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

  }
}

class SeatsViewFactory extends PlatformViewFactory{
  private final BinaryMessenger messenger;

  public SeatsViewFactory(BinaryMessenger messenger){
    super(StandardMessageCodec.INSTANCE);
    this.messenger = messenger;
  }

  @Override
  public PlatformView create(Context context, int id, Object o){
    final Map<String, Object> creationParams = (Map<String, Object>) o;
    return new SeatsIoView(context, messenger, id, creationParams);
  }
}

class SeatsIoView implements PlatformView, MethodChannel.MethodCallHandler{
  private SeatingChartView seatingChartView;
  private final MethodChannel methodChannel;

  SeatsIoView(Context context, BinaryMessenger messenger, int id, @Nullable Map<String, Object> creationParams){
    String eventId = (String) creationParams.get("eventId");
    String publicKey = (String) creationParams.get("publicKey");

    SeatingChartConfig config = new SeatingChartConfig().setPublicKey(publicKey).setEvent(eventId);
    seatingChartView = new SeatingChartView(Region.EU, config, context);
    methodChannel = new MethodChannel(messenger, "seats-io-view_" + id);
    methodChannel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

  }

  @Override
  public View getView() {
    return seatingChartView;
  }

  @Override
  public void dispose() {

  }

  private void setConfig(){
    ConfigChange configChange = new ConfigChange();
    seatingChartView.changeConfig(configChange);
  }
}
