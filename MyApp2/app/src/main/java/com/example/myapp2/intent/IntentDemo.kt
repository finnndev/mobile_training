package com.example.myapp2.intent

import android.content.Intent
import android.net.Uri
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
        val email = findViewById<EditText>(R.id.editTextTextEmailAddress)
        val sub = findViewById<EditText>(R.id.editTextSub)
        val txt = findViewById<EditText>(R.id.editTextText)
        val call = findViewById<EditText>(R.id.editTextNum)
        val text2 = findViewById<EditText>(R.id.editText2)
        val buttonSend = findViewById<Button>(R.id.button12)
        val buttonBrowser = findViewById<Button>(R.id.button13)
        val buttonSendMail = findViewById<Button>(R.id.button14)
        val buttonCall = findViewById<Button>(R.id.button15)
        val buttonSend2 = findViewById<Button>(R.id.buttonSend2)

        buttonSend.setOnClickListener {
            val intent = Intent(this@IntentDemo, IntentDemo2::class.java)
            intent.putExtra("data", text.text.toString())
            startActivity(intent)
        }

        buttonBrowser.setOnClickListener {
            val intent = Intent(Intent.ACTION_VIEW)
            intent.data = android.net.Uri.parse("https://www.google.com")
            val i = Intent.createChooser(intent, "Choose App")
            startActivity(i)
        }

        buttonSendMail.setOnClickListener {
//            val intent = Intent(Intent.ACTION_SEND).apply {
//                type = "message/rfc822"
//                putExtra(Intent.EXTRA_EMAIL, arrayOf("abc@gmail.com"))
//                putExtra(Intent.EXTRA_SUBJECT, "Apply Intern")
//                putExtra(Intent.EXTRA_TEXT, "Internship at NinePlus")
//            }
//            startActivity(intent)
            val intent = Intent(Intent.ACTION_SEND)
            intent.type = "text/plain"
            intent.putExtra(Intent.EXTRA_EMAIL, arrayOf("${email.text.toString()}"))
            intent.putExtra(Intent.EXTRA_SUBJECT, "${sub.text.toString()}")
            intent.putExtra(Intent.EXTRA_TEXT, "${txt.text.toString()}")
            val i = Intent.createChooser(intent, "Choose App")
            startActivity(i)
        }

        buttonCall.setOnClickListener {
            val intent = Intent(Intent.ACTION_DIAL)
            intent.data = Uri.parse("tel:${call.text.toString()}")
            val i = Intent.createChooser(intent, "Choose App")
            startActivity(i)
        }

        buttonSend2.setOnClickListener {
            val intent = Intent(Intent.ACTION_SEND)
            intent.type = "text/plain"
            intent.putExtra(Intent.EXTRA_TEXT, "${text2.text.toString()}")
            val i = Intent.createChooser(intent, "Choose App")
            startActivity(i)
        }
    }
}
