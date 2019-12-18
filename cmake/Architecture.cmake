if(NOT CMAKE_SYSTEM_PROCESSOR)
    if(NOT CMAKE_TOOLCHAIN_FILE AND CMAKE_HOST_SYSTEM_PROCESSOR)
        set(CMAKE_SYSTEM_PROCESSOR ${CMAKE_HOST_SYSTEM_PROCESSOR})
    elseif(CMAKE_TOOLCHAIN_FILE MATCHES mxe)
        if(CMAKE_TOOLCHAIN_FILE MATCHES "i[3-9]86")
            set(CMAKE_SYSTEM_PROCESSOR i686)
        else()
            set(CMAKE_SYSTEM_PROCESSOR x86_64)
        endif()
    endif()
endif()

# turn asm on by default on 32bit x86
# and set WINARCH for windows stuff
if(CMAKE_SYSTEM_PROCESSOR MATCHES "[xX]86|i[3-9]86|[aA][mM][dD]64")
    if(CMAKE_C_SIZEOF_DATA_PTR EQUAL 4) # 32 bit
        set(ASM_DEFAULT ON)
        set(X86_32 ON)
        set(X86 ON)
	set(WINARCH x86)
    else()
        set(AMD64 ON)
        set(X64 ON)
	set(WINARCH x64)
    endif()

    if(DEFINED VCPKG_TARGET_TRIPLET)
        string(REGEX MATCH "^x[86][64]" target_arch ${VCPKG_TARGET_TRIPLET})

        if(NOT WINARCH STREQUAL target_arch)
            message(FATAL_ERROR "Wrong build environment architecture for VCPKG_TARGET_TRIPLET, you specified ${target_arch} but your compiler is for ${WINARCH}")
        endif()
    endif()
endif()
