package com.darekbx.multistocks.repository

import com.darekbx.multistocks.repository.local.LocalDatabase
import com.darekbx.multistocks.repository.remote.RemoteDataSource

class Repository (
    private val remoteDataSource: RemoteDataSource,
    private val localDatabase: LocalDatabase
){
    suspend fun test(): String {
       val result = remoteDataSource.getRawRates("ale")

       if (result.isSuccess) {
           return result.getOrThrow()
       } else {
           return result.exceptionOrNull()?.message ?: "ERROR"
       }
    }
}