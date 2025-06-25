package com.example.complex_ui

import android.os.Bundle
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.ActionBarDrawerToggle
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import androidx.core.view.ViewCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.drawerlayout.widget.DrawerLayout
import com.example.complex_ui.fragment.HomeFragment
import com.example.complex_ui.fragment.Card
import com.example.complex_ui.fragment.Order
import com.example.complex_ui.fragment.Account
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.google.android.material.navigation.NavigationView

class MainActivity : AppCompatActivity() {

    private lateinit var drawerLayout: DrawerLayout

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        WindowCompat.setDecorFitsSystemWindows(window, true)
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        drawerLayout = findViewById(R.id.main)
        val toolbar = findViewById<Toolbar>(R.id.toolbar)
        setSupportActionBar(toolbar)
//        toolbar.setOnClickListener {
//            drawerLayout.open()
//        }

        //Setup Toolbar
        val toggle = ActionBarDrawerToggle(
            this, drawerLayout, toolbar,
            R.string.open_nav,
            R.string.close_nav
        )
        drawerLayout.addDrawerListener(toggle)
        toggle.syncState()

        navigationEvent()
        bottomNavigationEvent()
        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .replace(R.id.frame_layout, HomeFragment())
                .commit()
        }

    }

    fun navigationEvent() {
        val navigationView = findViewById<NavigationView>(R.id.nav_view)
        navigationView.setNavigationItemSelectedListener { menuItem ->
            when (menuItem.itemId) {
                R.id.nav_home -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.frame_layout, HomeFragment())
                        .commit()
                }

                R.id.nav_settings -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.frame_layout, Card())
                        .commit()
                }

                R.id.nav_share -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.frame_layout, Order())
                        .commit()
                }

                R.id.nav_about -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.frame_layout, Account())
                        .commit()
                }

                R.id.nav_logout -> {
                    Toast.makeText(this, "Logout!", Toast.LENGTH_SHORT).show()
                }

                else -> {
                    Toast.makeText(this, "Error!", Toast.LENGTH_SHORT).show()
                }
            }
            drawerLayout.close()
            true
        }
    }

    private fun bottomNavigationEvent() {
        val bottomNavigationView = findViewById<BottomNavigationView>(R.id.bottomNavigationView)
        bottomNavigationView.setOnItemSelectedListener { item ->
            when (item.itemId) {
                R.id.home -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.frame_layout, HomeFragment())
                        .commit()
                }

                R.id.card -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.frame_layout, Card())
                        .commit()
                }

                R.id.order -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.frame_layout, Order())
                        .commit()
                }

                R.id.account -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.frame_layout, Account())
                        .commit()
                }

                R.id.nav_logout -> {
                    Toast.makeText(this, "Logout!", Toast.LENGTH_SHORT).show()
                }

                else -> {
                    supportFragmentManager.beginTransaction()
                        .replace(R.id.frame_layout, HomeFragment())
                        .commit()
                }

            }
            drawerLayout.close()
            true
        }
    }
}