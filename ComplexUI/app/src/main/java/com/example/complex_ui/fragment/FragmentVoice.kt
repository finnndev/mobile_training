package com.example.complex_ui.fragment

import android.media.MediaPlayer
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageButton
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.media3.common.MediaItem
import androidx.media3.common.PlaybackParameters
import androidx.media3.exoplayer.ExoPlayer
import com.example.complex_ui.R
import java.util.concurrent.Executors

class FragmentVoice : Fragment() {

    private var inputFile: String? = null
    private var mediaPlayer: MediaPlayer? = null
    private var exoPlayer: ExoPlayer? = null
    private lateinit var statusText: TextView
    private val executor = Executors.newSingleThreadExecutor()


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        inputFile = arguments?.getString("filePath")
        if (inputFile.isNullOrEmpty()) {
            activity?.runOnUiThread {
                Toast.makeText(requireContext(), "File path is invalid", Toast.LENGTH_SHORT).show()
            }
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_voice, container, false)
        val buttonRobot = view.findViewById<ImageButton>(R.id.button_robot)
        val buttonHelium = view.findViewById<ImageButton>(R.id.button_helium)
        val buttonDevil = view.findViewById<ImageButton>(R.id.button_devil)
        val buttonEcho = view.findViewById<ImageButton>(R.id.button_echo)
        val buttonChild = view.findViewById<ImageButton>(R.id.button_child)
        val buttonAlien = view.findViewById<ImageButton>(R.id.button_alien)
        val buttonCave = view.findViewById<ImageButton>(R.id.button_cave)
        val buttonGhost = view.findViewById<ImageButton>(R.id.button_ghost)
        val buttonRadio = view.findViewById<ImageButton>(R.id.button_radio)
        statusText = view.findViewById(R.id.text_status)

        // Cập nhật trạng thái ban đầu
        statusText.text = if (inputFile != null) "Ready to process: $inputFile" else "No audio file provided"

        // Áp dụng hiệu ứng giọng robot
        buttonRobot.setOnClickListener { applyEffect("robot") }

        // Áp dụng hiệu ứng giọng heli
        buttonHelium.setOnClickListener { applyEffect("helium") }

        // Áp dụng hiệu ứng giọng devil
        buttonDevil.setOnClickListener { applyEffect("devil") }

        buttonEcho.setOnClickListener { applyEffect("echo") }

        buttonChild.setOnClickListener { applyEffect("child") }

        buttonAlien.setOnClickListener { applyEffect("alien") }

        buttonCave.setOnClickListener { applyEffect("cave") }

        buttonGhost.setOnClickListener { applyEffect("ghost") }

        buttonRadio.setOnClickListener { applyEffect("radio") }

        exoPlayer = ExoPlayer.Builder(requireContext()).build()

        return view
    }


    private fun applyEffect(effect: String) {
        if (inputFile == null) {
            Toast.makeText(requireContext(), "No audio file provided", Toast.LENGTH_SHORT).show()
            return
        }

        statusText.text = "Playing $effect effect..."
        activity?.runOnUiThread {
            try {
                playAudioWithEffect(inputFile!!, effect)
                statusText.text = "Playing $effect effect"
            } catch (e: Exception) {
                statusText.text = "Error applying effect"
                Toast.makeText(requireContext(), "Error: ${e.message}", Toast.LENGTH_SHORT).show()
            }
        }
    }

    private fun playAudioWithEffect(filePath: String, effect: String) {
        exoPlayer?.let { player ->
            try {
                player.stop()
                player.clearMediaItems()
                val mediaItem = MediaItem.fromUri(filePath)
                player.setMediaItem(mediaItem)
                when (effect) {
                    "robot" -> player.playbackParameters = PlaybackParameters(1.5f, 0.7f)
                    "helium" -> player.playbackParameters = PlaybackParameters(1.0f, 2.0f)
                    "devil" -> player.playbackParameters = PlaybackParameters(0.8f, 0.5f)
                    "echo" -> player.playbackParameters = PlaybackParameters(0.9f, 1.0f)
                    "child" -> player.playbackParameters = PlaybackParameters(1.2f, 1.8f)
                    "alien" -> player.playbackParameters = PlaybackParameters(1.4f, 1.5f)
                    "cave" -> player.playbackParameters = PlaybackParameters(0.7f, 0.6f)
                    "ghost" -> player.playbackParameters = PlaybackParameters(0.6f, 0.4f)
                    "radio" -> player.playbackParameters = PlaybackParameters(1.0f, 0.8f)
                }
                player.prepare()
                player.play()
            } catch (e: Exception) {
                Toast.makeText(requireContext(), "Media error: ${e.message}", Toast.LENGTH_SHORT).show()
            }
        } ?: run {
            Toast.makeText(requireContext(), "ExoPlayer initialization failed", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        exoPlayer?.release()
        exoPlayer = null
        executor.shutdown()
    }
}