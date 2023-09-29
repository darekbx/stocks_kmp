package com.darekbx.multistocks.repository.local

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class StockDto(
    val label: String,
    @SerialName("query_param")
    val queryParam: String,
)

@Serializable
data class RateDto(
    @SerialName("currency_id")
    val currencyId: Long,
    val value: Double,
)