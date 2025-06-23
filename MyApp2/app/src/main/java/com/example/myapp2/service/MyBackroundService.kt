package com.example.myapp2.service

import android.app.Service
import android.content.Intent
import android.media.MediaPlayer
import android.os.IBinder
import android.provider.Settings
import android.util.Log
import android.widget.Toast

class MyBackroundService : Service() {
    private val TAG = "LOG"
    private lateinit var player: MediaPlayer

    override fun onStartCommand(init: Intent, flag: Int, startID: Int): Int {
        player = MediaPlayer.create(this, Settings.System.DEFAULT_RINGTONE_URI)
        player.isLooping = true
        player.start()
        Log.d(TAG, "Background Service started")
        Toast.makeText(this, "Background Service started", Toast.LENGTH_SHORT).show()
        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        player.stop()
        Log.d(TAG, "Background Service stopped")
        Toast.makeText(this, "Background Service stopped", Toast.LENGTH_SHORT).show()
    }

    override fun onBind(intent: Intent): IBinder {
        TODO("Return the communication channel to the service.")
    }
}