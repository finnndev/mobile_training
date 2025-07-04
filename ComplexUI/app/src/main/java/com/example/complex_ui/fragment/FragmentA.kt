package com.example.complex_ui.fragment

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.fragment.app.Fragment
import com.example.complex_ui.MainActivity
import com.example.complex_ui.R

class FragmentA : Fragment() {

    private var counter = 0

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val view = inflater.inflate(R.layout.fragment_a, container, false)
        val buttonDecrement = view.findViewById<Button>(R.id.btnDecrement)
        val buttonIncrement = view.findViewById<Button>(R.id.btnIncrement)
        val tvCounter = view.findViewById<TextView>(R.id.tvCounter)
        counter = tvCounter.text.toString().toIntOrNull() ?: 0

        val mainActivity = activity as MainActivity

        counter = mainActivity.saveCounter
        tvCounter.text = counter.toString()
        if (counter <= 0) counter = 0

        buttonDecrement.setOnClickListener {
            if (counter > 0) counter--
            tvCounter.text = counter.toString()
            mainActivity.saveCounter = counter
        }
        buttonIncrement.setOnClickListener {
            counter++
            tvCounter.text = counter.toString()
            mainActivity.saveCounter = counter
        }
        // Inflate the layout for this fragment
        return view
    }

    override fun onPause() {
        super.onPause()
        Log.d("Fragment", "fragment 1 onPause")
    }

    override fun onResume() {
        super.onResume()
        Log.d("Fragment", "fragment 1 onResume")
    }
}