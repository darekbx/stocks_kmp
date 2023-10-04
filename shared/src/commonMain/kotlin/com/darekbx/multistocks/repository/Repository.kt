package com.darekbx.multistocks.repository

import com.darekbx.multistocks.model.Rate
import com.darekbx.multistocks.model.Stock
import com.darekbx.multistocks.repository.local.LocalDatabase
import com.darekbx.multistocks.repository.remote.RemoteDataSource
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.withContext

class Repository(
    private val remoteDataSource: RemoteDataSource,
    private val localDatabase: LocalDatabase,
    private val ratesParser: RatesParser
) {
    suspend fun deleteStock(stockId: Long) {
        withContext(Dispatchers.IO) {
            localDatabase.deleteStock(stockId)
            localDatabase.deleteStockRates(stockId)
        }
    }

    suspend fun addStock(label: String, queryParam: String, paramIndex: Int)  =
        withContext(Dispatchers.IO) {
            localDatabase.addStock(label, queryParam, paramIndex.toLong())
        }

    suspend fun fetchStocks(): List<Stock> =
        withContext(Dispatchers.IO) {
            localDatabase.fetchStocks()
        }

    suspend fun fetchStockRates(stockId: Long): List<Rate> =
        withContext(Dispatchers.IO) {
            localDatabase.fetchRates(stockId)
        }

    suspend fun fetchLatestStockRate(stockId: Long): Rate? =
        withContext(Dispatchers.IO) {
            localDatabase.fetchLatestRate(stockId)
        }

    suspend fun refeshStockRates(stockId: Long) =
        withContext(Dispatchers.IO) {
            localDatabase.fetchStock(stockId)?.let { stock ->
                val queryParam = stock.queryParam
                val paramIndex = stock.paramIndex.toInt()
                val rawRatesResponse = remoteDataSource.getRawRates(queryParam)
                if (rawRatesResponse.isSuccess) {
                    val rawRates = rawRatesResponse.getOrThrow()
                    ratesParser.parseResponse(rawRates, paramIndex)?.let { parsedRate ->
                        localDatabase.addRate(stockId, parsedRate)
                    }
                } else {
                    rawRatesResponse.exceptionOrNull()
                        ?.printStackTrace()
                }
            }
        }
}