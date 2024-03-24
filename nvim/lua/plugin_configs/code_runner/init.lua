require('code_runner').setup({
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt &&",
          "rm *.class",
        },
        python = { "cd $dir && python $fileName" },
        cpp = { "cd $dir && clang++ -std=c++20 $fileName && ./a.out && rm ./a.out" },
        c = { "cd $dir && gcc $fileName && ./a.out && rm ./a.out" },
        go = { "cd $dir && go run ." },
        rust = { "cd $dir && rustc $fileName && ./$fileNameWithoutExt && rm ./$fileNameWithoutExt" },
      },
})

