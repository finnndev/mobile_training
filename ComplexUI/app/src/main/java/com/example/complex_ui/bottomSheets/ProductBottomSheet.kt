package com.example.complex_ui.bottomSheets

import android.app.Dialog
import android.os.Bundle
import android.view.LayoutInflater
import android.widget.Button
import android.widget.TextView
import com.example.complex_ui.R
import com.example.complex_ui.model.Product
import com.google.android.material.bottomsheet.BottomSheetDialogFragment

class ProductBottomSheet(private val product: Product): BottomSheetDialogFragment() {
    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val dialog = super.onCreateDialog(savedInstanceState)

        val view = LayoutInflater.from(context).inflate(R.layout.bottom_sheet_products, null)
        dialog.setContentView(view)

        val nameTextView = view.findViewById<TextView>(R.id.productName)
        val priceTextView = view.findViewById<TextView>(R.id.productPrice)
        val buyButton = view.findViewById<Button>(R.id.buyButton)

        nameTextView.text = product.name
        priceTextView.text = "Giá: ${product.price}đ"

        buyButton.setOnClickListener {
            dismiss()
        }

        return dialog
    }
}