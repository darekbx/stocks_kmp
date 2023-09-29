package com.darekbx.multistocks.android

import android.app.Application
import com.darekbx.multistocks.di.androidModule
import com.darekbx.multistocks.di.commonModule
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.context.startKoin

class MainApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        startKoin {
            androidContext(this@MainApplication)
            androidLogger()
            modules(commonModule, androidModule)
        }
    }
}