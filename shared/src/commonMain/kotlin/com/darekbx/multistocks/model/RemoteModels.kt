package com.darekbx.multistocks.model

import kotlinx.serialization.Serializable

@Serializable
data class RemoteTable(
    val table: String,
    val no: String,
    val effectiveDate: String,
    val rates: List<RemoteRate>
)

@Serializable
data class RemoteRate(
    var currency: String,
    var code: String,
    var mid: Double
)