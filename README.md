nestedXML
================

nestedXML is a package for read and convert nested XML files to friendly
formats. It was created to make it easier to read large ticketing files
from public transport systems into R data.frames.

## Instalação

You can install the development version from GitHub with

``` r
remotes::install_github("gustavo234guimaraes/nestedXML")
```

## Motivating examples

### Data

Example data can be found at:
[**`Fortaleza dados  abertos`**](https://dados.fortaleza.ce.gov.br/dataset/bilhetagem_01_2014).

### Read data example

You can read a XML into R in data.frame using `read_xml`.

``` r
library(nestedXML)

xml_files<-list.files(
  pattern = "\\.xml",
  recursive = TRUE,
  full.names = TRUE
)
xml_files
```

    ## [1] "./V20140101.xml" "./V20140102.xml" "./V20140113.xml"

``` r
df<-read_xml(xml_files[1])

head(df)
```

    ##     data_arq Categoria.data_mov Empresa.Tipo Veiculo.Codigo Veiculo.modalidade
    ## 1 2014-01-01         2013-12-28            1            036                  1
    ## 2 2014-01-01         2013-12-28            1            036                  1
    ## 3 2014-01-01         2013-12-28            1            036                  1
    ## 4 2014-01-01         2013-12-28            1            036                  1
    ## 5 2014-01-01         2013-12-28            1            036                  1
    ## 6 2014-01-01         2013-12-28            1            036                  1
    ##   Linha.Numero Linha.validador Viagem.Numero Viagem.tabela
    ## 1        36301            834K            51            14
    ## 2        36301            834K            51            14
    ## 3        36301            834K            51            14
    ## 4        36301            834K            51            14
    ## 5        36301            834K            51            14
    ## 6        36301            834K            51            14
    ##   Passageiro.data_hora_abertura Passageiro.data_hora_fechamento
    ## 1           2013-12-28T05:41:35             2013-12-28T06:02:04
    ## 2           2013-12-28T05:41:35             2013-12-28T06:02:04
    ## 3           2013-12-28T05:41:35             2013-12-28T06:02:04
    ## 4           2013-12-28T05:41:35             2013-12-28T06:02:04
    ## 5           2013-12-28T05:41:35             2013-12-28T06:02:04
    ## 6           2013-12-28T05:41:35             2013-12-28T06:02:04
    ##   Passageiro.catraca_inicio Passageiro.catraca_final Passageiro.sentido
    ## 1                     36736                    36756                  0
    ## 2                     36736                    36756                  0
    ## 3                     36736                    36756                  0
    ## 4                     36736                    36756                  0
    ## 5                     36736                    36756                  0
    ## 6                     36736                    36756                  0
    ##      Matricula tipo           data_hora valor_pago integracao sigben
    ## 1 ChgXFpExBr8=    0 2013-12-28T05:47:21        2.2          0      0
    ## 2 ChgXFpExBr8=    0 2013-12-28T05:49:24        2.2          0      0
    ## 3 ChgXFpExBr8=    0 2013-12-28T05:52:03        2.2          0      0
    ## 4 EDJN0rI+/bM=    4 2013-12-28T05:53:11        2.2          0      0
    ## 5 dXdTWNDyyAQ=    4 2013-12-28T05:53:59        2.2          0      0
    ## 6 1TgfIARG8dk=    4 2013-12-28T05:54:28        2.2          0      0

### Convert data example

You can convert a XML to a friendly format like .csv or .rds using
convert_xml.

``` r
library(nestedXML)

xml_files<-list.files(
  pattern = "\\.xml",
  recursive = TRUE,
  full.names = TRUE
)
xml_files
```

    ## [1] "./V20140101.xml" "./V20140102.xml" "./V20140113.xml"

``` r
ini<-Sys.time()
lapply(xml_files, convert_xml)
```

    ## [[1]]
    ## [1] TRUE
    ## 
    ## [[2]]
    ## [1] TRUE
    ## 
    ## [[3]]
    ## [1] TRUE

``` r
Sys.time()-ini
```

    ## Time difference of 8.341527 mins

``` r
list.files(pattern = ".csv",recursive = T)
```

    ## [1] "V20140101.csv" "V20140102.csv" "V20140113.csv"

You can use parallel to convert data quickly, use .rds to generate
lightweight files.

``` r
library(nestedXML)
library(parallel)

xml_files<-list.files(
  pattern = "\\.xml",
  recursive = TRUE,
  full.names = TRUE
)
xml_files
```

    ## [1] "./V20140101.xml" "./V20140102.xml" "./V20140113.xml"

``` r
cl<-makeCluster(detectCores(logical = F))

ini<-Sys.time()
parLapply(cl=cl,xml_files, convert_xml, ext=".rds")
```

    ## [[1]]
    ## [1] TRUE
    ## 
    ## [[2]]
    ## [1] TRUE
    ## 
    ## [[3]]
    ## [1] TRUE

``` r
Sys.time()-ini
```

    ## Time difference of 4.129895 mins

``` r
list.files(pattern = ".rds",recursive = T)
```

    ## [1] "V20140101.rds" "V20140102.rds" "V20140113.rds"
