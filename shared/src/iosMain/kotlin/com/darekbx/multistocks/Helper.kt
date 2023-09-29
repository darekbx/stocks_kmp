package com.darekbx.multistocks

import com.darekbx.multistocks.di.appModule
import com.darekbx.multistocks.di.commonModule
import com.darekbx.multistocks.repository.Repository
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.context.startKoin
import kotlin.experimental.ExperimentalObjCName

@OptIn(ExperimentalObjCName::class)
@ObjCName("AppleHelper")
class Helper : KoinComponent {
    private val _repository: Repository by inject()
    fun repo() = _repository
}

fun initKoin() {
    startKoin {
        modules(commonModule, appModule)
    }
}
