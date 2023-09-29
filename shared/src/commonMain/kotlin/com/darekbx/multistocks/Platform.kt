package com.darekbx.multistocks

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform