package com.darekbx.multistocks.di

import io.ktor.client.HttpClient
import org.koin.core.module.dsl.singleOf
import org.koin.dsl.module

import com.darekbx.multistocks.repository.remote.RemoteDataSource
import com.darekbx.multistocks.repository.local.LocalDatabase
import com.darekbx.multistocks.repository.Repository

val commonModule = module {
    singleOf<HttpClient>(::HttpClient)
    singleOf(::RemoteDataSource)
    singleOf(::LocalDatabase)
    singleOf(::Repository)
}