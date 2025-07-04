package com.example.complex_ui

import android.Manifest
import android.media.MediaPlayer
import android.media.MediaRecorder
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.complex_ui.fragment.FragmentA
import com.example.complex_ui.fragment.FragmentB
import com.example.complex_ui.fragment.FragmentC
import com.example.complex_ui.fragment.FragmentParent
import com.example.complex_ui.fragment.FragmentVoice

class MainActivity : AppCompatActivity() {

    var saveCounter = 0
    val TAG = "stack"

    private var mediaRecorder: MediaRecorder? = null
    private var mediaPlayer: MediaPlayer? = null
    private lateinit var outputFile: String

    private lateinit var btnRecord: Button
    private lateinit var btnStop: Button
    private lateinit var btnPlay: Button
    private val permissionLauncher =
        registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->
            val granted = permissions.all { it.value }
            if (!granted) {
                Toast.makeText(this, "Cần cấp quyền để ghi âm", Toast.LENGTH_SHORT).show()
            }
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
        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .add(R.id.frame_layout, FragmentA(), "FragmentA")

                .commit()
        }
        outputFile = "${externalCacheDir?.absolutePath}/recorded_audio.m4a"
        eventButton()

        btnRecord = findViewById<Button>(R.id.btnRecord)
        btnStop = findViewById(R.id.btnStop)
        btnPlay = findViewById(R.id.btnPlay)

        requestPermissions()

//        outputFile = File(getExternalFilesDir(null), "recorded_audio.mp3")

        btnRecord.setOnClickListener {
            startRecording()
        }

        btnStop.setOnClickListener {
            stopRecording()
        }

        btnPlay.setOnClickListener {
            playAudio()
//            val fragment = FragmentVoice()
//            val bundle = Bundle()
//            bundle.putString("filePath", outputFile)
//            fragment.arguments = bundle

//            supportFragmentManager.beginTransaction()
//                .replace(R.id.frame_layout, fragment, "FragmentVoice")
//                .addToBackStack("FragmentVoice")
//                .commit()
        }
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        super.onBackPressed()
        Log.d(TAG, "back pressed")
    }

    private fun eventButton() {
        val button1 = findViewById<Button>(R.id.button1)
        button1.setOnClickListener {
            supportFragmentManager.beginTransaction()
                .replace(R.id.frame_layout, FragmentA(), "FragmentA")
                .commit()
            Log.d(TAG, "fragment A replaced")
        }
        val button2 = findViewById<Button>(R.id.button2)
        button2.setOnClickListener {
            supportFragmentManager.beginTransaction()
                .add(R.id.frame_layout, FragmentB(), "FragmentB")
                .addToBackStack("FragmentB").commit()
            Log.d(TAG, "fragment B replaced")
        }
        val buttonFrag = findViewById<Button>(R.id.button3)
        buttonFrag.setOnClickListener {
            supportFragmentManager.beginTransaction()
                .replace(R.id.frame_layout, FragmentParent(), "FragmentParent")
                .addToBackStack("FragmentParent").commit()
            Log.d(TAG, "fragment Parent replaced")
        }
        val buttonAdd = findViewById<Button>(R.id.buttonAdd)
        buttonAdd.setOnClickListener {
            supportFragmentManager.beginTransaction()
                .add(R.id.frame_layout, FragmentC(), "FragmentC")
                .addToBackStack("FragmentC").commit()
            Log.d(TAG, "fragment C added")
        }
        val buttonRemove = findViewById<Button>(R.id.buttonRemove)
        buttonRemove.setOnClickListener {
            supportFragmentManager.beginTransaction()
                .remove(supportFragmentManager.findFragmentByTag("FragmentA")!!).commit()
            Log.d(TAG, "fragment A removed")

        }
        val buttonVoice = findViewById<Button>(R.id.btnVoice)
        buttonVoice.setOnClickListener {
            if (outputFile.isNotEmpty()) {
                val fragment = FragmentVoice()
                val bundle = Bundle()
                bundle.putString("filePath", outputFile)
                fragment.arguments = bundle
                supportFragmentManager.beginTransaction()
                    .add(R.id.frame_layout, fragment, "FragmentVoice")
                    .addToBackStack("FragmentVoice")
                    .commit()
                Log.d(TAG, "FragmentVoice added with filePath: $outputFile")
            } else {
                Toast.makeText(this, "Không tìm thấy file ghi âm", Toast.LENGTH_SHORT).show()
                Log.d(TAG, "No audio file available for FragmentVoice")
            }
        }
    }


    private fun requestPermissions() {
        val permissions = mutableListOf(Manifest.permission.RECORD_AUDIO)
        if (Build.VERSION.SDK_INT < 33) {
            permissions.add(Manifest.permission.READ_EXTERNAL_STORAGE)
        } else {
            permissions.add(Manifest.permission.READ_MEDIA_AUDIO)
        }
        permissionLauncher.launch(permissions.toTypedArray())
    }

    private fun startRecording() {
        mediaRecorder = MediaRecorder().apply {
            setAudioSource(MediaRecorder.AudioSource.MIC)
            setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
            setAudioEncoder(MediaRecorder.AudioEncoder.AAC)
            setOutputFile(outputFile)
            prepare()
            start()
        }

        btnRecord.isEnabled = false
        btnStop.isEnabled = true
        Toast.makeText(this, "Đang ghi âm...", Toast.LENGTH_SHORT).show()
    }

    private fun stopRecording() {
        mediaRecorder?.apply {
            stop()
            release()
        }
        mediaRecorder = null

        btnRecord.isEnabled = true
        btnStop.isEnabled = false
        btnPlay.isEnabled = true

        Toast.makeText(this, "Đã lưu file: ${outputFile}", Toast.LENGTH_SHORT).show()
        Log.d(TAG, "file saved: ${outputFile}")
    }

    private fun playAudio() {
//        if (outputFile) {
//            Toast.makeText(this, "Không tìm thấy file ghi âm", Toast.LENGTH_SHORT).show()
//            return
//        }

        mediaPlayer = MediaPlayer().apply {
            setDataSource(outputFile)
            prepare()
            start()
        }

        Toast.makeText(this, "Đang phát lại...", Toast.LENGTH_SHORT).show()
    }

    override fun onDestroy() {
        mediaPlayer?.release()
        mediaRecorder?.release()
        super.onDestroy()
    }
}