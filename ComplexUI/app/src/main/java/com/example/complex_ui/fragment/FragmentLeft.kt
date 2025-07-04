package com.example.complex_ui.fragment

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.fragment.app.Fragment
import com.example.complex_ui.R

class FragmentLeft : Fragment() {
    private var listener: onDataSend    ? = null
    interface onDataSend{
        fun onDataSend(data: String)
    }
    override fun onAttach(context: Context) {
        super.onAttach(context)
        // Gắn listener từ Fragment cha
        if (parentFragment is onDataSend) {
            listener = parentFragment as onDataSend
        } else {
            throw RuntimeException("$context phải implement OnDataSendListener")
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_left, container, false)
    }
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val buttonSend = view.findViewById<Button>(R.id.buttonSend)
        buttonSend.setOnClickListener {
            listener?.onDataSend("Xin chào từ Fragment Trái!")
        }
    }
}