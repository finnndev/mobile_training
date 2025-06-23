package com.example.myapp2.broadcastReceiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import android.util.Log

class NetworkReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        if (isConnected(context)) {
            Log.d("Broadcast", "${this.javaClass.simpleName}: Đã kết nối Internet")
//            Toast.makeText(context, "Đã kết nối Internet", Toast.LENGTH_LONG).show()
        } else {
            Log.d("Broadcast", "${this.javaClass.simpleName}: Mất kết nối Internet")
//            Toast.makeText(context, "Mất kết nối Internet", Toast.LENGTH_LONG).show()
        }
    }

    private fun isConnected(context: Context): Boolean {
        val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val network = cm.activeNetwork ?: return false
            val capabilities = cm.getNetworkCapabilities(network) ?: return false
            capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
        } else {
            val networkInfo = cm.activeNetworkInfo
            networkInfo != null && networkInfo.isConnected
        }
    }

}