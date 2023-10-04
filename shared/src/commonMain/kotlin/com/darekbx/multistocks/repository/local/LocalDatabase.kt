package com.darekbx.multistocks.repository.local

import com.darekbx.multistocks.model.Rate
import com.darekbx.multistocks.model.Stock

class LocalDatabase(appDatabase: AppDatabase) {

    private val dbQuery = appDatabase.appDatabaseQueries

    internal fun addStock(label: String, queryParam: String, paramIndex: Long): Long {
        dbQuery.insertStock(label, queryParam, paramIndex)
        return dbQuery.lastInsertRowId().executeAsOne()
    }

    internal fun addRate(stockId: Long, value: Double) {
        dbQuery.insertRate(stockId, value)
    }

    internal fun fetchStock(stockId: Long): Stock? {
        return dbQuery.selectStock(stockId, ::stockMapper).executeAsOne()
    }

    internal fun fetchStocks(): List<Stock> {
        return dbQuery.selectAllStocks(::stockMapper).executeAsList()
    }

    internal fun fetchRates(stockId: Long): List<Rate> {
        return dbQuery.selectAllRates(stockId, ::rateMapper).executeAsList()
    }

    internal fun fetchLatestRate(stockId: Long): Rate? {
        return dbQuery.selectLatestRate(stockId, ::rateMapper).executeAsList()?.firstOrNull()
    }

    internal fun deleteStock(stockId: Long) {
        dbQuery.removeStock(stockId)
    }

    internal fun deleteStockRates(stockId: Long) {
        dbQuery.removeStockRates(stockId)
    }

    internal fun clearDatabase() {
        dbQuery.removeAllStocks()
        dbQuery.removeAllRates()
    }

    private fun stockMapper(id: Long, label: String, queryParam: String, paramIndex: Long): Stock {
        return Stock(id, label, queryParam, paramIndex)
    }

    private fun rateMapper(id: Long, stockId: Long, value: Double): Rate {
        return Rate(stockId, value)
    }
}