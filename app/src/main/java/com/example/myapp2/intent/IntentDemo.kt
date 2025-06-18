package com.example.myapp2.intent

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.myapp2.R

class IntentDemo : AppCompatActivity() {
    private val TAG = "Intent"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_intent_demo)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
    }

    override fun onStart() {
        super.onStart()
        Log.d(TAG, "onStart called ${this.hashCode()}")
        intent()
    }

    private fun intent(){
        val text = findViewById<EditText>(R.id.editTextIntent)
        val buttonSend = findViewById<Button>(R.id.button12)
        val buttonBrowser = findViewById<Button>(R.id.button13)

        buttonSend.setOnClickListener {
            val intent = Intent(this@IntentDemo, IntentDemo2::class.java)
            intent.putExtra("data", text.text.toString())
            startActivity(intent)
        }

        buttonBrowser.setOnClickListener {
            val intent = Intent(Intent.ACTION_VIEW)
            intent.data = android.net.Uri.parse("https://www.google.com")
            startActivity(intent)
        }
    }
}
