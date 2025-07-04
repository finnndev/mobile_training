package com.example.complex_ui.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import com.example.complex_ui.R

class FragmentRight : Fragment() {

    private lateinit var textReceiver: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_right, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        textReceiver = view.findViewById(R.id.textReceiver)
    }

    fun updateText(data: String) {
        textReceiver.text = data
    }

//    fun changeBackgroundColorRandomly() {
//        val colors = listOf(
//            Color.RED,
//            Color.GREEN,
//            Color.BLUE,
//            Color.YELLOW,
//            Color.MAGENTA,
//            Color.CYAN,
//            Color.LTGRAY
//        )
//        val randomColor = colors.random()
//        textReceiver.setBackgroundColor(randomColor)
//    }
    private val sampleTexts = listOf(
        "Xin chào bạn!",
        "Chúc bạn một ngày vui vẻ!",
        "Đây là đoạn text ngẫu nhiên.",
        "Fragment đang hoạt động tốt!",
        "Bạn vừa bấm nút đấy!",
        "Chuyển đổi thành công!",
        "Học Android rất thú vị!"
    )
    fun updateTextRandomly() {
        val randomText = sampleTexts.random()
        textReceiver.text = randomText
    }
}