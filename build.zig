const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const strip = b.option(bool, "strip", "Omit debug information");
    const sanitize_thread = b.option(bool, "sanitize_thread", "Enable thread sanitizer");

    const zlib_dep = b.dependency("zlib", .{
        .target = target,
        .optimize = optimize,
    });

    const zlib = zlib_dep.artifact("z");

    const upstream = b.dependency("nasm", .{});

    const have_htole = if (target.result.os.tag != .windows and !target.result.os.tag.isDarwin()) true else null;
    const config = b.addConfigHeader(.{
        .include_path = "config/config.h",
        .style = .{ .autoconf_undef = upstream.path("config/config.h.in") },
    }, .{
        .ABORT_ON_PANIC = null,
        .AC_APPLE_UNIVERSAL_BUILD = null,
        .CFLAGS_FDATA_SECTIONS = true,
        .CFLAGS_FFUNCTION_SECTIONS = true,
        .CFLAGS_FGNU89_INLINE = null,
        .CFLAGS_FNO_COMMON = true,
        .CFLAGS_FNO_OMIT_FRAME_POINTER = null,
        .CFLAGS_FSANITIZE_ADDRESS = sanitize_thread,
        .CFLAGS_FSANITIZE_UNDEFINED = null,
        .CFLAGS_FTRIVIAL_AUTO_VAR_INIT_ZERO = true,
        .CFLAGS_FVISIBILITY_HIDDEN = true,
        .CFLAGS_FWRAPV = true,
        .CFLAGS_G3 = null,
        .CFLAGS_GGDB3 = true,
        .CFLAGS_O0 = null,
        .CFLAGS_OG = null,
        .CFLAGS_PEDANTIC = true,
        .CFLAGS_PG = null,
        .CFLAGS_W = true,
        .CFLAGS_WALL = true,
        .CFLAGS_WERROR = null,
        .CFLAGS_WERROR_COMMENT = true,
        .CFLAGS_WERROR_IMPLICIT = true,
        .CFLAGS_WERROR_MISSING_BRACES = true,
        .CFLAGS_WERROR_MISSING_DECLARATIONS = true,
        .CFLAGS_WERROR_MISSING_PROTOTYPES = true,
        .CFLAGS_WERROR_POINTER_ARITH = true,
        .CFLAGS_WERROR_RETURN_TYPE = true,
        .CFLAGS_WERROR_STRICT_PROTOTYPES = true,
        .CFLAGS_WERROR_TRIGRAPHS = true,
        .CFLAGS_WERROR_UNKNOWN_WARNING_OPTION = true,
        .CFLAGS_WERROR_VLA = true,
        .CFLAGS_WNO_LONG_LONG = true,
        .CFLAGS_WNO_PEDANTIC_MS_FORMAT = null,
        .CFLAGS_WNO_SHIFT_NEGATIVE_VALUE = true,
        .CFLAGS_WNO_STRINGOP_TRUNCATION = null,
        .CFLAGS_WNO_VARIADIC_MACROS = true,
        .CFLAGS_WSUGGEST_ATTRIBUTE_COLD = null,
        .CFLAGS_WSUGGEST_ATTRIBUTE_CONST = null,
        .CFLAGS_WSUGGEST_ATTRIBUTE_FORMAT = null,
        .CFLAGS_WSUGGEST_ATTRIBUTE_MALLOC = null,
        .CFLAGS_WSUGGEST_ATTRIBUTE_NORETURN = null,
        .CFLAGS_WSUGGEST_ATTRIBUTE_PURE = null,
        .CPPFLAGS_WERROR_ATTRIBUTES = true,
        .HAVE_ACCESS = true,
        .HAVE_CANONICALIZE_FILE_NAME = null,
        .HAVE_CPU_TO_LE16 = null,
        .HAVE_CPU_TO_LE32 = null,
        .HAVE_CPU_TO_LE64 = null,
        .HAVE_DECL_STRCASECMP = true,
        .HAVE_DECL_STRICMP = false,
        .HAVE_DECL_STRLCPY = if (target.result.os.tag != .windows) true else null,
        .HAVE_DECL_STRNCASECMP = true,
        .HAVE_DECL_STRNICMP = false,
        .HAVE_DECL_STRNLEN = true,
        .HAVE_DECL_STRRCHRNUL = false,
        .HAVE_DECL_STRSEP = true,
        .HAVE_ENDIAN_H = if (target.result.os.tag != .windows and !target.result.os.tag.isDarwin()) true else null,
        .HAVE_FACCESSAT = true,
        .HAVE_FCNTL_H = true,
        .HAVE_FILENO = true,
        .HAVE_FSEEKO = true,
        .HAVE_FSTAT = true,
        .HAVE_FTRUNCATE = true,
        .HAVE_FUNC_ATTRIBUTE_COLD = true,
        .HAVE_FUNC_ATTRIBUTE_CONST = true,
        .HAVE_FUNC_ATTRIBUTE_ERROR = true,
        .HAVE_FUNC_ATTRIBUTE_MALLOC = true,
        .HAVE_FUNC_ATTRIBUTE_NORETURN = true,
        .HAVE_FUNC_ATTRIBUTE_PURE = true,
        .HAVE_FUNC_ATTRIBUTE_RETURNS_NONNULL = true,
        .HAVE_FUNC_ATTRIBUTE_SENTINEL = true,
        .HAVE_FUNC_ATTRIBUTE_UNUSED = true,
        .HAVE_FUNC_PTR_ATTRIBUTE_COLD = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_CONST = true,
        .HAVE_FUNC_PTR_ATTRIBUTE_MALLOC = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_NORETURN = true,
        .HAVE_FUNC_PTR_ATTRIBUTE_PURE = true,
        .HAVE_FUNC_PTR_ATTRIBUTE_RETURNS_NONNULL = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_SENTINEL = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_UNUSED = true,
        .HAVE_GETGID = true,
        .HAVE_GETPAGESIZE = if (target.result.os.tag != .windows) true else null,
        .HAVE_GETRLIMIT = true,
        .HAVE_GETUID = true,
        .HAVE_HTOLE16 = have_htole,
        .HAVE_HTOLE32 = have_htole,
        .HAVE_HTOLE64 = have_htole,
        .HAVE_INTRIN_H = null,
        .HAVE_INTTYPES_H = true,
        .HAVE_IO_H = null,
        .HAVE_ISASCII = true,
        .HAVE_ISCNTRL = true,
        .HAVE_MACHINE_ENDIAN_H = if (target.result.os.tag.isDarwin()) true else null,
        .HAVE_MEMPCPY = if (target.result.abi.isGnu() or target.result.os.tag == .freebsd) true else null,
        .HAVE_MEMPSET = null,
        .HAVE_MINIX_CONFIG_H = null,
        .HAVE_MMAP = if (target.result.os.tag != .windows and target.result.os.tag != .wasi) true else null,
        .HAVE_PATHCONF = true,
        .HAVE_REALPATH = if (target.result.os.tag != .windows) true else null,
        .HAVE_SNPRINTF = true,
        .HAVE_STAT = true,
        .HAVE_STDARG_H = true,
        .HAVE_STDBOOL_H = true,
        .HAVE_STDC_INLINE = true,
        .HAVE_STDINT_H = true,
        .HAVE_STDIO_H = true,
        .HAVE_STDLIB_H = true,
        .HAVE_STDNORETURN_H = true,
        .HAVE_STRCASECMP = true,
        .HAVE_STRICMP = null,
        .HAVE_STRINGS_H = true,
        .HAVE_STRING_H = true,
        .HAVE_STRLCPY = if (!target.result.abi.isGnu()) true else null,
        .HAVE_STRNCASECMP = true,
        .HAVE_STRNICMP = null,
        .HAVE_STRNLEN = true,
        .HAVE_STRRCHRNUL = null,
        .HAVE_STRSEP = if (target.result.os.tag != .windows) true else null,
        .HAVE_STRUCT_STAT = true,
        .HAVE_STRUCT__STATI64 = null,
        .HAVE_SYSCONF = true,
        .HAVE_SYS_ENDIAN_H = null,
        .HAVE_SYS_MMAN_H = if (target.result.os.tag != .windows and target.result.os.tag != .wasi) true else null,
        .HAVE_SYS_PARAM_H = true,
        .HAVE_SYS_RESOURCE_H = if (target.result.os.tag != .windows and target.result.os.tag != .wasi) true else null,
        .HAVE_SYS_STAT_H = true,
        .HAVE_SYS_TYPES_H = true,
        .HAVE_S_ISREG = null,
        .HAVE_TYPEOF = true,
        .HAVE_UINTPTR_T = true,
        .HAVE_UNISTD_H = true,
        .HAVE_VARIADIC_MACROS = true,
        .HAVE_VSNPRINTF = true,
        .HAVE_WCHAR_H = true,
        .HAVE__ACCESS = null,
        .HAVE__BITSCANREVERSE = null,
        .HAVE__BITSCANREVERSE64 = null,
        .HAVE__BOOL = true,
        .HAVE__BYTESWAP_UINT64 = null,
        .HAVE__BYTESWAP_ULONG = null,
        .HAVE__BYTESWAP_USHORT = null,
        .HAVE__CHSIZE = null,
        .HAVE__CHSIZE_S = null,
        .HAVE__FILENO = null,
        .HAVE__FSEEKI64 = null,
        .HAVE__FSTATI64 = null,
        .HAVE__FULLPATH = null,
        .HAVE__STATI64 = null,
        .HAVE___BUILTIN_BSWAP16 = true,
        .HAVE___BUILTIN_BSWAP32 = true,
        .HAVE___BUILTIN_BSWAP64 = true,
        .HAVE___BUILTIN_CHOOSE_EXPR = true,
        .HAVE___BUILTIN_CLZ = true,
        .HAVE___BUILTIN_CLZLL = true,
        .HAVE___BUILTIN_CONSTANT_P = true,
        .HAVE___BUILTIN_EXPECT = true,
        .HAVE___CPU_TO_LE16 = null,
        .HAVE___CPU_TO_LE32 = null,
        .HAVE___CPU_TO_LE64 = null,
        .LDFLAGS_WL_AS_NEEDED = true,
        .LDFLAGS_WL_GC_SECTIONS = true,
        .PACKAGE_BUGREPORT = "",
        .PACKAGE_NAME = "",
        .PACKAGE_STRING = "",
        .PACKAGE_TARNAME = "",
        .PACKAGE_URL = "",
        .PACKAGE_VERSION = "",
        .STDC_HEADERS = true,
        .WORDS_BIGENDIAN = if (target.result.cpu.arch.endian() == .big) true else null,
        .WORDS_LITTLEENDIAN = if (target.result.cpu.arch.endian() == .little) true else null,
        ._FILE_OFFSET_BITS = null,
        ._LARGEFILE_SOURCE = null,
        ._LARGE_FILES = null,
        .@"const" = .@"const",
        .@"inline" = .@"inline",
        .restrict = .__restrict__,
        .size_t = null,
        .snprintf = null,
        .typeof = .__typeof,
        .uintptr_t = null,
        .vsnprintf = null,
        ._ALL_SOURCE = null,
        ._DARWIN_C_SOURCE = null,
        .__EXTENSIONS__ = null,
        ._GNU_SOURCE = null,
        ._HPUX_ALT_XOPEN_SOCKET_API = null,
        ._MINIX = null,
        ._NETBSD_SOURCE = null,
        ._OPENBSD_SOURCE = null,
        ._POSIX_SOURCE = null,
        ._POSIX_1_SOURCE = null,
        ._POSIX_PTHREAD_SEMANTICS = null,
        .__STDC_WANT_IEC_60559_ATTRIBS_EXT__ = null,
        .__STDC_WANT_IEC_60559_BFP_EXT__ = null,
        .__STDC_WANT_IEC_60559_DFP_EXT__ = null,
        .__STDC_WANT_IEC_60559_FUNCS_EXT__ = null,
        .__STDC_WANT_IEC_60559_TYPES_EXT__ = null,
        .__STDC_WANT_LIB_EXT2__ = null,
        .__STDC_WANT_MATH_SPEC_FUNCS__ = null,
        ._TANDEM_SOURCE = null,
        ._XOPEN_SOURCE = null,
        // New in 3.01
        .CFLAGS_STD_C11 = null,
        .CFLAGS_STD_C17 = null,
        .CFLAGS_STD_C23 = null,
        .CFLAGS_STD_C99 = null,
        .CFLAGS_U_STRICT_ANSI_ = null,
        .HAVE_ARPA_INET_H = null,
        .HAVE_BSWAP_16 = null,
        .HAVE_BSWAP_32 = null,
        .HAVE_BSWAP_64 = null,
        .HAVE_BYTESWAP_H = null,
        .HAVE_CPU_TO_BE16 = null,
        .HAVE_CPU_TO_BE32 = null,
        .HAVE_CPU_TO_BE64 = null,
        .HAVE_FUNC_ATTRIBUTE_1_ALLOC_SIZE = null,
        .HAVE_FUNC_ATTRIBUTE_2_ALLOC_SIZE = null,
        .HAVE_FUNC_ATTRIBUTE_3_FORMAT = null,
        .HAVE_FUNC_ATTRIBUTE_MAYBE_UNUSED = null,
        .HAVE_FUNC_ATTRIBUTE_REPRODUCIBLE = null,
        .HAVE_FUNC_ATTRIBUTE_UNSEQUENCED = null,
        .HAVE_FUNC_NAME = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_1_ALLOC_SIZE = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_2_ALLOC_SIZE = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_3_FORMAT = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_MAYBE_UNUSED = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_REPRODUCIBLE = null,
        .HAVE_FUNC_PTR_ATTRIBUTE_UNSEQUENCED = null,
        .HAVE_HTOBE16 = null,
        .HAVE_HTOBE32 = null,
        .HAVE_HTOBE64 = null,
        .HAVE_HTONL = null,
        .HAVE_HTONQ = null,
        .HAVE_HTONS = null,
        .HAVE_STDBIT_H = null,
        .HAVE_STDC_LEADING_ZEROS = null,
        .HAVE_UINTMAX_T = null,
        .HAVE_UNSIGNED_LONG_LONG_INT = null,
        .HAVE_VARADIC_MACROS_COMMA_HACK = null,
        .HAVE___BUILTIN_PREFETCH = null,
        .HAVE___CPU_TO_BE16 = null,
        .HAVE___CPU_TO_BE64 = null,
        .__STDC_WANT_IEC_60559_EXT__ = null,
        ._FLTO_AUTO_FLTO = null,
        ._TIME_BITS = null,
        .__MINGW_USE_VC2005_COMPAT = null,
        .__func__ = null,
        .uintmax_t = null,
    });

    const mod_options: std.Build.Module.CreateOptions = .{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .strip = strip,
        .sanitize_thread = sanitize_thread,
    };

    const flags = &.{
        "-std=c17",
        "-fwrapv",
        "-ftrivial-auto-var-init=zero",
        "-fno-common",
        "-fvisibility=hidden",
        "-DHAVE_CONFIG_H=1",
        "-D__DATE__=\"(build date omitted)\"",
    };

    const include_paths: []const std.Build.LazyPath = &.{
        upstream.path("include"),
        upstream.path("asm"),
        upstream.path("x86"),
        upstream.path("output"),
        upstream.path("."),
    };

    const nasm_common_mod = b.createModule(mod_options);
    for (include_paths) |path| nasm_common_mod.addIncludePath(path);
    nasm_common_mod.addConfigHeader(config);
    nasm_common_mod.addCSourceFiles(.{
        .root = upstream.path("."),
        .files = nasm_common_sources,
        .flags = flags,
    });

    const nasm_common = b.addLibrary(.{
        .name = "nasm_common",
        .root_module = nasm_common_mod,
    });
    nasm_common.installConfigHeader(config);

    const nasm = b.addExecutable(.{
        .name = "nasm",
        .root_module = b.createModule(mod_options),
    });
    b.installArtifact(nasm);
    for (include_paths) |path| nasm.root_module.addIncludePath(path);
    nasm.root_module.linkLibrary(nasm_common);
    nasm.root_module.linkLibrary(zlib);
    nasm.root_module.addCSourceFiles(.{
        .root = upstream.path("asm"),
        .files = nasm_asm_sources,
        .flags = flags,
    });

    const ndisasm = b.addExecutable(.{
        .name = "ndisasm",
        .root_module = b.createModule(mod_options),
    });
    b.installArtifact(ndisasm);
    for (include_paths) |path| ndisasm.root_module.addIncludePath(path);
    ndisasm.root_module.linkLibrary(nasm_common);
    ndisasm.root_module.addCSourceFiles(.{
        .root = upstream.path("disasm"),
        .files = nasm_disasm_sources,
        .flags = flags,
    });

    const test_step = b.step("test", "Run tests");

    {
        // elf64 test
        const run_nasm = b.addRunArtifact(nasm);
        test_step.dependOn(&run_nasm.step);
        if (target.result.os.tag == .wasi) {
            // we need all files in the Zig cache to be accessible in the WASI sandbox
            run_nasm.setCwd(.{ .cwd_relative = "/" });
        }
        run_nasm.addArg("-f");
        run_nasm.addArg("elf64");
        run_nasm.addFileArg(upstream.path("test/elf64so.asm"));
        run_nasm.addArg("-o");
        const object_file = run_nasm.addOutputFileArg("elf64so.o");

        const elftest64 = b.addExecutable(.{
            .name = "elftest64",
            .root_module = b.createModule(.{
                .target = b.resolveTargetQuery(.{
                    .cpu_arch = .x86_64,
                    .os_tag = .linux,
                }),
                .optimize = optimize,
                .link_libc = true,
            }),
        });
        elftest64.root_module.addObjectFile(object_file);
        elftest64.root_module.addCSourceFile(.{
            .file = upstream.path("test/elftest64.c"),
            .flags = &.{"-std=c17"},
        });

        const run_elftest64 = b.addRunArtifact(elftest64);
        run_elftest64.skip_foreign_checks = true;
        run_elftest64.addCheck(.{ .expect_stdout_match = elftest64_output_part1 });
        run_elftest64.addCheck(.{ .expect_stdout_match = elftest64_output_part2 });
        test_step.dependOn(&run_elftest64.step);
    }

    {
        // coff test
        const run_nasm = b.addRunArtifact(nasm);
        test_step.dependOn(&run_nasm.step);
        if (target.result.os.tag == .wasi) {
            // we need all files in the Zig cache to be accessible in the WASI sandbox
            run_nasm.setCwd(.{ .cwd_relative = "/" });
        }
        run_nasm.addArg("-f");
        run_nasm.addArg("win32");
        run_nasm.addFileArg(upstream.path("test/cofftest.asm"));
        run_nasm.addArg("-o");
        const object_file = run_nasm.addOutputFileArg("cofftest.o");

        const cofftest = b.addExecutable(.{
            .name = "cofftest",
            .root_module = b.createModule(.{
                .target = b.resolveTargetQuery(.{
                    .cpu_arch = .x86,
                    .os_tag = .windows,
                }),
                .optimize = optimize,
                .link_libc = true,
            }),
        });
        cofftest.root_module.addObjectFile(object_file);
        cofftest.root_module.addCSourceFile(.{
            .file = upstream.path("test/cofftest.c"),
            .flags = &.{"-std=c17"},
        });

        const run_cofftest = b.addRunArtifact(cofftest);
        run_cofftest.skip_foreign_checks = true;
        run_cofftest.addCheck(.{ .expect_stdout_match = cofftest_output });
        test_step.dependOn(&run_cofftest.step);
    }
}

