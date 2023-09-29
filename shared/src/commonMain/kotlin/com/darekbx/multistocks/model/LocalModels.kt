package com.darekbx.multistocks.model

data class Rate(
    val stockId: Long,
    val value: Double
)

data class Stock(
    val id: Long,
    val label: String,
    val queryParam: String,
    val paramIndex: Long
)