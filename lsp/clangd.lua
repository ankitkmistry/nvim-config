return {
    cmd = {
        "clangd",
        "--all-scopes-completion",
        "--background-index",
        "--clang-tidy",
        "--completion-style=bundled",
        "--fallback-style=llvm",
        "--function-arg-placeholders",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
        "--log=error",
        "--offset-encoding=utf-8",
        "--pch-storage=memory",
        "--rename-file-limit=0",
        "-j=2",
    },
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
        fallbackFlags = { "-std=c++20" },
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    settings = {
        clangd = {
            fallbackFlags = { "-std=c++20" },
        },
    },
}
