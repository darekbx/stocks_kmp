package com.darekbx.multistocks.di

import org.koin.core.module.dsl.singleOf
import org.koin.dsl.module

import com.darekbx.multistocks.repository.local.DatabaseDriverFactory

val androidModule = module {
    singleOf(::DatabaseDriverFactory)
}