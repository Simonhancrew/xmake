--!A cross-platform build utility based on Lua
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- Copyright (C) 2015-present, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        xmake.lua
--

-- define toolchain
toolchain("muslcc")

    -- set homepage
    set_homepage("https://musl.cc/")
    set_description("The musl-based cross-compilation toolchains")

    -- mark as cross-compilation toolchain
    set_kind("cross")

    -- add packages
    add_packages("muslcc")

    -- on load
    on_load(function (toolchain)

        -- load basic configuration of cross toolchain
        toolchain:load_cross_toolchain()

        -- add flags for arch
        if toolchain:is_arch("arm") then
            toolchain:add("cxflags", "-march=armv7-a", "-msoft-float", {force = true})
            toolchain:add("ldflags", "-march=armv7-a", "-msoft-float", {force = true})
            toolchain:add("syslinks", "atomic") -- fix undefined reference to `__atomic_fetch_add_8'
        end
        toolchain:add("ldflags", "--static", {force = true})
        toolchain:add("syslinks", "gcc", "c")
    end)
