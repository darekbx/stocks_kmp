package com.darekbx.multistocks.repository.local

import com.darekbx.multistocks.model.Rate
import com.darekbx.multistocks.model.Stock

class LocalDatabase(databaseDriverFactory: DatabaseDriverFactory) {

    private val database = AppDatabase(databaseDriverFactory.createDriver())
    private val dbQuery = database.appDatabaseQueries

    internal fun addStock(label: String, queryParam: String, paramIndex: Long): Long {
        dbQuery.insertStock(label, queryParam, paramIndex)
        return dbQuery.lastInsertRowId().executeAsOne()
    }

    internal fun addRate(stockId: Long, value: Double) {
        dbQuery.insertRate(stockId, value)
    }

    internal fun fetchStocks(): List<Stock> {
        return dbQuery.selectAllStocks(::stockMapper).executeAsList()
    }

    internal fun fetchRates(stockId: Long): List<Rate> {
        return dbQuery.selectAllRates(stockId, ::rateMapper).executeAsList()
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