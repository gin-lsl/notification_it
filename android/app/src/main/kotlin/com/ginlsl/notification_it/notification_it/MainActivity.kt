package com.ginlsl.notification_it.notification_it

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    private val sharedText: String;

    companion object {
        /**
         * CHANNEL
         */
        private val CHANNEL: String = "app.channel.shared.data"
    }
}
