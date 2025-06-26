package com.example.complex_ui.model

data class Product(
    val name: String,
    val price: Double,
    val imageUrl: String
)

fun generateFakeProducts(count: Int): List<Product> {
    val productNames = listOf(
        "Áo Thun Nam", "Giày Thể Thao", "Túi Xách Nữ", "Đồng Hồ Thông Minh",
        "Mũ Lưỡi Trai", "Kính Mát", "Quần Jeans", "Áo Khoác", "Balo Du Lịch", "Dép Quai Kẹp"
    )
    val images = listOf(
        "https://picsum.photos/id/101/400/300",
        "https://picsum.photos/id/102/400/300",
        "https://picsum.photos/id/103/400/300",
        "https://picsum.photos/id/104/400/300",
        "https://picsum.photos/id/111/400/300",
        "https://picsum.photos/id/106/400/300",
        "https://picsum.photos/id/107/400/300",
        "https://picsum.photos/id/108/400/300",
        "https://picsum.photos/id/109/400/300",
        "https://picsum.photos/id/110/400/300"
    )

    return List(count) { index ->
        val name = productNames[index % productNames.size]
        val price = (10_000..1_000_000).random() / 100.0 // giá từ 100 đến 10000.00
        val imageUrl = images[index % images.size]
        Product(name, price, imageUrl)
    }
}