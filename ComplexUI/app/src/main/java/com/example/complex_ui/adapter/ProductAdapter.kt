package com.example.complex_ui.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.example.complex_ui.databinding.ItemProductBinding
import com.example.complex_ui.model.Product

class ProductAdapter(
    private val products: List<Product>,
    private val onItemClick: (Product) -> Unit
) :
    RecyclerView.Adapter<ProductAdapter.ProductViewHolder>() {

    inner class ProductViewHolder(val binding: ItemProductBinding) :
        RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ProductViewHolder {
        val binding = ItemProductBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ProductViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ProductViewHolder, position: Int) {
        val product = products[position]
        with(holder.binding) {
            textName.text = product.name
            textPrice.text = "${product.price} USD"
            Glide.with(imageProduct.context)
                .load(product.imageUrl)
                .into(imageProduct)
        }
        holder.itemView.setOnClickListener {
            onItemClick(product)
        }
    }

    override fun getItemCount() = products.size
}
