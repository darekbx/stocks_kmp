package com.darekbx.multistocks.model

import kotlinx.serialization.Serializable

@Serializable
data class Rate(
    val stockId: Long,
    val value: Double
)

@Serializable
data class Stock(
    val id: Long,
    val label: String,
    val queryParam: String,
    val paramIndex: Long
)