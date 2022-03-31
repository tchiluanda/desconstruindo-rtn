library(tidyverse)
library(ckanr)
library(readxl)

id_2022 <- '96744fdd-91c6-46e0-a1c4-253fae51936c'
id_2021 <- 'a66311e0-fb60-4354-b6d4-5ed3dbe7b297'
id_ <- id_2021

recurso_Teto <- resource_show(id=id_,
                            url="http://www.tesourotransparente.gov.br/ckan")
download.file(recurso_Teto$url, destfile = "dados-teto.xlsx", mode = 'wb' )

tabela <- read_excel("dados-teto.xlsx", sheet = "2021")

sumario <- tabela %>%
  group_by(
    NO_GRUPO_DESPESA_NADE,
    NO_MOAP_NADE,
    NO_FUNCAO_PT,
    NO_SUBFUNCAO_PT,
    CATEGORIA_RTN) %>%
  summarise(valor = sum(PAGAMENTOS_TOTAIS)) %>%
  ungroup() %>%
  filter(CATEGORIA_RTN != 'N/A')
