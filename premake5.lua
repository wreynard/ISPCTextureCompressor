-- ISPCTextureCompressor/premake5.lua

	-------------------------------
	-- [ PROJECT CONFIGURATION ] --
	-------------------------------
	project "ispc_texcomp"
		kind "StaticLib"
		language "C++"
		cppdialect "C++17"
		targetdir ("%{prj.location}/bin/%{cfg.platform}/%{cfg.buildcfg}")
		objdir "%{prj.location}/obj/%{prj.name}/%{cfg.platform}/%{cfg.buildcfg}"
		buildoptions { "/openmp" }

		local srcDir = "./ispc_texcomp/"

		files
		{
			srcDir .. "*.h",
			srcDir .. "*.hpp",
			srcDir .. "*.inl",
			srcDir .. "*.cpp",
			srcDir .. "*.ispc",
			srcDir .. "*.def",
		}

		filter { 'files:' .. "**.ispc" }

		-- ispc -g -O2 "bc7e.ispc" -o "$bc7e.obj" -h "$bc7e_ispc.h" --target=sse2,sse4,avx,avx2 --opt=fast-math --opt=disable-assertions

			buildmessage '%{file.name}'
			buildcommands { 'ispc -g -O2 %{ file.abspath} -o %{cfg.objdir}%{ file.basename}.obj -h generated/%{ file.basename}_ispc.h --target=sse2,sse4,avx,avx2 --opt=fast-math --opt=disable-assertions' }
			buildoutputs { '%{cfg.objdir}/%{ file.basename}.obj', '%{cfg.objdir}/%{ file.basename}_sse2.obj', '%{cfg.objdir}/%{ file.basename}_sse4.obj', '%{cfg.objdir}/%{ file.basename}_avx.obj', '%{cfg.objdir}/%{ file.basename}_avx2.obj' }
			compilebuildoutputs 'true'

		filter { }

		local out_dir = path.join('%{ prj.location}', 'generated/')
		includedirs { srcDir, out_dir }