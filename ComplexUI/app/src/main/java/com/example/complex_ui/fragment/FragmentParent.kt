package com.example.complex_ui.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.complex_ui.R

class FragmentParent : Fragment(), FragmentLeft.onDataSend {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val view = inflater.inflate(R.layout.fragment_parent, container, false)
        if (childFragmentManager.findFragmentById(R.id.fragment_container_left) == null) {
            childFragmentManager.beginTransaction()
                .replace(R.id.fragment_container_left, FragmentLeft())
                .replace(R.id.fragment_container_right, FragmentRight())
                .commit()
        }
        return view
    }
    override fun onDataSend(data: String) {
        val fragmentRight = childFragmentManager.findFragmentById(R.id.fragment_container_right) as? FragmentRight
        fragmentRight?.updateTextRandomly()
    }
}