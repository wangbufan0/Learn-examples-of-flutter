package com.example.flutter_to_bative

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.*

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

    private val  CHANNEL="samples.flutter.io/battery"
    private val  CHANNEL2="samples.flutter.io/test"



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        /**
         * BasicMessageChannel
         */

        //BasicMessageChannel，接受消息
        val messageChannel = BasicMessageChannel<Any>(flutterView,
                "samples.flutter.io/message",
                StandardMessageCodec.INSTANCE)
        //BasicMessageChannel，发送消息
        val messageChannel2 = BasicMessageChannel<Any>(flutterView,
                "samples.flutter.io/message2",
                StandardMessageCodec.INSTANCE)
        messageChannel.setMessageHandler { p0, p1 ->
            println("onMessage：$p0")
            p1.reply("Android返回的数据")

            //发送消息
            messageChannel2.send("发送给flutter的数据"
            ) {
                println("onReply:$it")
            }

        }


        /**
         * MethodChannel
         * 根据请求获得系统电量
         */

        MethodChannel(flutterView ,CHANNEL)
                .setMethodCallHandler{call,result->
                    if(call.method == "getBatteryLevel"){
                        val batteryLevel=getBatteryLevel()//调用函数获得电量
                        if(batteryLevel!=-1)
                            result.success(batteryLevel)
                        else
                            result.error("UNAVAILABLE","Battery level not available.",null)
                    }else{
                        result.notImplemented()
                    }
                }


        /**
         *
         * EventChannel
         */
        EventChannel(flutterView,CHANNEL2).setStreamHandler(
                object : EventChannel.StreamHandler {
                    private lateinit var eventSink:EventChannel.EventSink
                    private var count=0
                    private val handler= object: Handler() {
                        override fun handleMessage(msg: Message?) {
                            super.handleMessage(msg)
                            eventSink.success((count++).toString()+"主动发消息给flutter")
                            sendEmptyMessageDelayed(1,3000)
                        }
                    }
                    override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
                        eventSink= p1!!
                        handler.sendEmptyMessageDelayed(1,2000)
                    }

                    override fun onCancel(p0: Any?) {

                    }

                }
        )

    }

    private fun getBatteryLevel():Int{
         /**
           * @author: wangbufan
           * @date: 2019/12/10 19:02
           * @description 返回系统电量百分比
           */
        var batteryLevel=-1
        if (Build.VERSION.SDK_INT>=Build.VERSION_CODES.LOLLIPOP){
            val batteryManager= getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel=batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        }else{
            val intent=ContextWrapper(applicationContext)
                    .registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel=(intent.getIntExtra(BatteryManager.EXTRA_LEVEL,-1)*100)/
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE,-1)
        }
        return batteryLevel
    }



}
