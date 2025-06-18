package com.example.myapp2.intent

import android.os.Bundle
import android.util.Log
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.myapp2.R

class IntentDemo2 : AppCompatActivity() {
    private val TAG = "Intent"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_intent_demo2)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
    }
    override fun onStart() {
        super.onStart()
        Log.d(TAG, "onStart called ${this.hashCode()}")
        val text = intent.getStringExtra("data")
        val textView = findViewById<TextView>(R.id.textView5)
        textView.text = "Dữ liệu nhận được qua Intent put: \n ${text}"
    }
}