package com.example.myapp2

import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.os.Bundle
import android.provider.ContactsContract
import android.util.Log
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import android.Manifest
import android.content.ComponentName
import android.content.Context
import android.content.ServiceConnection
import android.os.IBinder
import com.example.myapp2.activity.Screen2
import com.example.myapp2.activity.Screen3
import com.example.myapp2.activity.SingleInstance
import com.example.myapp2.activity.SingleTask
import com.example.myapp2.activity.SingleTop
import com.example.myapp2.activity.Standard
import com.example.myapp2.broadcastReceiver.NetworkReceiver
import com.example.myapp2.intent.IntentDemo
import com.example.myapp2.service.MyBackroundService
import com.example.myapp2.service.MyBoundService
import com.example.myapp2.service.MyForegroundService

//import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    private val TAG = "MainActivity"
    private var i = 0;
    private var timeService: MyBoundService? = null
    private var isBound = false
    private lateinit var networkReceiver: NetworkReceiver
    private lateinit var connection: ServiceConnection

    companion object {
        private const val REQUEST_READ_CONTACTS = 100
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        Log.d(TAG, "onCreate called ${this.hashCode()}")
        Toast.makeText(this, "onCreate", Toast.LENGTH_SHORT).show()
        activityExample()
        backgroundServiceExample()
        foregroundServiceExample()
        networkChange()
        contentProviderExample()
        boundServiceConnection()
        boundServiceExample()
        intentDemo()
        intentFilterDemo()
        i = savedInstanceState?.getInt("KEY_I") ?: 0
        findViewById<TextView>(R.id.textView).text = i.toString()
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putInt("KEY_I", i)
    }

    //Contact Provider
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
        deviceId: Int
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults, deviceId)
        if (requestCode == REQUEST_READ_CONTACTS && grantResults.isNotEmpty() &&
            grantResults[0] == PackageManager.PERMISSION_GRANTED
        ) {
            readContacts()
        } else {
            Log.d("Contact", "Không có quyền truy cập danh bạ")
        }
    }

    override fun onStart() {
        super.onStart()
        Log.d(TAG, "onStart called ${this.hashCode()}")
        Toast.makeText(this, "onStart", Toast.LENGTH_SHORT).show()
    }

    override fun onResume() {
        super.onResume()
        Log.d(TAG, "onResume called ${this.hashCode()}")
        Toast.makeText(this, "onResume", Toast.LENGTH_SHORT).show()
    }

    override fun onPause() {
        super.onPause()
        Log.d(TAG, "onPause called ${this.hashCode()}")
        Toast.makeText(this, "onPause", Toast.LENGTH_SHORT).show()
    }

    override fun onStop() {
        super.onStop()
        Log.d(TAG, "onStop called ${this.hashCode()}")
        Toast.makeText(this, "onStop", Toast.LENGTH_SHORT).show()
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "onDestroy called ${this.hashCode()}")
        Toast.makeText(this, "onDestroy", Toast.LENGTH_SHORT).show()

        // Unregister the network change receiver
        unregisterReceiver(networkReceiver)

        // Unbind from the service
        if (isBound) {
            unbindService(connection)
            isBound = false
        }
    }

    override fun onRestart() {
        super.onRestart()
        Log.d(TAG, "onRestart called ${this.hashCode()}")
        Toast.makeText(this, "onRestart", Toast.LENGTH_SHORT).show()
    }

    fun activityExample() {
        val tru = findViewById<Button>(R.id.button)
        val text = findViewById<TextView>(R.id.textView)
        val cong = findViewById<Button>(R.id.button2)
        val buttonS2 = findViewById<Button>(R.id.button3)
        val buttonS3 = findViewById<Button>(R.id.button4)
        val button4 = findViewById<Button>(R.id.buttonStandard)
        val button5 = findViewById<Button>(R.id.buttonSingleTop)
        val button6 = findViewById<Button>(R.id.buttonSingleTask)
        val button7 = findViewById<Button>(R.id.buttonSingleInstance)

        text.text = i.toString()

        tru.setOnClickListener {
            if (i == 0) i = 0 else i--

            text.text = i.toString()
            Log.d(TAG, "Decrease in value")
            Toast.makeText(this, "Decrease in value", Toast.LENGTH_SHORT).show()
        }
        cong.setOnClickListener {
            i++
            text.text = i.toString()
            Log.d(TAG, "Increase in value")
            Toast.makeText(this, "Increase in value", Toast.LENGTH_SHORT).show()
        }

        buttonS2.setOnClickListener {
            val intent = Intent(this@MainActivity, Screen2::class.java)
            Log.d(TAG, "button get screen 2 called ${this.hashCode()}")
            Toast.makeText(this, "Go to screen 2", Toast.LENGTH_SHORT).show()
            startActivity(intent)
        }

        buttonS3.setOnClickListener {
            val intent = Intent(this@MainActivity, Screen3::class.java)
            Log.d(TAG, "button get screen 3 called ${this.hashCode()}")
            Toast.makeText(this, "Go to screen 3", Toast.LENGTH_SHORT).show()
            startActivity(intent)
        }

        button4.setOnClickListener {
            val intent = Intent(this@MainActivity, Standard::class.java)
            Log.d(TAG, "Launch mode Standard called ${this.hashCode()}")
            startActivity(intent)
        }

        button5.setOnClickListener {
            val intent = Intent(this@MainActivity, SingleTop::class.java)
            Log.d(TAG, "Launch mode SingleTop called ${this.hashCode()}")
            startActivity(intent)
        }

        button6.setOnClickListener {
            val intent = Intent(this@MainActivity, SingleTask::class.java)
            Log.d(TAG, "Launch mode SingleTask called ${this.hashCode()}")
            startActivity(intent)
        }

        button7.setOnClickListener {
            val intent = Intent(this@MainActivity, SingleInstance::class.java)
            Log.d(TAG, "Launch mode SingleInstance called ${this.hashCode()}")
            startActivity(intent)
        }
    }

    fun backgroundServiceExample() {
        val buttonStartService = findViewById<Button>(R.id.button5)
        val buttonStopService = findViewById<Button>(R.id.button6)
        //Service
        buttonStartService.setOnClickListener {
            startService(Intent(this@MainActivity, MyBackroundService::class.java))
        }

        buttonStopService.setOnClickListener {
            stopService(Intent(this@MainActivity, MyBackroundService::class.java))
        }
    }

    fun foregroundServiceExample() {
        val buttonStartService = findViewById<Button>(R.id.button7)
        val buttonStopService = findViewById<Button>(R.id.button8)
        //Service
        buttonStartService.setOnClickListener {
            startService(Intent(this@MainActivity, MyForegroundService::class.java))
        }

        buttonStopService.setOnClickListener {
            stopService(Intent(this@MainActivity, MyForegroundService::class.java))
        }
    }

    fun boundServiceConnection() {
        connection = object : ServiceConnection {
            override fun onServiceConnected(name: ComponentName?, binder: IBinder?) {
                val b = binder as MyBoundService.LocalBinder
                timeService = b.getService()
                isBound = true
            }

            override fun onServiceDisconnected(name: ComponentName?) {
                isBound = false
            }
        }
    }

    fun boundServiceExample() {
        val btnGetTime = findViewById<Button>(R.id.button10)
        val textTime = findViewById<TextView>(R.id.textView)

        // Call getCurrentTime() when the button is clicked
        btnGetTime.setOnClickListener {
            if (isBound) {
                val currentTime = timeService?.getCurrentTime() ?: "--:--:--"
                textTime.text = currentTime
            }
        }

        // Call bindService to establish a connection with the service
        val intent = Intent(this, MyBoundService::class.java)
        bindService(intent, connection, Context.BIND_AUTO_CREATE)
    }


    fun networkChange() {
        networkReceiver = NetworkReceiver()
        val filter = IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION)
        registerReceiver(networkReceiver, filter)
    }


    fun contentProviderExample() {
        val contact = findViewById<Button>(R.id.button9)
        contact.setOnClickListener {
            // Kiểm tra quyền
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_CONTACTS)
                != PackageManager.PERMISSION_GRANTED
            ) {
                ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.READ_CONTACTS),
                    REQUEST_READ_CONTACTS
                )
            } else {
                readContacts()
            }
        }
    }

    fun readContacts() {
        val cursor = contentResolver.query(
            ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
            null, null, null, null
        )

        cursor?.use {
            val nameIndex =
                it.getColumnIndexOrThrow(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME)
            val numberIndex =
                it.getColumnIndexOrThrow(ContactsContract.CommonDataKinds.Phone.NUMBER)

            while (it.moveToNext()) {
                val name = it.getString(nameIndex)
                val phone = it.getString(numberIndex)
                Log.d("Contact", "Tên: $name, Số: $phone")
            }
        }
    }

    fun intentDemo(){
        val buttonIntent = findViewById<Button>(R.id.button11)
        buttonIntent.setOnClickListener {
            val intent = Intent(this, IntentDemo::class.java)
            startActivity(intent)
        }
    }

    fun intentFilterDemo(){
        val sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)

        val textView = findViewById<TextView>(R.id.txtViewHome)
        textView.text = if (sharedText != null) {
            "Bạn vừa chia sẻ:\n$sharedText"
        } else {
            "Không có dữ liệu nhận được!"
        }
    }
}