const nasm_common_sources = &.{
    "nasmlib/alloc.c",
    "nasmlib/asprintf.c",
    "nasmlib/badenum.c",
    "nasmlib/bsi.c",
    "nasmlib/crc32b.c",
    "nasmlib/crc64.c",
    // "nasmlib/errfile.c", -- this defines a duplicate symbol
    "nasmlib/file.c",
    "nasmlib/filename.c",
    "nasmlib/hashtbl.c",
    "nasmlib/ilog2.c",
    "nasmlib/md5c.c",
    "nasmlib/mmap.c",
    "nasmlib/nctype.c",
    "nasmlib/numstr.c",
    "nasmlib/path.c",
    "nasmlib/perfhash.c",
    "nasmlib/raa.c",
    "nasmlib/rbtree.c",
    "nasmlib/readnum.c",
    "nasmlib/realpath.c",
    "nasmlib/rlimit.c",
    "nasmlib/saa.c",
    "nasmlib/string.c",
    "nasmlib/strlist.c",
    "nasmlib/ver.c",
    "nasmlib/zerobuf.c",

    "x86/iflag.c",
    "x86/insnsa.c",
    "x86/insnsb.c",
    "x86/insnsd.c",
    "x86/insnsn.c",
    "x86/regdis.c",
    "x86/regflags.c",
    "x86/regs.c",
    "x86/regvals.c",

    "common/common.c",

    "stdlib/snprintf.c",
    "stdlib/strlcpy.c",
    "stdlib/strnlen.c",
    "stdlib/strrchrnul.c",
    "stdlib/vsnprintf.c",

    "macros/macros.c",

    "output/codeview.c",
    "output/nulldbg.c",
    "output/nullout.c",
    "output/outaout.c",
    "output/outas86.c",
    "output/outbin.c",
    "output/outcoff.c",
    "output/outdbg.c",
    "output/outelf.c",
    "output/outform.c",
    "output/outieee.c",
    "output/outlib.c",
    "output/outmacho.c",
    "output/outobj.c",

    // ndisasm also needs these:
    "asm/error.c",
    "asm/warnings.c",
    "asm/getbool.c",
};

