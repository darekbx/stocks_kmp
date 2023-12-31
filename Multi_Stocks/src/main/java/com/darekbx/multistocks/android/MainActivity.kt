package com.darekbx.multistocks.android

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.darekbx.multistocks.repository.Repository
import org.koin.android.ext.android.inject

class MainActivity : ComponentActivity() {

    private val repository: Repository by inject()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MyApplicationTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colors.background
                ) {
                    var action by remember { mutableStateOf(false) }
                    LaunchedEffect(action) {
                        if (action) {
                            /*
                            val addId = repository.addStock("Allegro", "ale", 0)
                            Log.v("SIGMA", "Added, id: $addId")
                            val stocks = repository.fetchStocks()
                            Log.v("SIGMA", "Fetched stocks, count: ${stocks.size}")
                            val stock = stocks.first()
                            Log.v("SIGMA", "First stock: ${stock.id}, ${stock.label}")

                            Log.v("SIGMA", "Refreshing stock, id: ${stock.id}")
                            repository.refeshStockRates(stock.id)

                            val rates = repository.fetchStockRates(stock.id)
                            Log.v("SIGMA", "Stock rates: ${rates.joinToString(", ") { "${it.value}" }}")
                            */
                            action = false
                        }
                    }

                    Button(onClick = { action = true}) {
                        Text(text = "Add")
                    }
                }
            }
        }
    }
}

@Composable
fun GreetingView(phrases: List<String>) {
    LazyColumn(
        contentPadding = PaddingValues(20.dp),
        verticalArrangement = Arrangement.spacedBy(8.dp),
    ) {
        items(phrases) { phrase ->
            Text(phrase)
            Divider()
        }
    }
}

@Preview
@Composable
fun DefaultPreview() {
    MyApplicationTheme {
        GreetingView(listOf("Hello, Android!"))
    }
}
