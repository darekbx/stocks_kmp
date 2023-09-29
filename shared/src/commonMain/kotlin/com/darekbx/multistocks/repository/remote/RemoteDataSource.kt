package com.darekbx.multistocks.repository.remote

import MultiStocks.shared.BuildConfig
import io.ktor.client.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.request.get
import io.ktor.client.statement.HttpResponse
import io.ktor.client.statement.bodyAsText
import io.ktor.http.HttpStatusCode
import io.ktor.serialization.kotlinx.json.*

class RemoteDataSource(
    private val httpClient: HttpClient
) {

    companion object {
        private const val API_URL = BuildConfig.API_BASE_URL
    }

    @Throws(Exception::class)
    suspend fun getRawRates(query: String): Result<String> =
        try {
            val response: HttpResponse = httpClient.get("$API_URL$query")
            if (response.status == HttpStatusCode.OK) {
                Result.success(response.bodyAsText())
            } else {
                Result.failure(IllegalStateException("HTTP ${response.status.value}"))
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
}