const nasm_asm_sources = &.{
    "assemble.c",
    "directbl.c",
    "directiv.c",
    // "error.c", -- included in nasm_common
    "eval.c",
    "exprdump.c",
    "exprlib.c",
    "floats.c",
    "labels.c",
    "listing.c",
    "parser.c",
    "pptok.c",
    "pragma.c",
    "preproc.c",
    "quote.c",
    "rdstrnum.c",
    "segalloc.c",
    "srcfile.c",
    "stdscan.c",
    "strfunc.c",
    "tokhash.c",
    "uncompress.c",
    // "warnings.c", -- included in nasm_common
    "nasm.c",
};

const nasm_disasm_sources = &.{
    "disasm.c",
    "ndisasm.c",
    "sync.c",
    "prefix.c",
};

const elftest64_output_part1 =
    \\Testing lrotate: should get 0x00400000, 0x00000001
    \\lrotate(0x00040000, 4) = 0x00400000
    \\lrotate(0x00040000, 46) = 0x00000001
    \\This string should read `hello, world': `hello, world'
;

// TODO: These addresses seem to be flaky.
// &integer = 0x102f788, &commvar = 0x102f798

const elftest64_output_part2 =
    \\The integers here should be 1234, 1235 and 4321:
    \\integer=1234, localint=1235, commvar=4321
    \\integer=1234, localint=1235, commvar=4321
    // TODO: Parse this in a run step.
    //These pointers should be equal: 0x1009ef4 and 0x1009ef4
    //So should these: 0x102f63d and 0x102f63d
;

const cofftest_output =
    "Testing lrotate: should get 0x00400000, 0x00000001\r\n" ++
    "lrotate(0x00040000, 4) = 0x00400000\r\n" ++
    "lrotate(0x00040000, 14) = 0x00000001\r\n" ++
    "This string should read `hello, world': `hello, world'\r\n" ++
    "The integers here should be 1234, 1235 and 4321:\r\n" ++
    "integer==1234, localint==1235, commvar=4321"
// TODO: Parse this in a run step.
//These pointers should be equal: 00401011 and 00401011
//So should these: 0049303C and 0049303C
;
