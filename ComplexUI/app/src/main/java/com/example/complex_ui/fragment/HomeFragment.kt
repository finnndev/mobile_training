package com.example.complex_ui.fragment

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.complex_ui.R
import com.example.complex_ui.adapter.ProductAdapter
import com.example.complex_ui.bottomSheets.ProductBottomSheet
import com.example.complex_ui.model.generateFakeProducts

class HomeFragment : Fragment() {

    private lateinit var recyclerView: RecyclerView
    private lateinit var adapter: ProductAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_home, container, false)
        recyclerView = view.findViewById(R.id.recyclerView)
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val products = generateFakeProducts(20)
        val adapter = ProductAdapter(products) { product ->
            // Mở BottomSheet khi nhấp vào item
            val bottomSheet = ProductBottomSheet(product)
            bottomSheet.show(parentFragmentManager, "ProductBottomSheet")
        }
//        adapter = ProductAdapter(products)
        recyclerView.layoutManager = GridLayoutManager(requireContext(), 2)
        recyclerView.adapter = adapter
    }
}