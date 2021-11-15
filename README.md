# Docker-MetaboanalystR

## 注意点
* R の各種ライブラリのコンパイルに大きなメモリを要するため Docker のメモリをあらかじめ増やしておくこと。

## Docker 起動（1 分程度かかる）

* docker survice を build する
* image が export され contanier が起動する

```
# docker-compose up -d --build
```

* 作成されたコンテナの中に入る

```
$ docker-compose exec docker-metaboanalystr bash
```

* コンテナの中で ``src/`` に移動する。
* ここでホスト側の ``src/`` とマウントできる。

```
# cd src
```

* ``R`` と入力して、R コンソールを起動する。
* 4.1.2v を起動した場合、以下のようなメッセージが表示される。

```
# R

R version 4.1.2 (2021-11-01) -- "Bird Hippie"
Copyright (C) 2021 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.
```

* 以下 https://github.com/xia-lab/MetaboAnalystR に従って R コンソールを操作し
* MetaboanalystR をインストールする。

## MetaboanalystR に必要な各種 R package のインストール（30 分程度かかる）

### Option 1:

```R
metanr_packages <- function(){

  metr_pkgs <- c("impute", "pcaMethods", "globaltest", "GlobalAncova", "Rgraphviz", "preprocessCore", "genefilter", "SSPA", "sva", "limma", "KEGGgraph", "siggenes","BiocParallel", "MSnbase", "multtest","RBGL","edgeR","fgsea","devtools","crmn","httr","qs")
  
  list_installed <- installed.packages()
  
  new_pkgs <- subset(metr_pkgs, !(metr_pkgs %in% list_installed[, "Package"]))
  
  if(length(new_pkgs)!=0){
    
    if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager")
    BiocManager::install(new_pkgs)
    print(c(new_pkgs, " packages added..."))
  }
  
  if((length(new_pkgs)<1)){
    print("No new packages added...")
  }
}
metanr_packages()
```

ここで Docker のメモリ不足だと次のようなエラーが発生することがある。

```
g++: fatal error: Killed signal terminated program cc1plus
```

### Option 2:

```R
install.packages("pacman")

library(pacman)

pacman::p_load(c("impute", "pcaMethods", "globaltest", "GlobalAncova", "Rgraphviz", "preprocessCore", "genefilter", "SSPA", "sva", "limma", "KEGGgraph", "siggenes","BiocParallel", "MSnbase", "multtest","RBGL","edgeR","fgsea","httr","qs"))
```

## MetaboanalystR のインストール （10 分程度かかる）

ただし Step2 は https://github.com/xia-lab/MetaboAnalystR に記載されていない工程のため注意。

Step 2 では、パッケージ依存の関係で ``OptiLCMS`` を個別にインストールしている。
参考: https://github.com/xia-lab/OptiLCMS/issues/1

```R
# Step 1: Install devtools
install.packages("devtools")
library(devtools)

# Step 2: Install OptiLCMS
devtools::install_github("xia-lab/OptiLCMS", build = TRUE, build_vignettes = FALSE, build_manual =T)

# Step 3: Install MetaboAnalystR with documentation
devtools::install_github("xia-lab/MetaboAnalystR", build = TRUE, build_vignettes = TRUE, build_manual =T)
```

* MetaboanalystR をインポートしてみる。

```R
library('MetaboAnalystR')
```

* 以下のように表示されれば成功。

```R
MetaboAnalystR 3.1.0 initialized Successfully !
https://github.com/xia-lab/MetaboAnalystR
```