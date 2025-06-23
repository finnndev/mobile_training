package com.example.myapp2.activity

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.myapp2.R

class SingleTask : AppCompatActivity() {
    private val TAG = "SingleTask"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_single_task)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
    }

    override fun onStart() {
        super.onStart()
        Log.d(TAG, "onStart called ${this.hashCode()}")

        val buttonStandard = findViewById<Button>(R.id.buttonStandard)
        val buttonSingleTop = findViewById<Button>(R.id.buttonSingleTop)
        val buttonSingleTask = findViewById<Button>(R.id.buttonSingleTask)
        val buttonSingleInstance = findViewById<Button>(R.id.buttonSingleInstance)
        val text = findViewById<TextView>(R.id.textView4)
        buttonStandard.setOnClickListener {
            startActivity(Intent(this@SingleTask, Standard::class.java))
        }
        text.text = "ID: ${this.hashCode()}"
        buttonSingleTop.setOnClickListener {
            startActivity(Intent(this@SingleTask, SingleTop::class.java))
        }
        buttonSingleTask.setOnClickListener {
            startActivity(Intent(this@SingleTask, SingleTask::class.java))
        }
        buttonSingleInstance.setOnClickListener {
            startActivity(Intent(this@SingleTask, SingleInstance::class.java))
        }
    }

    override fun onResume() {
        super.onResume()
        Log.d(TAG, "onResume called ${this.hashCode()}")
    }

    override fun onPause() {
        super.onPause()
        Log.d(TAG, "onPause called ${this.hashCode()}")
    }

    override fun onStop() {
        super.onStop()
        Log.d(TAG, "onStop called ${this.hashCode()}")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "onDestroy called ${this.hashCode()}")
    }

    override fun onRestart() {
        super.onRestart()
        Log.d(TAG, "onRestart called ${this.hashCode()}")
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Log.d(TAG, "${this.javaClass.simpleName} onNewIntent: ${this.hashCode()}")
    }
}