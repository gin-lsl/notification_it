package com.ginlsl.notification_it.notification_it

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.util.GeneratedPluginRegister
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private var sharedText: String? = null

    companion object {
        /**
         * CHANNEL
         */
        private const val CHANNEL: String = "app.channel.shared.data"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val action = intent.action
        val type = intent.type

        if (Intent.ACTION_SEND == action && type != null) {
            if ("text/plain" == type) {
//                handle text being send
                handleSendText(intent)
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)

        println("configure_flutter_engine")

        GeneratedPluginRegister.registerGeneratedPlugins(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                run {
                    if (call.method!!.contentEquals("getSharedText")) {
                        result.success(sharedText)
                        sharedText = null
                    }
                }
            }
    }

    private fun handleSendText(intent: Intent) {
        sharedText = intent.getStringExtra(Intent.EXTRA_TEXT).toString()
    }
}
